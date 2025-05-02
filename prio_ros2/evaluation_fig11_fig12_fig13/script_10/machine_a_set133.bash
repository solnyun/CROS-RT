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
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_2 -p 114 -st topic133_0_1 -pt None -u 0.00828893629433658 > ./result_10chains/node133_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_2 -p 127 -st topic133_1_1 -pt None -u 0.002391835342031967 > ./result_10chains/node133_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_2 -p 335 -st topic133_2_1 -pt None -u 0.0016595238012553915 > ./result_10chains/node133_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_2 -p 665 -st topic133_3_1 -pt None -u 0.028811504087248363 > ./result_10chains/node133_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_2 -p 721 -st topic133_4_1 -pt None -u 0.019954127665763488 > ./result_10chains/node133_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_2 -p 744 -st topic133_5_1 -pt None -u 0.04337165500183751 > ./result_10chains/node133_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_2 -p 837 -st topic133_6_1 -pt None -u 0.016388246866821193 > ./result_10chains/node133_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_2 -p 890 -st topic133_7_1 -pt None -u 0.0051344815396443255 > ./result_10chains/node133_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_8_2 -p 939 -st topic133_8_1 -pt None -u 0.006315933197752477 > ./result_10chains/node133_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_9_2 -p 991 -st topic133_9_1 -pt None -u 0.019036666109273903 > ./result_10chains/node133_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_0 -p 114 -st none -pt topic133_0_0 -u 0.023596338958784602 > ./result_10chains/node133_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_0 -p 127 -st none -pt topic133_1_0 -u 0.01201019181846541 > ./result_10chains/node133_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_0 -p 335 -st none -pt topic133_2_0 -u 0.003475692363873184 > ./result_10chains/node133_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_0 -p 665 -st none -pt topic133_3_0 -u 0.04160489619999019 > ./result_10chains/node133_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_0 -p 721 -st none -pt topic133_4_0 -u 0.020465147617082013 > ./result_10chains/node133_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_0 -p 744 -st none -pt topic133_5_0 -u 0.012592134352681694 > ./result_10chains/node133_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_0 -p 837 -st none -pt topic133_6_0 -u 0.011846179234499044 > ./result_10chains/node133_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_0 -p 890 -st none -pt topic133_7_0 -u 0.032870147078567474 > ./result_10chains/node133_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_8_0 -p 939 -st none -pt topic133_8_0 -u 0.0013954895484806218 > ./result_10chains/node133_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_9_0 -p 991 -st none -pt topic133_9_0 -u 0.02354098818149248 > ./result_10chains/node133_9_0.txt &
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
    "./result_10chains/node133_0_0.txt 90"
    "./result_10chains/node133_0_2.txt 90"
    "./result_10chains/node133_1_0.txt 89"
    "./result_10chains/node133_1_2.txt 89"
    "./result_10chains/node133_2_0.txt 88"
    "./result_10chains/node133_2_2.txt 88"
    "./result_10chains/node133_3_0.txt 87"
    "./result_10chains/node133_3_2.txt 87"
    "./result_10chains/node133_4_0.txt 86"
    "./result_10chains/node133_4_2.txt 86"
    "./result_10chains/node133_5_0.txt 85"
    "./result_10chains/node133_5_2.txt 85"
    "./result_10chains/node133_6_0.txt 84"
    "./result_10chains/node133_6_2.txt 84"
    "./result_10chains/node133_7_0.txt 83"
    "./result_10chains/node133_7_2.txt 83"
    "./result_10chains/node133_8_0.txt 82"
    "./result_10chains/node133_8_2.txt 82"
    "./result_10chains/node133_9_0.txt 81"
    "./result_10chains/node133_9_2.txt 81"
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
