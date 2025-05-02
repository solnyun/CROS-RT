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
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_2 -p 49 -st topic465_0_1 -pt None -u 0.008933513667028381 > ./result_4chains/node465_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_2 -p 126 -st topic465_1_1 -pt None -u 0.00686416979337201 > ./result_4chains/node465_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_2 -p 556 -st topic465_2_1 -pt None -u 0.013645940399303308 > ./result_4chains/node465_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_2 -p 579 -st topic465_3_1 -pt None -u 0.10207651957563194 > ./result_4chains/node465_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_0 -p 49 -st none -pt topic465_0_0 -u 0.02975475477141798 > ./result_4chains/node465_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_0 -p 126 -st none -pt topic465_1_0 -u 0.01580676429765554 > ./result_4chains/node465_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_0 -p 556 -st none -pt topic465_2_0 -u 0.053182579620132064 > ./result_4chains/node465_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_0 -p 579 -st none -pt topic465_3_0 -u 0.02721829571707926 > ./result_4chains/node465_3_0.txt &
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
    "./result_4chains/node465_0_0.txt 90"
    "./result_4chains/node465_0_2.txt 90"
    "./result_4chains/node465_1_0.txt 89"
    "./result_4chains/node465_1_2.txt 89"
    "./result_4chains/node465_2_0.txt 88"
    "./result_4chains/node465_2_2.txt 88"
    "./result_4chains/node465_3_0.txt 87"
    "./result_4chains/node465_3_2.txt 87"
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
