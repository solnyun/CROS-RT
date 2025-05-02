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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_1 -p 71 -st topic74_0_0 -pt topic74_0_1 -u 0.08435502519986027 > ./result_8chains/node74_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_1 -p 200 -st topic74_1_0 -pt topic74_1_1 -u 0.005538179721318814 > ./result_8chains/node74_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_1 -p 451 -st topic74_2_0 -pt topic74_2_1 -u 0.029772237876222574 > ./result_8chains/node74_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_1 -p 762 -st topic74_3_0 -pt topic74_3_1 -u 0.00018967735833580468 > ./result_8chains/node74_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_1 -p 811 -st topic74_4_0 -pt topic74_4_1 -u 0.02010443711535201 > ./result_8chains/node74_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_1 -p 843 -st topic74_5_0 -pt topic74_5_1 -u 0.004090767894730396 > ./result_8chains/node74_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_1 -p 852 -st topic74_6_0 -pt topic74_6_1 -u 0.0022181411262085643 > ./result_8chains/node74_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_1 -p 995 -st topic74_7_0 -pt topic74_7_1 -u 0.031547444989420866 > ./result_8chains/node74_7_1.txt &
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
    "./result_8chains/node74_0_1.txt 90"
    "./result_8chains/node74_1_1.txt 89"
    "./result_8chains/node74_2_1.txt 88"
    "./result_8chains/node74_3_1.txt 87"
    "./result_8chains/node74_4_1.txt 86"
    "./result_8chains/node74_5_1.txt 85"
    "./result_8chains/node74_6_1.txt 84"
    "./result_8chains/node74_7_1.txt 83"
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
