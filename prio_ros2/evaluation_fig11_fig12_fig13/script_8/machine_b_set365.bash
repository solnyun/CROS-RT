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
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_1 -p 66 -st topic365_0_0 -pt topic365_0_1 -u 0.05041692950554166 > ./result_8chains/node365_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_1 -p 154 -st topic365_1_0 -pt topic365_1_1 -u 0.04578461061656092 > ./result_8chains/node365_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_1 -p 386 -st topic365_2_0 -pt topic365_2_1 -u 0.057356220800988456 > ./result_8chains/node365_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_1 -p 456 -st topic365_3_0 -pt topic365_3_1 -u 0.015743242513147043 > ./result_8chains/node365_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_1 -p 623 -st topic365_4_0 -pt topic365_4_1 -u 0.01932134388533427 > ./result_8chains/node365_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_1 -p 722 -st topic365_5_0 -pt topic365_5_1 -u 0.006335570475267102 > ./result_8chains/node365_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_6_1 -p 835 -st topic365_6_0 -pt topic365_6_1 -u 0.015312546977406388 > ./result_8chains/node365_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_7_1 -p 849 -st topic365_7_0 -pt topic365_7_1 -u 0.059002424637186364 > ./result_8chains/node365_7_1.txt &
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
    "./result_8chains/node365_0_1.txt 90"
    "./result_8chains/node365_1_1.txt 89"
    "./result_8chains/node365_2_1.txt 88"
    "./result_8chains/node365_3_1.txt 87"
    "./result_8chains/node365_4_1.txt 86"
    "./result_8chains/node365_5_1.txt 85"
    "./result_8chains/node365_6_1.txt 84"
    "./result_8chains/node365_7_1.txt 83"
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
