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
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_2 -p 80 -st topic325_0_1 -pt None -u 0.06578269124046948 > ./result_6chains/node325_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_2 -p 161 -st topic325_1_1 -pt None -u 0.0025338010704166747 > ./result_6chains/node325_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_2 -p 765 -st topic325_2_1 -pt None -u 0.0014326415834243766 > ./result_6chains/node325_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_2 -p 830 -st topic325_3_1 -pt None -u 0.022124150914868218 > ./result_6chains/node325_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_2 -p 843 -st topic325_4_1 -pt None -u 0.001974137719289476 > ./result_6chains/node325_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_2 -p 892 -st topic325_5_1 -pt None -u 0.05691825414790031 > ./result_6chains/node325_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_0 -p 80 -st none -pt topic325_0_0 -u 0.024798430001441107 > ./result_6chains/node325_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_0 -p 161 -st none -pt topic325_1_0 -u 0.012463799031929845 > ./result_6chains/node325_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_0 -p 765 -st none -pt topic325_2_0 -u 0.008372108738004147 > ./result_6chains/node325_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_0 -p 830 -st none -pt topic325_3_0 -u 0.013685075479692221 > ./result_6chains/node325_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_0 -p 843 -st none -pt topic325_4_0 -u 0.054773809451000965 > ./result_6chains/node325_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_0 -p 892 -st none -pt topic325_5_0 -u 0.02640619458030316 > ./result_6chains/node325_5_0.txt &
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
    "./result_6chains/node325_0_0.txt 90"
    "./result_6chains/node325_0_2.txt 90"
    "./result_6chains/node325_1_0.txt 89"
    "./result_6chains/node325_1_2.txt 89"
    "./result_6chains/node325_2_0.txt 88"
    "./result_6chains/node325_2_2.txt 88"
    "./result_6chains/node325_3_0.txt 87"
    "./result_6chains/node325_3_2.txt 87"
    "./result_6chains/node325_4_0.txt 86"
    "./result_6chains/node325_4_2.txt 86"
    "./result_6chains/node325_5_0.txt 85"
    "./result_6chains/node325_5_2.txt 85"
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
