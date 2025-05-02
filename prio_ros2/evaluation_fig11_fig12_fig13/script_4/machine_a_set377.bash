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
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_2 -p 178 -st topic377_0_1 -pt None -u 0.017453544088356476 > ./result_4chains/node377_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_2 -p 198 -st topic377_1_1 -pt None -u 0.028903281352605947 > ./result_4chains/node377_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_2 -p 424 -st topic377_2_1 -pt None -u 0.09892914960338814 > ./result_4chains/node377_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_2 -p 844 -st topic377_3_1 -pt None -u 0.00819236350510321 > ./result_4chains/node377_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_0 -p 178 -st none -pt topic377_0_0 -u 0.0073665502515731784 > ./result_4chains/node377_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_0 -p 198 -st none -pt topic377_1_0 -u 0.09566998336313709 > ./result_4chains/node377_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_0 -p 424 -st none -pt topic377_2_0 -u 0.010724641029427329 > ./result_4chains/node377_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_0 -p 844 -st none -pt topic377_3_0 -u 0.01864249963325019 > ./result_4chains/node377_3_0.txt &
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
    "./result_4chains/node377_0_0.txt 90"
    "./result_4chains/node377_0_2.txt 90"
    "./result_4chains/node377_1_0.txt 89"
    "./result_4chains/node377_1_2.txt 89"
    "./result_4chains/node377_2_0.txt 88"
    "./result_4chains/node377_2_2.txt 88"
    "./result_4chains/node377_3_0.txt 87"
    "./result_4chains/node377_3_2.txt 87"
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
