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
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_2 -p 468 -st topic55_0_1 -pt None -u 0.09231820260313167 > ./result_6chains/node55_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_2 -p 478 -st topic55_1_1 -pt None -u 0.03017282632797319 > ./result_6chains/node55_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_2 -p 671 -st topic55_2_1 -pt None -u 0.024953654453943402 > ./result_6chains/node55_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_2 -p 907 -st topic55_3_1 -pt None -u 0.05320164576782671 > ./result_6chains/node55_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_2 -p 925 -st topic55_4_1 -pt None -u 0.02165271663576246 > ./result_6chains/node55_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_2 -p 929 -st topic55_5_1 -pt None -u 0.011097640956280047 > ./result_6chains/node55_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_0 -p 468 -st none -pt topic55_0_0 -u 0.05703529034627658 > ./result_6chains/node55_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_0 -p 478 -st none -pt topic55_1_0 -u 0.005697131214643381 > ./result_6chains/node55_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_0 -p 671 -st none -pt topic55_2_0 -u 0.010298257749529194 > ./result_6chains/node55_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_0 -p 907 -st none -pt topic55_3_0 -u 0.007036625117788964 > ./result_6chains/node55_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_0 -p 925 -st none -pt topic55_4_0 -u 0.013255621747728277 > ./result_6chains/node55_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_0 -p 929 -st none -pt topic55_5_0 -u 0.015045426705884005 > ./result_6chains/node55_5_0.txt &
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
    "./result_6chains/node55_0_0.txt 90"
    "./result_6chains/node55_0_2.txt 90"
    "./result_6chains/node55_1_0.txt 89"
    "./result_6chains/node55_1_2.txt 89"
    "./result_6chains/node55_2_0.txt 88"
    "./result_6chains/node55_2_2.txt 88"
    "./result_6chains/node55_3_0.txt 87"
    "./result_6chains/node55_3_2.txt 87"
    "./result_6chains/node55_4_0.txt 86"
    "./result_6chains/node55_4_2.txt 86"
    "./result_6chains/node55_5_0.txt 85"
    "./result_6chains/node55_5_2.txt 85"
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
