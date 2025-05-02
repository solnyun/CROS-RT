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
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_2 -p 111 -st topic44_0_1 -pt None -u 0.033807346354047474 > ./result_8chains/node44_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_2 -p 219 -st topic44_1_1 -pt None -u 0.012467603151197493 > ./result_8chains/node44_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_2 -p 390 -st topic44_2_1 -pt None -u 0.007043820360741027 > ./result_8chains/node44_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_2 -p 564 -st topic44_3_1 -pt None -u 0.017203447053143583 > ./result_8chains/node44_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_2 -p 627 -st topic44_4_1 -pt None -u 0.011642997168844343 > ./result_8chains/node44_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_2 -p 666 -st topic44_5_1 -pt None -u 0.007945342866760685 > ./result_8chains/node44_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_6_2 -p 844 -st topic44_6_1 -pt None -u 0.02063201537029577 > ./result_8chains/node44_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_7_2 -p 890 -st topic44_7_1 -pt None -u 0.007032594581915664 > ./result_8chains/node44_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_0 -p 111 -st none -pt topic44_0_0 -u 0.02159923586071366 > ./result_8chains/node44_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_0 -p 219 -st none -pt topic44_1_0 -u 0.04484304380709031 > ./result_8chains/node44_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_0 -p 390 -st none -pt topic44_2_0 -u 0.054177848717865795 > ./result_8chains/node44_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_0 -p 564 -st none -pt topic44_3_0 -u 0.0004030791644538123 > ./result_8chains/node44_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_0 -p 627 -st none -pt topic44_4_0 -u 0.03236703869155366 > ./result_8chains/node44_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_0 -p 666 -st none -pt topic44_5_0 -u 0.0009193381900342301 > ./result_8chains/node44_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_6_0 -p 844 -st none -pt topic44_6_0 -u 0.0710403071761241 > ./result_8chains/node44_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_7_0 -p 890 -st none -pt topic44_7_0 -u 0.007926577868777297 > ./result_8chains/node44_7_0.txt &
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
    "./result_8chains/node44_0_0.txt 90"
    "./result_8chains/node44_0_2.txt 90"
    "./result_8chains/node44_1_0.txt 89"
    "./result_8chains/node44_1_2.txt 89"
    "./result_8chains/node44_2_0.txt 88"
    "./result_8chains/node44_2_2.txt 88"
    "./result_8chains/node44_3_0.txt 87"
    "./result_8chains/node44_3_2.txt 87"
    "./result_8chains/node44_4_0.txt 86"
    "./result_8chains/node44_4_2.txt 86"
    "./result_8chains/node44_5_0.txt 85"
    "./result_8chains/node44_5_2.txt 85"
    "./result_8chains/node44_6_0.txt 84"
    "./result_8chains/node44_6_2.txt 84"
    "./result_8chains/node44_7_0.txt 83"
    "./result_8chains/node44_7_2.txt 83"
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
