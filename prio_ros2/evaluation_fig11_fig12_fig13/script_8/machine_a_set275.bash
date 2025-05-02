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
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_2 -p 39 -st topic275_0_1 -pt None -u 0.006412038720290836 > ./result_8chains/node275_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_2 -p 260 -st topic275_1_1 -pt None -u 0.008957715384051712 > ./result_8chains/node275_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_2 -p 274 -st topic275_2_1 -pt None -u 0.007572870891814187 > ./result_8chains/node275_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_2 -p 641 -st topic275_3_1 -pt None -u 0.06943989876072698 > ./result_8chains/node275_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_2 -p 653 -st topic275_4_1 -pt None -u 0.010478771674116594 > ./result_8chains/node275_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_2 -p 668 -st topic275_5_1 -pt None -u 0.09278703347279696 > ./result_8chains/node275_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_6_2 -p 759 -st topic275_6_1 -pt None -u 0.010571996759351651 > ./result_8chains/node275_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_7_2 -p 984 -st topic275_7_1 -pt None -u 0.009427422587631335 > ./result_8chains/node275_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_0 -p 39 -st none -pt topic275_0_0 -u 0.024888638553157205 > ./result_8chains/node275_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_0 -p 260 -st none -pt topic275_1_0 -u 0.019948251680248552 > ./result_8chains/node275_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_0 -p 274 -st none -pt topic275_2_0 -u 0.02642807640837791 > ./result_8chains/node275_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_0 -p 641 -st none -pt topic275_3_0 -u 0.006888598709454186 > ./result_8chains/node275_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_0 -p 653 -st none -pt topic275_4_0 -u 0.00790031396599794 > ./result_8chains/node275_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_0 -p 668 -st none -pt topic275_5_0 -u 0.018351009562214304 > ./result_8chains/node275_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_6_0 -p 759 -st none -pt topic275_6_0 -u 0.0018176877088721954 > ./result_8chains/node275_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_7_0 -p 984 -st none -pt topic275_7_0 -u 0.018785426240250102 > ./result_8chains/node275_7_0.txt &
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
    "./result_8chains/node275_0_0.txt 90"
    "./result_8chains/node275_0_2.txt 90"
    "./result_8chains/node275_1_0.txt 89"
    "./result_8chains/node275_1_2.txt 89"
    "./result_8chains/node275_2_0.txt 88"
    "./result_8chains/node275_2_2.txt 88"
    "./result_8chains/node275_3_0.txt 87"
    "./result_8chains/node275_3_2.txt 87"
    "./result_8chains/node275_4_0.txt 86"
    "./result_8chains/node275_4_2.txt 86"
    "./result_8chains/node275_5_0.txt 85"
    "./result_8chains/node275_5_2.txt 85"
    "./result_8chains/node275_6_0.txt 84"
    "./result_8chains/node275_6_2.txt 84"
    "./result_8chains/node275_7_0.txt 83"
    "./result_8chains/node275_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
