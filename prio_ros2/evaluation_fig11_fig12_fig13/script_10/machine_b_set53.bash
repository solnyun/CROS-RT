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
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_1 -p 199 -st topic53_0_0 -pt topic53_0_1 -u 0.005214064791471906 > ./result_10chains/node53_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_1 -p 220 -st topic53_1_0 -pt topic53_1_1 -u 0.024408016554296363 > ./result_10chains/node53_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_1 -p 283 -st topic53_2_0 -pt topic53_2_1 -u 0.038838251581169936 > ./result_10chains/node53_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_1 -p 330 -st topic53_3_0 -pt topic53_3_1 -u 0.012250423951561784 > ./result_10chains/node53_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_1 -p 545 -st topic53_4_0 -pt topic53_4_1 -u 0.018823234220799956 > ./result_10chains/node53_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_1 -p 571 -st topic53_5_0 -pt topic53_5_1 -u 5.3376224857820675e-05 > ./result_10chains/node53_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_6_1 -p 704 -st topic53_6_0 -pt topic53_6_1 -u 0.0016105743252525229 > ./result_10chains/node53_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_7_1 -p 802 -st topic53_7_0 -pt topic53_7_1 -u 0.008266877290596053 > ./result_10chains/node53_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_8_1 -p 833 -st topic53_8_0 -pt topic53_8_1 -u 0.045919133868145764 > ./result_10chains/node53_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_9_1 -p 917 -st topic53_9_0 -pt topic53_9_1 -u 0.002177900357957419 > ./result_10chains/node53_9_1.txt &
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
    "./result_10chains/node53_0_1.txt 90"
    "./result_10chains/node53_1_1.txt 89"
    "./result_10chains/node53_2_1.txt 88"
    "./result_10chains/node53_3_1.txt 87"
    "./result_10chains/node53_4_1.txt 86"
    "./result_10chains/node53_5_1.txt 85"
    "./result_10chains/node53_6_1.txt 84"
    "./result_10chains/node53_7_1.txt 83"
    "./result_10chains/node53_8_1.txt 82"
    "./result_10chains/node53_9_1.txt 81"
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
