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
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_2 -p 50 -st topic156_0_1 -pt None -u 0.0299303321090707 > ./result_6chains/node156_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_2 -p 470 -st topic156_1_1 -pt None -u 0.0009824927670031847 > ./result_6chains/node156_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_2 -p 491 -st topic156_2_1 -pt None -u 0.02309484583995053 > ./result_6chains/node156_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_2 -p 628 -st topic156_3_1 -pt None -u 0.006627638344912451 > ./result_6chains/node156_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_2 -p 689 -st topic156_4_1 -pt None -u 0.01160375077861571 > ./result_6chains/node156_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_2 -p 888 -st topic156_5_1 -pt None -u 0.027965908128088964 > ./result_6chains/node156_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_0 -p 50 -st none -pt topic156_0_0 -u 0.03715753195033844 > ./result_6chains/node156_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_0 -p 470 -st none -pt topic156_1_0 -u 0.05136803545192675 > ./result_6chains/node156_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_0 -p 491 -st none -pt topic156_2_0 -u 0.013634455066560025 > ./result_6chains/node156_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_0 -p 628 -st none -pt topic156_3_0 -u 0.079281778993947 > ./result_6chains/node156_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_0 -p 689 -st none -pt topic156_4_0 -u 0.027306357350157323 > ./result_6chains/node156_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_0 -p 888 -st none -pt topic156_5_0 -u 0.028496613201011073 > ./result_6chains/node156_5_0.txt &
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
    "./result_6chains/node156_0_0.txt 90"
    "./result_6chains/node156_0_2.txt 90"
    "./result_6chains/node156_1_0.txt 89"
    "./result_6chains/node156_1_2.txt 89"
    "./result_6chains/node156_2_0.txt 88"
    "./result_6chains/node156_2_2.txt 88"
    "./result_6chains/node156_3_0.txt 87"
    "./result_6chains/node156_3_2.txt 87"
    "./result_6chains/node156_4_0.txt 86"
    "./result_6chains/node156_4_2.txt 86"
    "./result_6chains/node156_5_0.txt 85"
    "./result_6chains/node156_5_2.txt 85"
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
