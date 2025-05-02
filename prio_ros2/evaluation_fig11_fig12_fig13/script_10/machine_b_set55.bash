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
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_1 -p 121 -st topic55_0_0 -pt topic55_0_1 -u 0.0035878949639472912 > ./result_10chains/node55_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_1 -p 206 -st topic55_1_0 -pt topic55_1_1 -u 0.030200743733210855 > ./result_10chains/node55_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_1 -p 373 -st topic55_2_0 -pt topic55_2_1 -u 0.021556018790115206 > ./result_10chains/node55_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_1 -p 548 -st topic55_3_0 -pt topic55_3_1 -u 0.029795668182945434 > ./result_10chains/node55_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_1 -p 581 -st topic55_4_0 -pt topic55_4_1 -u 0.0055423428790707385 > ./result_10chains/node55_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_1 -p 586 -st topic55_5_0 -pt topic55_5_1 -u 0.004461214768703675 > ./result_10chains/node55_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_6_1 -p 665 -st topic55_6_0 -pt topic55_6_1 -u 0.0006088501057697759 > ./result_10chains/node55_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_7_1 -p 734 -st topic55_7_0 -pt topic55_7_1 -u 0.02030129111356757 > ./result_10chains/node55_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_8_1 -p 771 -st topic55_8_0 -pt topic55_8_1 -u 0.040427790369336886 > ./result_10chains/node55_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_9_1 -p 929 -st topic55_9_0 -pt topic55_9_1 -u 0.0017657545084329845 > ./result_10chains/node55_9_1.txt &
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
    "./result_10chains/node55_0_1.txt 90"
    "./result_10chains/node55_1_1.txt 89"
    "./result_10chains/node55_2_1.txt 88"
    "./result_10chains/node55_3_1.txt 87"
    "./result_10chains/node55_4_1.txt 86"
    "./result_10chains/node55_5_1.txt 85"
    "./result_10chains/node55_6_1.txt 84"
    "./result_10chains/node55_7_1.txt 83"
    "./result_10chains/node55_8_1.txt 82"
    "./result_10chains/node55_9_1.txt 81"
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
