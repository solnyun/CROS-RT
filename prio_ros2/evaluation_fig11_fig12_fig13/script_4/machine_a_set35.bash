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
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_2 -p 332 -st topic35_0_1 -pt None -u 0.018821316096868712 > ./result_4chains/node35_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_2 -p 472 -st topic35_1_1 -pt None -u 0.06878055862653296 > ./result_4chains/node35_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_2 -p 698 -st topic35_2_1 -pt None -u 0.010562687169082631 > ./result_4chains/node35_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_2 -p 808 -st topic35_3_1 -pt None -u 0.002931436414788319 > ./result_4chains/node35_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_0 -p 332 -st none -pt topic35_0_0 -u 0.09182586116485669 > ./result_4chains/node35_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_0 -p 472 -st none -pt topic35_1_0 -u 0.12504931404203826 > ./result_4chains/node35_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_0 -p 698 -st none -pt topic35_2_0 -u 0.02080840622094486 > ./result_4chains/node35_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_0 -p 808 -st none -pt topic35_3_0 -u 0.014626831107447377 > ./result_4chains/node35_3_0.txt &
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
    "./result_4chains/node35_0_0.txt 90"
    "./result_4chains/node35_0_2.txt 90"
    "./result_4chains/node35_1_0.txt 89"
    "./result_4chains/node35_1_2.txt 89"
    "./result_4chains/node35_2_0.txt 88"
    "./result_4chains/node35_2_2.txt 88"
    "./result_4chains/node35_3_0.txt 87"
    "./result_4chains/node35_3_2.txt 87"
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
