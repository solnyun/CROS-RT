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
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_2 -p 199 -st topic76_0_1 -pt None -u 0.03887410951233988 > ./result_10chains/node76_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_2 -p 330 -st topic76_1_1 -pt None -u 0.029832790007988663 > ./result_10chains/node76_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_2 -p 397 -st topic76_2_1 -pt None -u 0.009171806830810314 > ./result_10chains/node76_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_2 -p 579 -st topic76_3_1 -pt None -u 0.002447762350521576 > ./result_10chains/node76_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_2 -p 598 -st topic76_4_1 -pt None -u 0.008072361794086935 > ./result_10chains/node76_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_2 -p 750 -st topic76_5_1 -pt None -u 0.005453500623067348 > ./result_10chains/node76_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_6_2 -p 824 -st topic76_6_1 -pt None -u 0.020212782736283463 > ./result_10chains/node76_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_7_2 -p 899 -st topic76_7_1 -pt None -u 0.004562340638066112 > ./result_10chains/node76_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_8_2 -p 907 -st topic76_8_1 -pt None -u 0.04514266538916531 > ./result_10chains/node76_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_9_2 -p 955 -st topic76_9_1 -pt None -u 0.018748666614871703 > ./result_10chains/node76_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_0 -p 199 -st none -pt topic76_0_0 -u 0.04884425843062962 > ./result_10chains/node76_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_0 -p 330 -st none -pt topic76_1_0 -u 0.0019611817130348874 > ./result_10chains/node76_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_0 -p 397 -st none -pt topic76_2_0 -u 0.0023850180800994436 > ./result_10chains/node76_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_0 -p 579 -st none -pt topic76_3_0 -u 0.029313581343867634 > ./result_10chains/node76_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_0 -p 598 -st none -pt topic76_4_0 -u 0.0037733875140683604 > ./result_10chains/node76_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_0 -p 750 -st none -pt topic76_5_0 -u 0.01818634675610689 > ./result_10chains/node76_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_6_0 -p 824 -st none -pt topic76_6_0 -u 0.021730099695416172 > ./result_10chains/node76_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_7_0 -p 899 -st none -pt topic76_7_0 -u 0.006683118885519215 > ./result_10chains/node76_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_8_0 -p 907 -st none -pt topic76_8_0 -u 0.006779822399614083 > ./result_10chains/node76_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_9_0 -p 955 -st none -pt topic76_9_0 -u 0.002238083571603315 > ./result_10chains/node76_9_0.txt &
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
    "./result_10chains/node76_0_0.txt 90"
    "./result_10chains/node76_0_2.txt 90"
    "./result_10chains/node76_1_0.txt 89"
    "./result_10chains/node76_1_2.txt 89"
    "./result_10chains/node76_2_0.txt 88"
    "./result_10chains/node76_2_2.txt 88"
    "./result_10chains/node76_3_0.txt 87"
    "./result_10chains/node76_3_2.txt 87"
    "./result_10chains/node76_4_0.txt 86"
    "./result_10chains/node76_4_2.txt 86"
    "./result_10chains/node76_5_0.txt 85"
    "./result_10chains/node76_5_2.txt 85"
    "./result_10chains/node76_6_0.txt 84"
    "./result_10chains/node76_6_2.txt 84"
    "./result_10chains/node76_7_0.txt 83"
    "./result_10chains/node76_7_2.txt 83"
    "./result_10chains/node76_8_0.txt 82"
    "./result_10chains/node76_8_2.txt 82"
    "./result_10chains/node76_9_0.txt 81"
    "./result_10chains/node76_9_2.txt 81"
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
