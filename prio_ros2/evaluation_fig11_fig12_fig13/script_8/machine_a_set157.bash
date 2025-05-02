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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_2 -p 189 -st topic157_0_1 -pt None -u 0.012389960688245383 > ./result_8chains/node157_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_2 -p 313 -st topic157_1_1 -pt None -u 0.04168046870018721 > ./result_8chains/node157_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_2 -p 451 -st topic157_2_1 -pt None -u 0.01311237719128322 > ./result_8chains/node157_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_2 -p 627 -st topic157_3_1 -pt None -u 0.041070711940707993 > ./result_8chains/node157_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_2 -p 636 -st topic157_4_1 -pt None -u 0.01782083601194162 > ./result_8chains/node157_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_2 -p 747 -st topic157_5_1 -pt None -u 0.02963301133467028 > ./result_8chains/node157_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_2 -p 983 -st topic157_6_1 -pt None -u 0.09087015021222403 > ./result_8chains/node157_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_2 -p 997 -st topic157_7_1 -pt None -u 0.0024221496916008315 > ./result_8chains/node157_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_0 -p 189 -st none -pt topic157_0_0 -u 0.008651527772062129 > ./result_8chains/node157_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_0 -p 313 -st none -pt topic157_1_0 -u 0.012171351672989827 > ./result_8chains/node157_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_0 -p 451 -st none -pt topic157_2_0 -u 0.004634479680021175 > ./result_8chains/node157_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_0 -p 627 -st none -pt topic157_3_0 -u 0.006615103765203301 > ./result_8chains/node157_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_0 -p 636 -st none -pt topic157_4_0 -u 0.029244361519878137 > ./result_8chains/node157_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_0 -p 747 -st none -pt topic157_5_0 -u 0.008616153532054471 > ./result_8chains/node157_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_0 -p 983 -st none -pt topic157_6_0 -u 0.00016139878710785815 > ./result_8chains/node157_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_0 -p 997 -st none -pt topic157_7_0 -u 0.09441008623751634 > ./result_8chains/node157_7_0.txt &
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
    "./result_8chains/node157_0_0.txt 90"
    "./result_8chains/node157_0_2.txt 90"
    "./result_8chains/node157_1_0.txt 89"
    "./result_8chains/node157_1_2.txt 89"
    "./result_8chains/node157_2_0.txt 88"
    "./result_8chains/node157_2_2.txt 88"
    "./result_8chains/node157_3_0.txt 87"
    "./result_8chains/node157_3_2.txt 87"
    "./result_8chains/node157_4_0.txt 86"
    "./result_8chains/node157_4_2.txt 86"
    "./result_8chains/node157_5_0.txt 85"
    "./result_8chains/node157_5_2.txt 85"
    "./result_8chains/node157_6_0.txt 84"
    "./result_8chains/node157_6_2.txt 84"
    "./result_8chains/node157_7_0.txt 83"
    "./result_8chains/node157_7_2.txt 83"
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
