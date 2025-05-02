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
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_2 -p 255 -st topic7_0_1 -pt None -u 0.07308651831435636 > ./result_8chains/node7_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_2 -p 293 -st topic7_1_1 -pt None -u 0.0027555609417025395 > ./result_8chains/node7_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_2 -p 313 -st topic7_2_1 -pt None -u 0.020617629063397813 > ./result_8chains/node7_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_2 -p 477 -st topic7_3_1 -pt None -u 0.05923039811179123 > ./result_8chains/node7_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_2 -p 720 -st topic7_4_1 -pt None -u 0.04176849073946187 > ./result_8chains/node7_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_2 -p 799 -st topic7_5_1 -pt None -u 0.018457789382839915 > ./result_8chains/node7_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_2 -p 932 -st topic7_6_1 -pt None -u 0.002320624433797396 > ./result_8chains/node7_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_2 -p 961 -st topic7_7_1 -pt None -u 0.001505565766238665 > ./result_8chains/node7_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_0 -p 255 -st none -pt topic7_0_0 -u 0.015073968353007783 > ./result_8chains/node7_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_0 -p 293 -st none -pt topic7_1_0 -u 0.01007682205998528 > ./result_8chains/node7_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_0 -p 313 -st none -pt topic7_2_0 -u 0.0064529473332266 > ./result_8chains/node7_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_0 -p 477 -st none -pt topic7_3_0 -u 0.03355043033736277 > ./result_8chains/node7_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_0 -p 720 -st none -pt topic7_4_0 -u 0.00702278153621938 > ./result_8chains/node7_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_0 -p 799 -st none -pt topic7_5_0 -u 0.01532793314287853 > ./result_8chains/node7_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_0 -p 932 -st none -pt topic7_6_0 -u 0.052724794963922635 > ./result_8chains/node7_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_0 -p 961 -st none -pt topic7_7_0 -u 0.002820820659956036 > ./result_8chains/node7_7_0.txt &
sleep 10
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
    "./result_8chains/node7_0_0.txt 90"
    "./result_8chains/node7_0_2.txt 90"
    "./result_8chains/node7_1_0.txt 89"
    "./result_8chains/node7_1_2.txt 89"
    "./result_8chains/node7_2_0.txt 88"
    "./result_8chains/node7_2_2.txt 88"
    "./result_8chains/node7_3_0.txt 87"
    "./result_8chains/node7_3_2.txt 87"
    "./result_8chains/node7_4_0.txt 86"
    "./result_8chains/node7_4_2.txt 86"
    "./result_8chains/node7_5_0.txt 85"
    "./result_8chains/node7_5_2.txt 85"
    "./result_8chains/node7_6_0.txt 84"
    "./result_8chains/node7_6_2.txt 84"
    "./result_8chains/node7_7_0.txt 83"
    "./result_8chains/node7_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
