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
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_2 -p 78 -st topic263_0_1 -pt None -u 0.03580739161498603 > ./result_8chains/node263_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_2 -p 164 -st topic263_1_1 -pt None -u 0.01569644242385765 > ./result_8chains/node263_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_2 -p 232 -st topic263_2_1 -pt None -u 0.018950568366483622 > ./result_8chains/node263_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_2 -p 573 -st topic263_3_1 -pt None -u 0.010808850922647939 > ./result_8chains/node263_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_2 -p 785 -st topic263_4_1 -pt None -u 0.0011612154392430518 > ./result_8chains/node263_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_2 -p 790 -st topic263_5_1 -pt None -u 0.012513170418995218 > ./result_8chains/node263_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_2 -p 824 -st topic263_6_1 -pt None -u 0.042082951824146675 > ./result_8chains/node263_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_2 -p 851 -st topic263_7_1 -pt None -u 0.006001580406638225 > ./result_8chains/node263_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_0 -p 78 -st none -pt topic263_0_0 -u 0.018557462210436415 > ./result_8chains/node263_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_0 -p 164 -st none -pt topic263_1_0 -u 0.0022308741654902264 > ./result_8chains/node263_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_0 -p 232 -st none -pt topic263_2_0 -u 0.00863840928966797 > ./result_8chains/node263_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_0 -p 573 -st none -pt topic263_3_0 -u 0.016424783450728064 > ./result_8chains/node263_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_0 -p 785 -st none -pt topic263_4_0 -u 0.03912888423218863 > ./result_8chains/node263_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_0 -p 790 -st none -pt topic263_5_0 -u 0.006665792741132853 > ./result_8chains/node263_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_0 -p 824 -st none -pt topic263_6_0 -u 0.02356763263130726 > ./result_8chains/node263_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_0 -p 851 -st none -pt topic263_7_0 -u 0.010858158757811404 > ./result_8chains/node263_7_0.txt &
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
    "./result_8chains/node263_0_0.txt 90"
    "./result_8chains/node263_0_2.txt 90"
    "./result_8chains/node263_1_0.txt 89"
    "./result_8chains/node263_1_2.txt 89"
    "./result_8chains/node263_2_0.txt 88"
    "./result_8chains/node263_2_2.txt 88"
    "./result_8chains/node263_3_0.txt 87"
    "./result_8chains/node263_3_2.txt 87"
    "./result_8chains/node263_4_0.txt 86"
    "./result_8chains/node263_4_2.txt 86"
    "./result_8chains/node263_5_0.txt 85"
    "./result_8chains/node263_5_2.txt 85"
    "./result_8chains/node263_6_0.txt 84"
    "./result_8chains/node263_6_2.txt 84"
    "./result_8chains/node263_7_0.txt 83"
    "./result_8chains/node263_7_2.txt 83"
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
