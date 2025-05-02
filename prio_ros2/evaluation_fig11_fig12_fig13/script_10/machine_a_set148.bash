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
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_2 -p 18 -st topic148_0_1 -pt None -u 0.019502722338349876 > ./result_10chains/node148_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_2 -p 124 -st topic148_1_1 -pt None -u 0.02540913376127013 > ./result_10chains/node148_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_2 -p 156 -st topic148_2_1 -pt None -u 0.009920769568981691 > ./result_10chains/node148_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_2 -p 187 -st topic148_3_1 -pt None -u 0.002236549710241731 > ./result_10chains/node148_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_2 -p 244 -st topic148_4_1 -pt None -u 0.009977796630719432 > ./result_10chains/node148_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_2 -p 314 -st topic148_5_1 -pt None -u 0.012179231747675157 > ./result_10chains/node148_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_2 -p 430 -st topic148_6_1 -pt None -u 0.007530489776049615 > ./result_10chains/node148_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_2 -p 531 -st topic148_7_1 -pt None -u 0.021671517756761904 > ./result_10chains/node148_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_8_2 -p 802 -st topic148_8_1 -pt None -u 0.02117887005519574 > ./result_10chains/node148_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_9_2 -p 911 -st topic148_9_1 -pt None -u 0.007852932942279449 > ./result_10chains/node148_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_0 -p 18 -st none -pt topic148_0_0 -u 0.09195212680763887 > ./result_10chains/node148_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_0 -p 124 -st none -pt topic148_1_0 -u 0.03976721576200243 > ./result_10chains/node148_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_0 -p 156 -st none -pt topic148_2_0 -u 0.02384383107363075 > ./result_10chains/node148_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_0 -p 187 -st none -pt topic148_3_0 -u 0.0036538567121369714 > ./result_10chains/node148_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_0 -p 244 -st none -pt topic148_4_0 -u 0.00753862625388807 > ./result_10chains/node148_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_0 -p 314 -st none -pt topic148_5_0 -u 0.001956147781589146 > ./result_10chains/node148_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_0 -p 430 -st none -pt topic148_6_0 -u 0.027698676494083585 > ./result_10chains/node148_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_0 -p 531 -st none -pt topic148_7_0 -u 2.2471565433113128e-05 > ./result_10chains/node148_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_8_0 -p 802 -st none -pt topic148_8_0 -u 0.010013029589181419 > ./result_10chains/node148_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_9_0 -p 911 -st none -pt topic148_9_0 -u 0.011543680424190565 > ./result_10chains/node148_9_0.txt &
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
    "./result_10chains/node148_0_0.txt 90"
    "./result_10chains/node148_0_2.txt 90"
    "./result_10chains/node148_1_0.txt 89"
    "./result_10chains/node148_1_2.txt 89"
    "./result_10chains/node148_2_0.txt 88"
    "./result_10chains/node148_2_2.txt 88"
    "./result_10chains/node148_3_0.txt 87"
    "./result_10chains/node148_3_2.txt 87"
    "./result_10chains/node148_4_0.txt 86"
    "./result_10chains/node148_4_2.txt 86"
    "./result_10chains/node148_5_0.txt 85"
    "./result_10chains/node148_5_2.txt 85"
    "./result_10chains/node148_6_0.txt 84"
    "./result_10chains/node148_6_2.txt 84"
    "./result_10chains/node148_7_0.txt 83"
    "./result_10chains/node148_7_2.txt 83"
    "./result_10chains/node148_8_0.txt 82"
    "./result_10chains/node148_8_2.txt 82"
    "./result_10chains/node148_9_0.txt 81"
    "./result_10chains/node148_9_2.txt 81"
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
