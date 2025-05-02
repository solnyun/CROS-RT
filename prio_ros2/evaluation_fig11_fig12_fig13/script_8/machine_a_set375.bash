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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_2 -p 64 -st topic375_0_1 -pt None -u 0.03389021783102719 > ./result_8chains/node375_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_2 -p 229 -st topic375_1_1 -pt None -u 0.00188799834521719 > ./result_8chains/node375_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_2 -p 243 -st topic375_2_1 -pt None -u 0.016045128307728584 > ./result_8chains/node375_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_2 -p 257 -st topic375_3_1 -pt None -u 0.022657131858824342 > ./result_8chains/node375_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_2 -p 484 -st topic375_4_1 -pt None -u 0.01710724016305401 > ./result_8chains/node375_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_2 -p 580 -st topic375_5_1 -pt None -u 0.06033956994165027 > ./result_8chains/node375_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_2 -p 971 -st topic375_6_1 -pt None -u 0.010399597048257603 > ./result_8chains/node375_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_2 -p 985 -st topic375_7_1 -pt None -u 0.011542954965666041 > ./result_8chains/node375_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_0 -p 64 -st none -pt topic375_0_0 -u 0.03737724410105214 > ./result_8chains/node375_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_0 -p 229 -st none -pt topic375_1_0 -u 0.011640229030878912 > ./result_8chains/node375_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_0 -p 243 -st none -pt topic375_2_0 -u 0.026808226212716835 > ./result_8chains/node375_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_0 -p 257 -st none -pt topic375_3_0 -u 0.013041947668227805 > ./result_8chains/node375_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_0 -p 484 -st none -pt topic375_4_0 -u 0.04248640681967081 > ./result_8chains/node375_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_0 -p 580 -st none -pt topic375_5_0 -u 0.002348864270644402 > ./result_8chains/node375_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_0 -p 971 -st none -pt topic375_6_0 -u 0.020892893641901236 > ./result_8chains/node375_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_0 -p 985 -st none -pt topic375_7_0 -u 0.005677491309755436 > ./result_8chains/node375_7_0.txt &
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
    "./result_8chains/node375_0_0.txt 90"
    "./result_8chains/node375_0_2.txt 90"
    "./result_8chains/node375_1_0.txt 89"
    "./result_8chains/node375_1_2.txt 89"
    "./result_8chains/node375_2_0.txt 88"
    "./result_8chains/node375_2_2.txt 88"
    "./result_8chains/node375_3_0.txt 87"
    "./result_8chains/node375_3_2.txt 87"
    "./result_8chains/node375_4_0.txt 86"
    "./result_8chains/node375_4_2.txt 86"
    "./result_8chains/node375_5_0.txt 85"
    "./result_8chains/node375_5_2.txt 85"
    "./result_8chains/node375_6_0.txt 84"
    "./result_8chains/node375_6_2.txt 84"
    "./result_8chains/node375_7_0.txt 83"
    "./result_8chains/node375_7_2.txt 83"
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
