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
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_1 -p 35 -st topic408_0_0 -pt topic408_0_1 -u 0.00075978754128464 > ./result_10chains/node408_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_1 -p 72 -st topic408_1_0 -pt topic408_1_1 -u 0.0032896727611376186 > ./result_10chains/node408_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_1 -p 76 -st topic408_2_0 -pt topic408_2_1 -u 0.004295105447479464 > ./result_10chains/node408_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_1 -p 122 -st topic408_3_0 -pt topic408_3_1 -u 0.012926893986615229 > ./result_10chains/node408_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_1 -p 197 -st topic408_4_0 -pt topic408_4_1 -u 0.01656617374509234 > ./result_10chains/node408_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_1 -p 199 -st topic408_5_0 -pt topic408_5_1 -u 0.0015416636746478085 > ./result_10chains/node408_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_6_1 -p 449 -st topic408_6_0 -pt topic408_6_1 -u 0.0035325492900190325 > ./result_10chains/node408_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_7_1 -p 474 -st topic408_7_0 -pt topic408_7_1 -u 0.02701303595956933 > ./result_10chains/node408_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_8_1 -p 867 -st topic408_8_0 -pt topic408_8_1 -u 0.045007258336402386 > ./result_10chains/node408_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_9_1 -p 964 -st topic408_9_0 -pt topic408_9_1 -u 0.011163426668519806 > ./result_10chains/node408_9_1.txt &
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
    "./result_10chains/node408_0_1.txt 90"
    "./result_10chains/node408_1_1.txt 89"
    "./result_10chains/node408_2_1.txt 88"
    "./result_10chains/node408_3_1.txt 87"
    "./result_10chains/node408_4_1.txt 86"
    "./result_10chains/node408_5_1.txt 85"
    "./result_10chains/node408_6_1.txt 84"
    "./result_10chains/node408_7_1.txt 83"
    "./result_10chains/node408_8_1.txt 82"
    "./result_10chains/node408_9_1.txt 81"
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
