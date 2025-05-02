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
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_1 -p 269 -st topic142_0_0 -pt topic142_0_1 -u 0.0019723574597428906 > ./result_8chains/node142_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_1 -p 270 -st topic142_1_0 -pt topic142_1_1 -u 0.0031663555134947563 > ./result_8chains/node142_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_1 -p 304 -st topic142_2_0 -pt topic142_2_1 -u 0.05741181186685729 > ./result_8chains/node142_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_1 -p 351 -st topic142_3_0 -pt topic142_3_1 -u 0.02857576278398616 > ./result_8chains/node142_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_1 -p 556 -st topic142_4_0 -pt topic142_4_1 -u 0.030536803790065764 > ./result_8chains/node142_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_1 -p 861 -st topic142_5_0 -pt topic142_5_1 -u 0.0004967016984907258 > ./result_8chains/node142_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_1 -p 918 -st topic142_6_0 -pt topic142_6_1 -u 0.034199012549661165 > ./result_8chains/node142_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_1 -p 967 -st topic142_7_0 -pt topic142_7_1 -u 0.014342021993561223 > ./result_8chains/node142_7_1.txt &
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
    "./result_8chains/node142_0_1.txt 90"
    "./result_8chains/node142_1_1.txt 89"
    "./result_8chains/node142_2_1.txt 88"
    "./result_8chains/node142_3_1.txt 87"
    "./result_8chains/node142_4_1.txt 86"
    "./result_8chains/node142_5_1.txt 85"
    "./result_8chains/node142_6_1.txt 84"
    "./result_8chains/node142_7_1.txt 83"
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
