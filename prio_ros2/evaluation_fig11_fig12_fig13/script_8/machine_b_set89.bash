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
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_1 -p 116 -st topic89_0_0 -pt topic89_0_1 -u 0.03646479431390465 > ./result_8chains/node89_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_1 -p 131 -st topic89_1_0 -pt topic89_1_1 -u 0.06445515311359745 > ./result_8chains/node89_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_1 -p 368 -st topic89_2_0 -pt topic89_2_1 -u 0.0068328774373500045 > ./result_8chains/node89_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_1 -p 379 -st topic89_3_0 -pt topic89_3_1 -u 0.0067437545098572305 > ./result_8chains/node89_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_1 -p 459 -st topic89_4_0 -pt topic89_4_1 -u 0.009908924476941167 > ./result_8chains/node89_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_1 -p 804 -st topic89_5_0 -pt topic89_5_1 -u 0.05308177081013121 > ./result_8chains/node89_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_6_1 -p 816 -st topic89_6_0 -pt topic89_6_1 -u 0.028283303082852963 > ./result_8chains/node89_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_7_1 -p 952 -st topic89_7_0 -pt topic89_7_1 -u 0.005438721791487572 > ./result_8chains/node89_7_1.txt &
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
    "./result_8chains/node89_0_1.txt 90"
    "./result_8chains/node89_1_1.txt 89"
    "./result_8chains/node89_2_1.txt 88"
    "./result_8chains/node89_3_1.txt 87"
    "./result_8chains/node89_4_1.txt 86"
    "./result_8chains/node89_5_1.txt 85"
    "./result_8chains/node89_6_1.txt 84"
    "./result_8chains/node89_7_1.txt 83"
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
