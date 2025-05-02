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
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_2 -p 37 -st topic390_0_1 -pt None -u 0.007201919310904081 > ./result_8chains/node390_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_2 -p 440 -st topic390_1_1 -pt None -u 0.11249586529942074 > ./result_8chains/node390_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_2 -p 480 -st topic390_2_1 -pt None -u 0.02773032608089998 > ./result_8chains/node390_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_2 -p 640 -st topic390_3_1 -pt None -u 0.008315992936479666 > ./result_8chains/node390_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_2 -p 675 -st topic390_4_1 -pt None -u 0.026210608522701268 > ./result_8chains/node390_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_2 -p 733 -st topic390_5_1 -pt None -u 0.03519281139755982 > ./result_8chains/node390_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_6_2 -p 759 -st topic390_6_1 -pt None -u 0.003919175018597829 > ./result_8chains/node390_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_7_2 -p 926 -st topic390_7_1 -pt None -u 0.0233340835356685 > ./result_8chains/node390_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_0 -p 37 -st none -pt topic390_0_0 -u 0.004881822096149291 > ./result_8chains/node390_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_0 -p 440 -st none -pt topic390_1_0 -u 0.03630114516775801 > ./result_8chains/node390_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_0 -p 480 -st none -pt topic390_2_0 -u 0.0244156031032865 > ./result_8chains/node390_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_0 -p 640 -st none -pt topic390_3_0 -u 0.017469957241818823 > ./result_8chains/node390_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_0 -p 675 -st none -pt topic390_4_0 -u 0.031351405321809966 > ./result_8chains/node390_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_0 -p 733 -st none -pt topic390_5_0 -u 0.005852463818465867 > ./result_8chains/node390_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_6_0 -p 759 -st none -pt topic390_6_0 -u 0.017297155046221743 > ./result_8chains/node390_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_7_0 -p 926 -st none -pt topic390_7_0 -u 0.017421587524974975 > ./result_8chains/node390_7_0.txt &
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
    "./result_8chains/node390_0_0.txt 90"
    "./result_8chains/node390_0_2.txt 90"
    "./result_8chains/node390_1_0.txt 89"
    "./result_8chains/node390_1_2.txt 89"
    "./result_8chains/node390_2_0.txt 88"
    "./result_8chains/node390_2_2.txt 88"
    "./result_8chains/node390_3_0.txt 87"
    "./result_8chains/node390_3_2.txt 87"
    "./result_8chains/node390_4_0.txt 86"
    "./result_8chains/node390_4_2.txt 86"
    "./result_8chains/node390_5_0.txt 85"
    "./result_8chains/node390_5_2.txt 85"
    "./result_8chains/node390_6_0.txt 84"
    "./result_8chains/node390_6_2.txt 84"
    "./result_8chains/node390_7_0.txt 83"
    "./result_8chains/node390_7_2.txt 83"
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
