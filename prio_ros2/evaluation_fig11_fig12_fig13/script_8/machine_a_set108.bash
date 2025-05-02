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
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_2 -p 244 -st topic108_0_1 -pt None -u 0.07484770689322706 > ./result_8chains/node108_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_2 -p 382 -st topic108_1_1 -pt None -u 0.0035612535314971105 > ./result_8chains/node108_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_2 -p 388 -st topic108_2_1 -pt None -u 0.03920962926709409 > ./result_8chains/node108_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_2 -p 687 -st topic108_3_1 -pt None -u 0.022503069398610465 > ./result_8chains/node108_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_2 -p 730 -st topic108_4_1 -pt None -u 0.0034518142280362263 > ./result_8chains/node108_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_2 -p 794 -st topic108_5_1 -pt None -u 0.001629408194438492 > ./result_8chains/node108_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_6_2 -p 861 -st topic108_6_1 -pt None -u 0.04632857798586971 > ./result_8chains/node108_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_7_2 -p 894 -st topic108_7_1 -pt None -u 0.007165233232690772 > ./result_8chains/node108_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_0 -p 244 -st none -pt topic108_0_0 -u 0.024956282937393492 > ./result_8chains/node108_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_0 -p 382 -st none -pt topic108_1_0 -u 0.0022430569277768764 > ./result_8chains/node108_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_0 -p 388 -st none -pt topic108_2_0 -u 0.03465185614970551 > ./result_8chains/node108_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_0 -p 687 -st none -pt topic108_3_0 -u 0.015198283608477081 > ./result_8chains/node108_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_0 -p 730 -st none -pt topic108_4_0 -u 0.0323602246357278 > ./result_8chains/node108_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_0 -p 794 -st none -pt topic108_5_0 -u 0.036306437009816867 > ./result_8chains/node108_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_6_0 -p 861 -st none -pt topic108_6_0 -u 0.0012085265251807198 > ./result_8chains/node108_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_7_0 -p 894 -st none -pt topic108_7_0 -u 0.009237300220166571 > ./result_8chains/node108_7_0.txt &
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
    "./result_8chains/node108_0_0.txt 90"
    "./result_8chains/node108_0_2.txt 90"
    "./result_8chains/node108_1_0.txt 89"
    "./result_8chains/node108_1_2.txt 89"
    "./result_8chains/node108_2_0.txt 88"
    "./result_8chains/node108_2_2.txt 88"
    "./result_8chains/node108_3_0.txt 87"
    "./result_8chains/node108_3_2.txt 87"
    "./result_8chains/node108_4_0.txt 86"
    "./result_8chains/node108_4_2.txt 86"
    "./result_8chains/node108_5_0.txt 85"
    "./result_8chains/node108_5_2.txt 85"
    "./result_8chains/node108_6_0.txt 84"
    "./result_8chains/node108_6_2.txt 84"
    "./result_8chains/node108_7_0.txt 83"
    "./result_8chains/node108_7_2.txt 83"
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
