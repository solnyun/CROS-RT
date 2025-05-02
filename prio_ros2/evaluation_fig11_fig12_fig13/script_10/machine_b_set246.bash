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
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_1 -p 185 -st topic246_0_0 -pt topic246_0_1 -u 0.0071895315903783286 > ./result_10chains/node246_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_1 -p 196 -st topic246_1_0 -pt topic246_1_1 -u 0.03359059475814541 > ./result_10chains/node246_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_1 -p 371 -st topic246_2_0 -pt topic246_2_1 -u 0.0007937971041721559 > ./result_10chains/node246_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_1 -p 382 -st topic246_3_0 -pt topic246_3_1 -u 0.021105095707027954 > ./result_10chains/node246_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_1 -p 663 -st topic246_4_0 -pt topic246_4_1 -u 0.0022271737609858566 > ./result_10chains/node246_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_1 -p 708 -st topic246_5_0 -pt topic246_5_1 -u 0.008108327618170208 > ./result_10chains/node246_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_6_1 -p 724 -st topic246_6_0 -pt topic246_6_1 -u 0.011930360528843886 > ./result_10chains/node246_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_7_1 -p 746 -st topic246_7_0 -pt topic246_7_1 -u 0.0109701752765827 > ./result_10chains/node246_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_8_1 -p 922 -st topic246_8_0 -pt topic246_8_1 -u 0.0021222462638080114 > ./result_10chains/node246_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_9_1 -p 992 -st topic246_9_0 -pt topic246_9_1 -u 0.02160106861932679 > ./result_10chains/node246_9_1.txt &
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
    "./result_10chains/node246_0_1.txt 90"
    "./result_10chains/node246_1_1.txt 89"
    "./result_10chains/node246_2_1.txt 88"
    "./result_10chains/node246_3_1.txt 87"
    "./result_10chains/node246_4_1.txt 86"
    "./result_10chains/node246_5_1.txt 85"
    "./result_10chains/node246_6_1.txt 84"
    "./result_10chains/node246_7_1.txt 83"
    "./result_10chains/node246_8_1.txt 82"
    "./result_10chains/node246_9_1.txt 81"
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
