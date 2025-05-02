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
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_2 -p 166 -st topic275_0_1 -pt None -u 0.01848888991655223 > ./result_10chains/node275_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_2 -p 184 -st topic275_1_1 -pt None -u 0.0007544833420420893 > ./result_10chains/node275_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_2 -p 186 -st topic275_2_1 -pt None -u 0.005643886933431652 > ./result_10chains/node275_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_2 -p 296 -st topic275_3_1 -pt None -u 0.008634855702169708 > ./result_10chains/node275_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_2 -p 353 -st topic275_4_1 -pt None -u 0.024852253369682942 > ./result_10chains/node275_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_2 -p 586 -st topic275_5_1 -pt None -u 0.019734188041747314 > ./result_10chains/node275_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_6_2 -p 596 -st topic275_6_1 -pt None -u 0.008725546170975679 > ./result_10chains/node275_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_7_2 -p 651 -st topic275_7_1 -pt None -u 0.05243675540705468 > ./result_10chains/node275_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_8_2 -p 918 -st topic275_8_1 -pt None -u 0.004241424462151158 > ./result_10chains/node275_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_9_2 -p 934 -st topic275_9_1 -pt None -u 0.033629104337034685 > ./result_10chains/node275_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_0 -p 166 -st none -pt topic275_0_0 -u 0.007321325482102403 > ./result_10chains/node275_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_0 -p 184 -st none -pt topic275_1_0 -u 0.0017388704705498248 > ./result_10chains/node275_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_0 -p 186 -st none -pt topic275_2_0 -u 0.0018327864700567464 > ./result_10chains/node275_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_0 -p 296 -st none -pt topic275_3_0 -u 0.021325333623560094 > ./result_10chains/node275_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_0 -p 353 -st none -pt topic275_4_0 -u 0.0004574773082333117 > ./result_10chains/node275_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_0 -p 586 -st none -pt topic275_5_0 -u 0.02308177168701986 > ./result_10chains/node275_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_6_0 -p 596 -st none -pt topic275_6_0 -u 0.039930514993657545 > ./result_10chains/node275_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_7_0 -p 651 -st none -pt topic275_7_0 -u 0.04690503326902462 > ./result_10chains/node275_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_8_0 -p 918 -st none -pt topic275_8_0 -u 0.00857068779544802 > ./result_10chains/node275_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_9_0 -p 934 -st none -pt topic275_9_0 -u 0.03358831180197099 > ./result_10chains/node275_9_0.txt &
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
    "./result_10chains/node275_0_0.txt 90"
    "./result_10chains/node275_0_2.txt 90"
    "./result_10chains/node275_1_0.txt 89"
    "./result_10chains/node275_1_2.txt 89"
    "./result_10chains/node275_2_0.txt 88"
    "./result_10chains/node275_2_2.txt 88"
    "./result_10chains/node275_3_0.txt 87"
    "./result_10chains/node275_3_2.txt 87"
    "./result_10chains/node275_4_0.txt 86"
    "./result_10chains/node275_4_2.txt 86"
    "./result_10chains/node275_5_0.txt 85"
    "./result_10chains/node275_5_2.txt 85"
    "./result_10chains/node275_6_0.txt 84"
    "./result_10chains/node275_6_2.txt 84"
    "./result_10chains/node275_7_0.txt 83"
    "./result_10chains/node275_7_2.txt 83"
    "./result_10chains/node275_8_0.txt 82"
    "./result_10chains/node275_8_2.txt 82"
    "./result_10chains/node275_9_0.txt 81"
    "./result_10chains/node275_9_2.txt 81"
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
