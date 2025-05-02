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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_2 -p 149 -st topic321_0_1 -pt None -u 0.0003532278608172068 > ./result_6chains/node321_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_2 -p 303 -st topic321_1_1 -pt None -u 0.002551107191698321 > ./result_6chains/node321_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_2 -p 395 -st topic321_2_1 -pt None -u 0.009343936937067088 > ./result_6chains/node321_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_2 -p 742 -st topic321_3_1 -pt None -u 0.0537402104789555 > ./result_6chains/node321_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_2 -p 749 -st topic321_4_1 -pt None -u 0.0013086612602347114 > ./result_6chains/node321_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_2 -p 846 -st topic321_5_1 -pt None -u 0.05352307574325215 > ./result_6chains/node321_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_0 -p 149 -st none -pt topic321_0_0 -u 0.01835450889678858 > ./result_6chains/node321_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_0 -p 303 -st none -pt topic321_1_0 -u 0.07066879809129084 > ./result_6chains/node321_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_0 -p 395 -st none -pt topic321_2_0 -u 0.005431070933404281 > ./result_6chains/node321_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_0 -p 742 -st none -pt topic321_3_0 -u 0.012543301283922503 > ./result_6chains/node321_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_0 -p 749 -st none -pt topic321_4_0 -u 0.05872859864332128 > ./result_6chains/node321_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_0 -p 846 -st none -pt topic321_5_0 -u 0.01268675911101963 > ./result_6chains/node321_5_0.txt &
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
    "./result_6chains/node321_0_0.txt 90"
    "./result_6chains/node321_0_2.txt 90"
    "./result_6chains/node321_1_0.txt 89"
    "./result_6chains/node321_1_2.txt 89"
    "./result_6chains/node321_2_0.txt 88"
    "./result_6chains/node321_2_2.txt 88"
    "./result_6chains/node321_3_0.txt 87"
    "./result_6chains/node321_3_2.txt 87"
    "./result_6chains/node321_4_0.txt 86"
    "./result_6chains/node321_4_2.txt 86"
    "./result_6chains/node321_5_0.txt 85"
    "./result_6chains/node321_5_2.txt 85"
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
