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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_1 -p 30 -st topic40_0_0 -pt topic40_0_1 -u 0.001117947225855731 > ./result_8chains/node40_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_1 -p 91 -st topic40_1_0 -pt topic40_1_1 -u 0.051656203342124285 > ./result_8chains/node40_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_1 -p 388 -st topic40_2_0 -pt topic40_2_1 -u 0.011410182326106577 > ./result_8chains/node40_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_1 -p 458 -st topic40_3_0 -pt topic40_3_1 -u 2.8668304093371066e-05 > ./result_8chains/node40_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_1 -p 549 -st topic40_4_0 -pt topic40_4_1 -u 0.010871365881857775 > ./result_8chains/node40_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_1 -p 591 -st topic40_5_0 -pt topic40_5_1 -u 0.03357737244913525 > ./result_8chains/node40_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_1 -p 650 -st topic40_6_0 -pt topic40_6_1 -u 0.004480370514356069 > ./result_8chains/node40_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_1 -p 916 -st topic40_7_0 -pt topic40_7_1 -u 0.03273411230222309 > ./result_8chains/node40_7_1.txt &
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
    "./result_8chains/node40_0_1.txt 90"
    "./result_8chains/node40_1_1.txt 89"
    "./result_8chains/node40_2_1.txt 88"
    "./result_8chains/node40_3_1.txt 87"
    "./result_8chains/node40_4_1.txt 86"
    "./result_8chains/node40_5_1.txt 85"
    "./result_8chains/node40_6_1.txt 84"
    "./result_8chains/node40_7_1.txt 83"
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
