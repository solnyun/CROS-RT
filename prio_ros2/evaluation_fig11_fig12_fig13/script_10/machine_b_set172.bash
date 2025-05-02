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
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_1 -p 374 -st topic172_0_0 -pt topic172_0_1 -u 0.004244100618839675 > ./result_10chains/node172_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_1 -p 471 -st topic172_1_0 -pt topic172_1_1 -u 0.015591787991803274 > ./result_10chains/node172_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_1 -p 575 -st topic172_2_0 -pt topic172_2_1 -u 0.030987611967001172 > ./result_10chains/node172_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_1 -p 663 -st topic172_3_0 -pt topic172_3_1 -u 0.025233628508876504 > ./result_10chains/node172_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_1 -p 731 -st topic172_4_0 -pt topic172_4_1 -u 0.009116690052639598 > ./result_10chains/node172_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_1 -p 791 -st topic172_5_0 -pt topic172_5_1 -u 0.041210527623310234 > ./result_10chains/node172_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_6_1 -p 792 -st topic172_6_0 -pt topic172_6_1 -u 0.002270900882364285 > ./result_10chains/node172_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_7_1 -p 809 -st topic172_7_0 -pt topic172_7_1 -u 0.027380479815499417 > ./result_10chains/node172_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_8_1 -p 830 -st topic172_8_0 -pt topic172_8_1 -u 0.007063716398331477 > ./result_10chains/node172_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_9_1 -p 891 -st topic172_9_0 -pt topic172_9_1 -u 0.008022911393301965 > ./result_10chains/node172_9_1.txt &
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
    "./result_10chains/node172_0_1.txt 90"
    "./result_10chains/node172_1_1.txt 89"
    "./result_10chains/node172_2_1.txt 88"
    "./result_10chains/node172_3_1.txt 87"
    "./result_10chains/node172_4_1.txt 86"
    "./result_10chains/node172_5_1.txt 85"
    "./result_10chains/node172_6_1.txt 84"
    "./result_10chains/node172_7_1.txt 83"
    "./result_10chains/node172_8_1.txt 82"
    "./result_10chains/node172_9_1.txt 81"
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
