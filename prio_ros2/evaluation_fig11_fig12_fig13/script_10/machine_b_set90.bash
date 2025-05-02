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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_1 -p 25 -st topic90_0_0 -pt topic90_0_1 -u 0.04510700504341175 > ./result_10chains/node90_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_1 -p 49 -st topic90_1_0 -pt topic90_1_1 -u 0.004298464314726913 > ./result_10chains/node90_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_1 -p 65 -st topic90_2_0 -pt topic90_2_1 -u 0.004378751170413364 > ./result_10chains/node90_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_1 -p 245 -st topic90_3_0 -pt topic90_3_1 -u 0.028198702611752446 > ./result_10chains/node90_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_1 -p 272 -st topic90_4_0 -pt topic90_4_1 -u 0.013844492622797855 > ./result_10chains/node90_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_1 -p 612 -st topic90_5_0 -pt topic90_5_1 -u 0.016512296046478775 > ./result_10chains/node90_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_1 -p 665 -st topic90_6_0 -pt topic90_6_1 -u 0.01953413833421186 > ./result_10chains/node90_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_1 -p 767 -st topic90_7_0 -pt topic90_7_1 -u 0.008104969141101842 > ./result_10chains/node90_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_8_1 -p 821 -st topic90_8_0 -pt topic90_8_1 -u 0.026060959208961967 > ./result_10chains/node90_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_9_1 -p 941 -st topic90_9_0 -pt topic90_9_1 -u 0.006961079965973499 > ./result_10chains/node90_9_1.txt &
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
    "./result_10chains/node90_0_1.txt 90"
    "./result_10chains/node90_1_1.txt 89"
    "./result_10chains/node90_2_1.txt 88"
    "./result_10chains/node90_3_1.txt 87"
    "./result_10chains/node90_4_1.txt 86"
    "./result_10chains/node90_5_1.txt 85"
    "./result_10chains/node90_6_1.txt 84"
    "./result_10chains/node90_7_1.txt 83"
    "./result_10chains/node90_8_1.txt 82"
    "./result_10chains/node90_9_1.txt 81"
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
