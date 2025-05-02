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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_2 -p 177 -st topic20_0_1 -pt None -u 0.0071445493344290956 > ./result_4chains/node20_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_2 -p 341 -st topic20_1_1 -pt None -u 0.022998034268446765 > ./result_4chains/node20_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_2 -p 704 -st topic20_2_1 -pt None -u 0.019918801303640654 > ./result_4chains/node20_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_2 -p 725 -st topic20_3_1 -pt None -u 0.07628181659018408 > ./result_4chains/node20_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_0 -p 177 -st none -pt topic20_0_0 -u 0.10218961186822306 > ./result_4chains/node20_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_0 -p 341 -st none -pt topic20_1_0 -u 0.05067508218449951 > ./result_4chains/node20_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_0 -p 704 -st none -pt topic20_2_0 -u 0.04135421148829746 > ./result_4chains/node20_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_0 -p 725 -st none -pt topic20_3_0 -u 0.05671110495380337 > ./result_4chains/node20_3_0.txt &
sleep 10
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
    "./result_4chains/node20_0_0.txt 90"
    "./result_4chains/node20_0_2.txt 90"
    "./result_4chains/node20_1_0.txt 89"
    "./result_4chains/node20_1_2.txt 89"
    "./result_4chains/node20_2_0.txt 88"
    "./result_4chains/node20_2_2.txt 88"
    "./result_4chains/node20_3_0.txt 87"
    "./result_4chains/node20_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
