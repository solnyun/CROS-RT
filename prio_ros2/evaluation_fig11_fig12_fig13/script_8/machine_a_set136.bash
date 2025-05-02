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
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_2 -p 137 -st topic136_0_1 -pt None -u 0.0192053983255146 > ./result_8chains/node136_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_2 -p 338 -st topic136_1_1 -pt None -u 3.1144264515614584e-05 > ./result_8chains/node136_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_2 -p 419 -st topic136_2_1 -pt None -u 0.02097304779201631 > ./result_8chains/node136_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_2 -p 487 -st topic136_3_1 -pt None -u 0.008718168904639667 > ./result_8chains/node136_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_2 -p 559 -st topic136_4_1 -pt None -u 0.027122167845223477 > ./result_8chains/node136_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_2 -p 652 -st topic136_5_1 -pt None -u 0.01194499852925801 > ./result_8chains/node136_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_6_2 -p 732 -st topic136_6_1 -pt None -u 0.04135099310867227 > ./result_8chains/node136_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_7_2 -p 913 -st topic136_7_1 -pt None -u 0.006282417708414139 > ./result_8chains/node136_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_0 -p 137 -st none -pt topic136_0_0 -u 0.028240323145575508 > ./result_8chains/node136_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_0 -p 338 -st none -pt topic136_1_0 -u 0.00895655347262192 > ./result_8chains/node136_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_0 -p 419 -st none -pt topic136_2_0 -u 0.07854064216158096 > ./result_8chains/node136_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_0 -p 487 -st none -pt topic136_3_0 -u 0.0009855246065827439 > ./result_8chains/node136_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_0 -p 559 -st none -pt topic136_4_0 -u 0.0181277851197737 > ./result_8chains/node136_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_0 -p 652 -st none -pt topic136_5_0 -u 0.006565334701511022 > ./result_8chains/node136_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_6_0 -p 732 -st none -pt topic136_6_0 -u 0.03282949267274529 > ./result_8chains/node136_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_7_0 -p 913 -st none -pt topic136_7_0 -u 0.0718426196709985 > ./result_8chains/node136_7_0.txt &
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
    "./result_8chains/node136_0_0.txt 90"
    "./result_8chains/node136_0_2.txt 90"
    "./result_8chains/node136_1_0.txt 89"
    "./result_8chains/node136_1_2.txt 89"
    "./result_8chains/node136_2_0.txt 88"
    "./result_8chains/node136_2_2.txt 88"
    "./result_8chains/node136_3_0.txt 87"
    "./result_8chains/node136_3_2.txt 87"
    "./result_8chains/node136_4_0.txt 86"
    "./result_8chains/node136_4_2.txt 86"
    "./result_8chains/node136_5_0.txt 85"
    "./result_8chains/node136_5_2.txt 85"
    "./result_8chains/node136_6_0.txt 84"
    "./result_8chains/node136_6_2.txt 84"
    "./result_8chains/node136_7_0.txt 83"
    "./result_8chains/node136_7_2.txt 83"
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
