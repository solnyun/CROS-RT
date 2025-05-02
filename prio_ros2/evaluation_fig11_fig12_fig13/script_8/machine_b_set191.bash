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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_1 -p 60 -st topic191_0_0 -pt topic191_0_1 -u 0.006584987318835944 > ./result_8chains/node191_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_1 -p 171 -st topic191_1_0 -pt topic191_1_1 -u 0.0049525666304851 > ./result_8chains/node191_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_1 -p 541 -st topic191_2_0 -pt topic191_2_1 -u 0.010464962132292366 > ./result_8chains/node191_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_1 -p 638 -st topic191_3_0 -pt topic191_3_1 -u 0.05903236603615278 > ./result_8chains/node191_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_1 -p 639 -st topic191_4_0 -pt topic191_4_1 -u 0.002013457860105372 > ./result_8chains/node191_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_1 -p 708 -st topic191_5_0 -pt topic191_5_1 -u 0.022104660940737736 > ./result_8chains/node191_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_1 -p 806 -st topic191_6_0 -pt topic191_6_1 -u 0.003883548769020223 > ./result_8chains/node191_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_1 -p 963 -st topic191_7_0 -pt topic191_7_1 -u 0.026563072376692178 > ./result_8chains/node191_7_1.txt &
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
    "./result_8chains/node191_0_1.txt 90"
    "./result_8chains/node191_1_1.txt 89"
    "./result_8chains/node191_2_1.txt 88"
    "./result_8chains/node191_3_1.txt 87"
    "./result_8chains/node191_4_1.txt 86"
    "./result_8chains/node191_5_1.txt 85"
    "./result_8chains/node191_6_1.txt 84"
    "./result_8chains/node191_7_1.txt 83"
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
