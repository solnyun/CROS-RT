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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_2 -p 152 -st topic323_0_1 -pt None -u 0.01357244622108894 > ./result_10chains/node323_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_2 -p 177 -st topic323_1_1 -pt None -u 0.03419504943181606 > ./result_10chains/node323_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_2 -p 199 -st topic323_2_1 -pt None -u 0.0014363786863673123 > ./result_10chains/node323_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_2 -p 278 -st topic323_3_1 -pt None -u 0.03809331585982623 > ./result_10chains/node323_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_2 -p 356 -st topic323_4_1 -pt None -u 0.0029800925578319926 > ./result_10chains/node323_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_2 -p 498 -st topic323_5_1 -pt None -u 0.006394342806522957 > ./result_10chains/node323_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_2 -p 504 -st topic323_6_1 -pt None -u 0.004951392736241178 > ./result_10chains/node323_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_2 -p 599 -st topic323_7_1 -pt None -u 0.10970257537125896 > ./result_10chains/node323_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_8_2 -p 773 -st topic323_8_1 -pt None -u 0.021264315051983708 > ./result_10chains/node323_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_9_2 -p 877 -st topic323_9_1 -pt None -u 0.02376549274926786 > ./result_10chains/node323_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_0 -p 152 -st none -pt topic323_0_0 -u 0.007868975464309536 > ./result_10chains/node323_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_0 -p 177 -st none -pt topic323_1_0 -u 0.014404246640309426 > ./result_10chains/node323_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_0 -p 199 -st none -pt topic323_2_0 -u 0.02415940244778525 > ./result_10chains/node323_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_0 -p 278 -st none -pt topic323_3_0 -u 0.026606572083031743 > ./result_10chains/node323_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_0 -p 356 -st none -pt topic323_4_0 -u 0.01098877424633804 > ./result_10chains/node323_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_0 -p 498 -st none -pt topic323_5_0 -u 0.00829080798847509 > ./result_10chains/node323_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_0 -p 504 -st none -pt topic323_6_0 -u 0.009219901970132949 > ./result_10chains/node323_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_0 -p 599 -st none -pt topic323_7_0 -u 0.047308453847404536 > ./result_10chains/node323_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_8_0 -p 773 -st none -pt topic323_8_0 -u 0.0005047914729182784 > ./result_10chains/node323_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_9_0 -p 877 -st none -pt topic323_9_0 -u 0.005309233308066919 > ./result_10chains/node323_9_0.txt &
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
    "./result_10chains/node323_0_0.txt 90"
    "./result_10chains/node323_0_2.txt 90"
    "./result_10chains/node323_1_0.txt 89"
    "./result_10chains/node323_1_2.txt 89"
    "./result_10chains/node323_2_0.txt 88"
    "./result_10chains/node323_2_2.txt 88"
    "./result_10chains/node323_3_0.txt 87"
    "./result_10chains/node323_3_2.txt 87"
    "./result_10chains/node323_4_0.txt 86"
    "./result_10chains/node323_4_2.txt 86"
    "./result_10chains/node323_5_0.txt 85"
    "./result_10chains/node323_5_2.txt 85"
    "./result_10chains/node323_6_0.txt 84"
    "./result_10chains/node323_6_2.txt 84"
    "./result_10chains/node323_7_0.txt 83"
    "./result_10chains/node323_7_2.txt 83"
    "./result_10chains/node323_8_0.txt 82"
    "./result_10chains/node323_8_2.txt 82"
    "./result_10chains/node323_9_0.txt 81"
    "./result_10chains/node323_9_2.txt 81"
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
