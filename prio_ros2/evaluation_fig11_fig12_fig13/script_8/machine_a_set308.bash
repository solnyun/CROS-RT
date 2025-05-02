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
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_2 -p 277 -st topic308_0_1 -pt None -u 0.0020239232225441883 > ./result_8chains/node308_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_2 -p 540 -st topic308_1_1 -pt None -u 0.03814079911919477 > ./result_8chains/node308_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_2 -p 726 -st topic308_2_1 -pt None -u 0.0025316412277276434 > ./result_8chains/node308_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_2 -p 740 -st topic308_3_1 -pt None -u 0.0019030553699596608 > ./result_8chains/node308_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_2 -p 752 -st topic308_4_1 -pt None -u 0.021811687654974904 > ./result_8chains/node308_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_2 -p 954 -st topic308_5_1 -pt None -u 0.09355754052560918 > ./result_8chains/node308_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_6_2 -p 967 -st topic308_6_1 -pt None -u 0.004871854451999648 > ./result_8chains/node308_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_7_2 -p 993 -st topic308_7_1 -pt None -u 0.000449778888191624 > ./result_8chains/node308_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_0 -p 277 -st none -pt topic308_0_0 -u 0.014539477959960023 > ./result_8chains/node308_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_0 -p 540 -st none -pt topic308_1_0 -u 0.05858686155504744 > ./result_8chains/node308_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_0 -p 726 -st none -pt topic308_2_0 -u 0.007198252773470637 > ./result_8chains/node308_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_0 -p 740 -st none -pt topic308_3_0 -u 0.01046996357481883 > ./result_8chains/node308_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_0 -p 752 -st none -pt topic308_4_0 -u 0.04237793547476329 > ./result_8chains/node308_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_0 -p 954 -st none -pt topic308_5_0 -u 0.03517819500248731 > ./result_8chains/node308_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_6_0 -p 967 -st none -pt topic308_6_0 -u 0.033994760662132854 > ./result_8chains/node308_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_7_0 -p 993 -st none -pt topic308_7_0 -u 0.0008981084371705288 > ./result_8chains/node308_7_0.txt &
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
    "./result_8chains/node308_0_0.txt 90"
    "./result_8chains/node308_0_2.txt 90"
    "./result_8chains/node308_1_0.txt 89"
    "./result_8chains/node308_1_2.txt 89"
    "./result_8chains/node308_2_0.txt 88"
    "./result_8chains/node308_2_2.txt 88"
    "./result_8chains/node308_3_0.txt 87"
    "./result_8chains/node308_3_2.txt 87"
    "./result_8chains/node308_4_0.txt 86"
    "./result_8chains/node308_4_2.txt 86"
    "./result_8chains/node308_5_0.txt 85"
    "./result_8chains/node308_5_2.txt 85"
    "./result_8chains/node308_6_0.txt 84"
    "./result_8chains/node308_6_2.txt 84"
    "./result_8chains/node308_7_0.txt 83"
    "./result_8chains/node308_7_2.txt 83"
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
