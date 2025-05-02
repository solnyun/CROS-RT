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
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_2 -p 21 -st topic101_0_1 -pt None -u 0.0467627576933593 > ./result_8chains/node101_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_2 -p 86 -st topic101_1_1 -pt None -u 0.036078191511704605 > ./result_8chains/node101_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_2 -p 132 -st topic101_2_1 -pt None -u 0.06478014449596076 > ./result_8chains/node101_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_2 -p 352 -st topic101_3_1 -pt None -u 0.001024795174229931 > ./result_8chains/node101_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_2 -p 424 -st topic101_4_1 -pt None -u 0.027303902204491443 > ./result_8chains/node101_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_2 -p 714 -st topic101_5_1 -pt None -u 0.021174443626777853 > ./result_8chains/node101_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_2 -p 856 -st topic101_6_1 -pt None -u 0.03831675841193675 > ./result_8chains/node101_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_2 -p 987 -st topic101_7_1 -pt None -u 0.008249557055678569 > ./result_8chains/node101_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_0 -p 21 -st none -pt topic101_0_0 -u 0.01269214903543986 > ./result_8chains/node101_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_0 -p 86 -st none -pt topic101_1_0 -u 0.004884121767579741 > ./result_8chains/node101_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_0 -p 132 -st none -pt topic101_2_0 -u 0.007768095565071298 > ./result_8chains/node101_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_0 -p 352 -st none -pt topic101_3_0 -u 0.008958700695500033 > ./result_8chains/node101_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_0 -p 424 -st none -pt topic101_4_0 -u 0.02391964056647622 > ./result_8chains/node101_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_0 -p 714 -st none -pt topic101_5_0 -u 0.002840184483520858 > ./result_8chains/node101_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_0 -p 856 -st none -pt topic101_6_0 -u 0.027238643926942627 > ./result_8chains/node101_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_0 -p 987 -st none -pt topic101_7_0 -u 0.046931926717186816 > ./result_8chains/node101_7_0.txt &
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
    "./result_8chains/node101_0_0.txt 90"
    "./result_8chains/node101_0_2.txt 90"
    "./result_8chains/node101_1_0.txt 89"
    "./result_8chains/node101_1_2.txt 89"
    "./result_8chains/node101_2_0.txt 88"
    "./result_8chains/node101_2_2.txt 88"
    "./result_8chains/node101_3_0.txt 87"
    "./result_8chains/node101_3_2.txt 87"
    "./result_8chains/node101_4_0.txt 86"
    "./result_8chains/node101_4_2.txt 86"
    "./result_8chains/node101_5_0.txt 85"
    "./result_8chains/node101_5_2.txt 85"
    "./result_8chains/node101_6_0.txt 84"
    "./result_8chains/node101_6_2.txt 84"
    "./result_8chains/node101_7_0.txt 83"
    "./result_8chains/node101_7_2.txt 83"
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
