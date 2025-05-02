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
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_2 -p 29 -st topic242_0_1 -pt None -u 0.03803325661035872 > ./result_8chains/node242_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_2 -p 412 -st topic242_1_1 -pt None -u 0.014844528669797019 > ./result_8chains/node242_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_2 -p 554 -st topic242_2_1 -pt None -u 0.004885438593625335 > ./result_8chains/node242_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_2 -p 654 -st topic242_3_1 -pt None -u 0.001318661532572818 > ./result_8chains/node242_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_2 -p 760 -st topic242_4_1 -pt None -u 0.05593066076562886 > ./result_8chains/node242_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_2 -p 764 -st topic242_5_1 -pt None -u 0.0049418062484483105 > ./result_8chains/node242_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_2 -p 789 -st topic242_6_1 -pt None -u 0.025776803211595936 > ./result_8chains/node242_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_2 -p 899 -st topic242_7_1 -pt None -u 0.04102140523452188 > ./result_8chains/node242_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_0 -p 29 -st none -pt topic242_0_0 -u 0.0263804041024559 > ./result_8chains/node242_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_0 -p 412 -st none -pt topic242_1_0 -u 0.007231424618131865 > ./result_8chains/node242_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_0 -p 554 -st none -pt topic242_2_0 -u 0.006948218786541893 > ./result_8chains/node242_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_0 -p 654 -st none -pt topic242_3_0 -u 0.040995506044427255 > ./result_8chains/node242_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_0 -p 760 -st none -pt topic242_4_0 -u 0.005468696932247108 > ./result_8chains/node242_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_0 -p 764 -st none -pt topic242_5_0 -u 0.02409192099077123 > ./result_8chains/node242_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_0 -p 789 -st none -pt topic242_6_0 -u 0.005601407617028931 > ./result_8chains/node242_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_0 -p 899 -st none -pt topic242_7_0 -u 0.04642737480051698 > ./result_8chains/node242_7_0.txt &
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
    "./result_8chains/node242_0_0.txt 90"
    "./result_8chains/node242_0_2.txt 90"
    "./result_8chains/node242_1_0.txt 89"
    "./result_8chains/node242_1_2.txt 89"
    "./result_8chains/node242_2_0.txt 88"
    "./result_8chains/node242_2_2.txt 88"
    "./result_8chains/node242_3_0.txt 87"
    "./result_8chains/node242_3_2.txt 87"
    "./result_8chains/node242_4_0.txt 86"
    "./result_8chains/node242_4_2.txt 86"
    "./result_8chains/node242_5_0.txt 85"
    "./result_8chains/node242_5_2.txt 85"
    "./result_8chains/node242_6_0.txt 84"
    "./result_8chains/node242_6_2.txt 84"
    "./result_8chains/node242_7_0.txt 83"
    "./result_8chains/node242_7_2.txt 83"
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
