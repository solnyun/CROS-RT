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
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_2 -p 72 -st topic12_0_1 -pt None -u 0.04110457895999231 > ./result_8chains/node12_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_2 -p 152 -st topic12_1_1 -pt None -u 0.0020064380192898468 > ./result_8chains/node12_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_2 -p 424 -st topic12_2_1 -pt None -u 0.038202647532011996 > ./result_8chains/node12_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_2 -p 632 -st topic12_3_1 -pt None -u 0.0011247967469184827 > ./result_8chains/node12_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_2 -p 695 -st topic12_4_1 -pt None -u 0.0029399700808959706 > ./result_8chains/node12_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_2 -p 799 -st topic12_5_1 -pt None -u 0.018709590454166522 > ./result_8chains/node12_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_2 -p 860 -st topic12_6_1 -pt None -u 0.01890017899486019 > ./result_8chains/node12_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_2 -p 877 -st topic12_7_1 -pt None -u 0.006580662176267475 > ./result_8chains/node12_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_0 -p 72 -st none -pt topic12_0_0 -u 0.010375495127577794 > ./result_8chains/node12_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_0 -p 152 -st none -pt topic12_1_0 -u 0.07249681693948973 > ./result_8chains/node12_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_0 -p 424 -st none -pt topic12_2_0 -u 0.008005969198026541 > ./result_8chains/node12_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_0 -p 632 -st none -pt topic12_3_0 -u 7.010514673760904e-05 > ./result_8chains/node12_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_0 -p 695 -st none -pt topic12_4_0 -u 0.011334150962174494 > ./result_8chains/node12_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_0 -p 799 -st none -pt topic12_5_0 -u 0.00022966010125205494 > ./result_8chains/node12_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_0 -p 860 -st none -pt topic12_6_0 -u 0.025688992733113536 > ./result_8chains/node12_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_0 -p 877 -st none -pt topic12_7_0 -u 0.0012224755800249731 > ./result_8chains/node12_7_0.txt &
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
    "./result_8chains/node12_0_0.txt 90"
    "./result_8chains/node12_0_2.txt 90"
    "./result_8chains/node12_1_0.txt 89"
    "./result_8chains/node12_1_2.txt 89"
    "./result_8chains/node12_2_0.txt 88"
    "./result_8chains/node12_2_2.txt 88"
    "./result_8chains/node12_3_0.txt 87"
    "./result_8chains/node12_3_2.txt 87"
    "./result_8chains/node12_4_0.txt 86"
    "./result_8chains/node12_4_2.txt 86"
    "./result_8chains/node12_5_0.txt 85"
    "./result_8chains/node12_5_2.txt 85"
    "./result_8chains/node12_6_0.txt 84"
    "./result_8chains/node12_6_2.txt 84"
    "./result_8chains/node12_7_0.txt 83"
    "./result_8chains/node12_7_2.txt 83"
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
