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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_2 -p 30 -st topic40_0_1 -pt None -u 0.10664290670605492 > ./result_8chains/node40_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_2 -p 91 -st topic40_1_1 -pt None -u 0.013669221008019428 > ./result_8chains/node40_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_2 -p 388 -st topic40_2_1 -pt None -u 0.003140228960270497 > ./result_8chains/node40_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_2 -p 458 -st topic40_3_1 -pt None -u 0.0055969682797752385 > ./result_8chains/node40_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_2 -p 549 -st topic40_4_1 -pt None -u 0.017368278162244483 > ./result_8chains/node40_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_2 -p 591 -st topic40_5_1 -pt None -u 0.051914454245869116 > ./result_8chains/node40_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_2 -p 650 -st topic40_6_1 -pt None -u 0.011452028760891006 > ./result_8chains/node40_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_2 -p 916 -st topic40_7_1 -pt None -u 0.00762055350912067 > ./result_8chains/node40_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_0 -p 30 -st none -pt topic40_0_0 -u 0.04427181098910965 > ./result_8chains/node40_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_0 -p 91 -st none -pt topic40_1_0 -u 0.005724516692995452 > ./result_8chains/node40_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_0 -p 388 -st none -pt topic40_2_0 -u 0.03636871672161909 > ./result_8chains/node40_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_0 -p 458 -st none -pt topic40_3_0 -u 0.015045030317153707 > ./result_8chains/node40_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_0 -p 549 -st none -pt topic40_4_0 -u 0.021198462642127325 > ./result_8chains/node40_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_0 -p 591 -st none -pt topic40_5_0 -u 8.612708890975984e-05 > ./result_8chains/node40_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_0 -p 650 -st none -pt topic40_6_0 -u 0.0033203229789252053 > ./result_8chains/node40_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_0 -p 916 -st none -pt topic40_7_0 -u 0.010704150591162302 > ./result_8chains/node40_7_0.txt &
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
    "./result_8chains/node40_0_0.txt 90"
    "./result_8chains/node40_0_2.txt 90"
    "./result_8chains/node40_1_0.txt 89"
    "./result_8chains/node40_1_2.txt 89"
    "./result_8chains/node40_2_0.txt 88"
    "./result_8chains/node40_2_2.txt 88"
    "./result_8chains/node40_3_0.txt 87"
    "./result_8chains/node40_3_2.txt 87"
    "./result_8chains/node40_4_0.txt 86"
    "./result_8chains/node40_4_2.txt 86"
    "./result_8chains/node40_5_0.txt 85"
    "./result_8chains/node40_5_2.txt 85"
    "./result_8chains/node40_6_0.txt 84"
    "./result_8chains/node40_6_2.txt 84"
    "./result_8chains/node40_7_0.txt 83"
    "./result_8chains/node40_7_2.txt 83"
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
