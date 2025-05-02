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
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_2 -p 49 -st topic292_0_1 -pt None -u 0.0689844982647087 > ./result_10chains/node292_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_2 -p 85 -st topic292_1_1 -pt None -u 0.004963713724293384 > ./result_10chains/node292_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_2 -p 208 -st topic292_2_1 -pt None -u 0.013918755951603301 > ./result_10chains/node292_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_2 -p 210 -st topic292_3_1 -pt None -u 0.028768730657384334 > ./result_10chains/node292_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_2 -p 365 -st topic292_4_1 -pt None -u 0.02560252574888766 > ./result_10chains/node292_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_2 -p 708 -st topic292_5_1 -pt None -u 0.00926462113024687 > ./result_10chains/node292_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_2 -p 728 -st topic292_6_1 -pt None -u 0.057745985127930013 > ./result_10chains/node292_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_2 -p 779 -st topic292_7_1 -pt None -u 0.007061241002013975 > ./result_10chains/node292_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_8_2 -p 792 -st topic292_8_1 -pt None -u 0.006881392025669959 > ./result_10chains/node292_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_9_2 -p 867 -st topic292_9_1 -pt None -u 0.004216534382212303 > ./result_10chains/node292_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_0 -p 49 -st none -pt topic292_0_0 -u 0.025722956615181425 > ./result_10chains/node292_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_0 -p 85 -st none -pt topic292_1_0 -u 0.009241824797923959 > ./result_10chains/node292_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_0 -p 208 -st none -pt topic292_2_0 -u 0.014023425888187946 > ./result_10chains/node292_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_0 -p 210 -st none -pt topic292_3_0 -u 0.018690955475878235 > ./result_10chains/node292_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_0 -p 365 -st none -pt topic292_4_0 -u 0.00665822939737612 > ./result_10chains/node292_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_0 -p 708 -st none -pt topic292_5_0 -u 0.0008013515460654208 > ./result_10chains/node292_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_0 -p 728 -st none -pt topic292_6_0 -u 0.00378854551352778 > ./result_10chains/node292_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_0 -p 779 -st none -pt topic292_7_0 -u 0.01746571376768835 > ./result_10chains/node292_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_8_0 -p 792 -st none -pt topic292_8_0 -u 0.007818220783492317 > ./result_10chains/node292_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_9_0 -p 867 -st none -pt topic292_9_0 -u 0.009738267707644823 > ./result_10chains/node292_9_0.txt &
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
    "./result_10chains/node292_0_0.txt 90"
    "./result_10chains/node292_0_2.txt 90"
    "./result_10chains/node292_1_0.txt 89"
    "./result_10chains/node292_1_2.txt 89"
    "./result_10chains/node292_2_0.txt 88"
    "./result_10chains/node292_2_2.txt 88"
    "./result_10chains/node292_3_0.txt 87"
    "./result_10chains/node292_3_2.txt 87"
    "./result_10chains/node292_4_0.txt 86"
    "./result_10chains/node292_4_2.txt 86"
    "./result_10chains/node292_5_0.txt 85"
    "./result_10chains/node292_5_2.txt 85"
    "./result_10chains/node292_6_0.txt 84"
    "./result_10chains/node292_6_2.txt 84"
    "./result_10chains/node292_7_0.txt 83"
    "./result_10chains/node292_7_2.txt 83"
    "./result_10chains/node292_8_0.txt 82"
    "./result_10chains/node292_8_2.txt 82"
    "./result_10chains/node292_9_0.txt 81"
    "./result_10chains/node292_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
