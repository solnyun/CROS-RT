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
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_2 -p 64 -st topic473_0_1 -pt None -u 0.0003494227655097548 > ./result_10chains/node473_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_2 -p 237 -st topic473_1_1 -pt None -u 0.0016001762626349225 > ./result_10chains/node473_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_2 -p 304 -st topic473_2_1 -pt None -u 0.050419052985550605 > ./result_10chains/node473_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_2 -p 308 -st topic473_3_1 -pt None -u 0.004545909912021973 > ./result_10chains/node473_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_2 -p 478 -st topic473_4_1 -pt None -u 0.012447513861990556 > ./result_10chains/node473_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_2 -p 587 -st topic473_5_1 -pt None -u 0.019573460419923527 > ./result_10chains/node473_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_6_2 -p 615 -st topic473_6_1 -pt None -u 0.006761927849821769 > ./result_10chains/node473_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_7_2 -p 650 -st topic473_7_1 -pt None -u 0.009087287271169017 > ./result_10chains/node473_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_8_2 -p 822 -st topic473_8_1 -pt None -u 0.0077759921379308775 > ./result_10chains/node473_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_9_2 -p 977 -st topic473_9_1 -pt None -u 0.027549355939555355 > ./result_10chains/node473_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_0 -p 64 -st none -pt topic473_0_0 -u 0.049281214000775064 > ./result_10chains/node473_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_0 -p 237 -st none -pt topic473_1_0 -u 0.02353978779298982 > ./result_10chains/node473_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_0 -p 304 -st none -pt topic473_2_0 -u 0.0032049202837441393 > ./result_10chains/node473_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_0 -p 308 -st none -pt topic473_3_0 -u 0.061279495245010474 > ./result_10chains/node473_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_0 -p 478 -st none -pt topic473_4_0 -u 0.03584265966538494 > ./result_10chains/node473_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_0 -p 587 -st none -pt topic473_5_0 -u 0.01032051007237847 > ./result_10chains/node473_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_6_0 -p 615 -st none -pt topic473_6_0 -u 0.0025444410936577566 > ./result_10chains/node473_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_7_0 -p 650 -st none -pt topic473_7_0 -u 0.003972372047514494 > ./result_10chains/node473_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_8_0 -p 822 -st none -pt topic473_8_0 -u 0.03438111289876239 > ./result_10chains/node473_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_9_0 -p 977 -st none -pt topic473_9_0 -u 0.016301822997260573 > ./result_10chains/node473_9_0.txt &
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
    "./result_10chains/node473_0_0.txt 90"
    "./result_10chains/node473_0_2.txt 90"
    "./result_10chains/node473_1_0.txt 89"
    "./result_10chains/node473_1_2.txt 89"
    "./result_10chains/node473_2_0.txt 88"
    "./result_10chains/node473_2_2.txt 88"
    "./result_10chains/node473_3_0.txt 87"
    "./result_10chains/node473_3_2.txt 87"
    "./result_10chains/node473_4_0.txt 86"
    "./result_10chains/node473_4_2.txt 86"
    "./result_10chains/node473_5_0.txt 85"
    "./result_10chains/node473_5_2.txt 85"
    "./result_10chains/node473_6_0.txt 84"
    "./result_10chains/node473_6_2.txt 84"
    "./result_10chains/node473_7_0.txt 83"
    "./result_10chains/node473_7_2.txt 83"
    "./result_10chains/node473_8_0.txt 82"
    "./result_10chains/node473_8_2.txt 82"
    "./result_10chains/node473_9_0.txt 81"
    "./result_10chains/node473_9_2.txt 81"
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
