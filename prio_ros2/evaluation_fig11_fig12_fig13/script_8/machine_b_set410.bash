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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_1 -p 119 -st topic410_0_0 -pt topic410_0_1 -u 0.05430752187552079 > ./result_8chains/node410_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_1 -p 173 -st topic410_1_0 -pt topic410_1_1 -u 0.028366126668137093 > ./result_8chains/node410_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_1 -p 241 -st topic410_2_0 -pt topic410_2_1 -u 0.026852083822398343 > ./result_8chains/node410_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_1 -p 583 -st topic410_3_0 -pt topic410_3_1 -u 0.032352557623514355 > ./result_8chains/node410_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_1 -p 586 -st topic410_4_0 -pt topic410_4_1 -u 0.017453371224215447 > ./result_8chains/node410_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_1 -p 649 -st topic410_5_0 -pt topic410_5_1 -u 0.00935575249038248 > ./result_8chains/node410_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_1 -p 690 -st topic410_6_0 -pt topic410_6_1 -u 0.0382531051735009 > ./result_8chains/node410_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_1 -p 853 -st topic410_7_0 -pt topic410_7_1 -u 0.008335463890116631 > ./result_8chains/node410_7_1.txt &
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
    "./result_8chains/node410_0_1.txt 90"
    "./result_8chains/node410_1_1.txt 89"
    "./result_8chains/node410_2_1.txt 88"
    "./result_8chains/node410_3_1.txt 87"
    "./result_8chains/node410_4_1.txt 86"
    "./result_8chains/node410_5_1.txt 85"
    "./result_8chains/node410_6_1.txt 84"
    "./result_8chains/node410_7_1.txt 83"
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
