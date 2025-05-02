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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_2 -p 18 -st topic492_0_1 -pt None -u 0.06938372785349778 > ./result_6chains/node492_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_2 -p 190 -st topic492_1_1 -pt None -u 0.005238407190486738 > ./result_6chains/node492_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_2 -p 301 -st topic492_2_1 -pt None -u 0.0039100921519906184 > ./result_6chains/node492_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_2 -p 544 -st topic492_3_1 -pt None -u 0.0030515483462417725 > ./result_6chains/node492_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_2 -p 743 -st topic492_4_1 -pt None -u 0.07843833538531064 > ./result_6chains/node492_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_2 -p 937 -st topic492_5_1 -pt None -u 0.031462679536340854 > ./result_6chains/node492_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_0 -p 18 -st none -pt topic492_0_0 -u 0.004665569892108645 > ./result_6chains/node492_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_0 -p 190 -st none -pt topic492_1_0 -u 0.019660995440091755 > ./result_6chains/node492_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_0 -p 301 -st none -pt topic492_2_0 -u 0.029179247300730238 > ./result_6chains/node492_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_0 -p 544 -st none -pt topic492_3_0 -u 0.0021483935743767113 > ./result_6chains/node492_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_0 -p 743 -st none -pt topic492_4_0 -u 0.0057667211717598865 > ./result_6chains/node492_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_0 -p 937 -st none -pt topic492_5_0 -u 0.020540985471192492 > ./result_6chains/node492_5_0.txt &
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
    "./result_6chains/node492_0_0.txt 90"
    "./result_6chains/node492_0_2.txt 90"
    "./result_6chains/node492_1_0.txt 89"
    "./result_6chains/node492_1_2.txt 89"
    "./result_6chains/node492_2_0.txt 88"
    "./result_6chains/node492_2_2.txt 88"
    "./result_6chains/node492_3_0.txt 87"
    "./result_6chains/node492_3_2.txt 87"
    "./result_6chains/node492_4_0.txt 86"
    "./result_6chains/node492_4_2.txt 86"
    "./result_6chains/node492_5_0.txt 85"
    "./result_6chains/node492_5_2.txt 85"
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
