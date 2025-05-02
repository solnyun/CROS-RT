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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_2 -p 87 -st topic210_0_1 -pt None -u 0.0037682693155117186 > ./result_8chains/node210_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_2 -p 117 -st topic210_1_1 -pt None -u 0.0316612405838011 > ./result_8chains/node210_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_2 -p 273 -st topic210_2_1 -pt None -u 0.032711025871212995 > ./result_8chains/node210_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_2 -p 349 -st topic210_3_1 -pt None -u 0.005467683288361114 > ./result_8chains/node210_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_2 -p 411 -st topic210_4_1 -pt None -u 0.03352615697409289 > ./result_8chains/node210_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_2 -p 516 -st topic210_5_1 -pt None -u 0.06241694588907294 > ./result_8chains/node210_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_2 -p 675 -st topic210_6_1 -pt None -u 0.035426792703392274 > ./result_8chains/node210_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_2 -p 926 -st topic210_7_1 -pt None -u 0.004445813830986602 > ./result_8chains/node210_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_0 -p 87 -st none -pt topic210_0_0 -u 0.004914194643305947 > ./result_8chains/node210_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_0 -p 117 -st none -pt topic210_1_0 -u 0.014818334514364262 > ./result_8chains/node210_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_0 -p 273 -st none -pt topic210_2_0 -u 0.012248495470628229 > ./result_8chains/node210_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_0 -p 349 -st none -pt topic210_3_0 -u 0.0326778807790889 > ./result_8chains/node210_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_0 -p 411 -st none -pt topic210_4_0 -u 0.015101653596370557 > ./result_8chains/node210_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_0 -p 516 -st none -pt topic210_5_0 -u 0.0197298098062611 > ./result_8chains/node210_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_0 -p 675 -st none -pt topic210_6_0 -u 0.007484965488488204 > ./result_8chains/node210_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_0 -p 926 -st none -pt topic210_7_0 -u 0.013006338686507635 > ./result_8chains/node210_7_0.txt &
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
    "./result_8chains/node210_0_0.txt 90"
    "./result_8chains/node210_0_2.txt 90"
    "./result_8chains/node210_1_0.txt 89"
    "./result_8chains/node210_1_2.txt 89"
    "./result_8chains/node210_2_0.txt 88"
    "./result_8chains/node210_2_2.txt 88"
    "./result_8chains/node210_3_0.txt 87"
    "./result_8chains/node210_3_2.txt 87"
    "./result_8chains/node210_4_0.txt 86"
    "./result_8chains/node210_4_2.txt 86"
    "./result_8chains/node210_5_0.txt 85"
    "./result_8chains/node210_5_2.txt 85"
    "./result_8chains/node210_6_0.txt 84"
    "./result_8chains/node210_6_2.txt 84"
    "./result_8chains/node210_7_0.txt 83"
    "./result_8chains/node210_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
