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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_1 -p 44 -st topic116_0_0 -pt topic116_0_1 -u 0.034458339202345256 > ./result_6chains/node116_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_1 -p 153 -st topic116_1_0 -pt topic116_1_1 -u 0.0189739701735272 > ./result_6chains/node116_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_1 -p 174 -st topic116_2_0 -pt topic116_2_1 -u 0.035606932381152145 > ./result_6chains/node116_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_1 -p 221 -st topic116_3_0 -pt topic116_3_1 -u 9.272282259389919e-05 > ./result_6chains/node116_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_1 -p 314 -st topic116_4_0 -pt topic116_4_1 -u 0.04599435384253035 > ./result_6chains/node116_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_1 -p 913 -st topic116_5_0 -pt topic116_5_1 -u 0.044336694829092936 > ./result_6chains/node116_5_1.txt &
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
    "./result_6chains/node116_0_1.txt 90"
    "./result_6chains/node116_1_1.txt 89"
    "./result_6chains/node116_2_1.txt 88"
    "./result_6chains/node116_3_1.txt 87"
    "./result_6chains/node116_4_1.txt 86"
    "./result_6chains/node116_5_1.txt 85"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
