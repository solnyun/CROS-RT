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
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_2 -p 275 -st topic396_0_1 -pt None -u 0.011283088962922128 > ./result_6chains/node396_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_2 -p 382 -st topic396_1_1 -pt None -u 0.0010227378505024975 > ./result_6chains/node396_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_2 -p 429 -st topic396_2_1 -pt None -u 0.022474845552184652 > ./result_6chains/node396_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_2 -p 709 -st topic396_3_1 -pt None -u 0.007569851684247592 > ./result_6chains/node396_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_2 -p 715 -st topic396_4_1 -pt None -u 0.09541152051528745 > ./result_6chains/node396_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_2 -p 757 -st topic396_5_1 -pt None -u 0.07777345548311854 > ./result_6chains/node396_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_0 -p 275 -st none -pt topic396_0_0 -u 0.05954807061467943 > ./result_6chains/node396_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_0 -p 382 -st none -pt topic396_1_0 -u 0.0012223039635654853 > ./result_6chains/node396_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_0 -p 429 -st none -pt topic396_2_0 -u 0.006293564240729299 > ./result_6chains/node396_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_0 -p 709 -st none -pt topic396_3_0 -u 0.08169890744953257 > ./result_6chains/node396_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_0 -p 715 -st none -pt topic396_4_0 -u 0.0035649789054303382 > ./result_6chains/node396_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_0 -p 757 -st none -pt topic396_5_0 -u 0.001466785052795308 > ./result_6chains/node396_5_0.txt &
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
    "./result_6chains/node396_0_0.txt 90"
    "./result_6chains/node396_0_2.txt 90"
    "./result_6chains/node396_1_0.txt 89"
    "./result_6chains/node396_1_2.txt 89"
    "./result_6chains/node396_2_0.txt 88"
    "./result_6chains/node396_2_2.txt 88"
    "./result_6chains/node396_3_0.txt 87"
    "./result_6chains/node396_3_2.txt 87"
    "./result_6chains/node396_4_0.txt 86"
    "./result_6chains/node396_4_2.txt 86"
    "./result_6chains/node396_5_0.txt 85"
    "./result_6chains/node396_5_2.txt 85"
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
