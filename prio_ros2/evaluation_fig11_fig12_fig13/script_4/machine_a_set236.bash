#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_2 -p 336 -st topic236_0_1 -pt None -u 0.017938628499575227 > ./result_4chains/node236_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_2 -p 726 -st topic236_1_1 -pt None -u 0.059647754635633515 > ./result_4chains/node236_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_2 -p 965 -st topic236_2_1 -pt None -u 0.06609365640851501 > ./result_4chains/node236_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_2 -p 982 -st topic236_3_1 -pt None -u 0.057069417875867993 > ./result_4chains/node236_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_0 -p 336 -st none -pt topic236_0_0 -u 0.09355236105844372 > ./result_4chains/node236_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_0 -p 726 -st none -pt topic236_1_0 -u 0.04770787876423366 > ./result_4chains/node236_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_0 -p 965 -st none -pt topic236_2_0 -u 0.026414407007548962 > ./result_4chains/node236_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_0 -p 982 -st none -pt topic236_3_0 -u 0.005479209865480686 > ./result_4chains/node236_3_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_4chains/node236_0_0.txt 90"
    "./result_4chains/node236_0_2.txt 90"
    "./result_4chains/node236_1_0.txt 89"
    "./result_4chains/node236_1_2.txt 89"
    "./result_4chains/node236_2_0.txt 88"
    "./result_4chains/node236_2_2.txt 88"
    "./result_4chains/node236_3_0.txt 87"
    "./result_4chains/node236_3_2.txt 87"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
