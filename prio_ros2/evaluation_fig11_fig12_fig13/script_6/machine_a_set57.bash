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
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_2 -p 68 -st topic57_0_1 -pt None -u 0.011031109213820334 > ./result_6chains/node57_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_2 -p 384 -st topic57_1_1 -pt None -u 0.0006422411978867504 > ./result_6chains/node57_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_2 -p 515 -st topic57_2_1 -pt None -u 0.0037914953716191024 > ./result_6chains/node57_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_2 -p 731 -st topic57_3_1 -pt None -u 0.07640306451517662 > ./result_6chains/node57_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_2 -p 857 -st topic57_4_1 -pt None -u 0.09254620639798952 > ./result_6chains/node57_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_2 -p 870 -st topic57_5_1 -pt None -u 0.029648078731971696 > ./result_6chains/node57_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_0 -p 68 -st none -pt topic57_0_0 -u 0.02355599039788059 > ./result_6chains/node57_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_0 -p 384 -st none -pt topic57_1_0 -u 0.001840611490246502 > ./result_6chains/node57_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_0 -p 515 -st none -pt topic57_2_0 -u 0.029551839586077877 > ./result_6chains/node57_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_0 -p 731 -st none -pt topic57_3_0 -u 0.041989646763422483 > ./result_6chains/node57_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_0 -p 857 -st none -pt topic57_4_0 -u 0.005237678918438182 > ./result_6chains/node57_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_0 -p 870 -st none -pt topic57_5_0 -u 0.017205335840526616 > ./result_6chains/node57_5_0.txt &
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
    "./result_6chains/node57_0_0.txt 90"
    "./result_6chains/node57_0_2.txt 90"
    "./result_6chains/node57_1_0.txt 89"
    "./result_6chains/node57_1_2.txt 89"
    "./result_6chains/node57_2_0.txt 88"
    "./result_6chains/node57_2_2.txt 88"
    "./result_6chains/node57_3_0.txt 87"
    "./result_6chains/node57_3_2.txt 87"
    "./result_6chains/node57_4_0.txt 86"
    "./result_6chains/node57_4_2.txt 86"
    "./result_6chains/node57_5_0.txt 85"
    "./result_6chains/node57_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
