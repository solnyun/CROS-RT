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
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_1 -p 255 -st topic7_0_0 -pt topic7_0_1 -u 0.010555472985141146 > ./result_8chains/node7_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_1 -p 293 -st topic7_1_0 -pt topic7_1_1 -u 0.021773306504260737 > ./result_8chains/node7_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_1 -p 313 -st topic7_2_0 -pt topic7_2_1 -u 0.029072609657635307 > ./result_8chains/node7_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_1 -p 477 -st topic7_3_0 -pt topic7_3_1 -u 0.03178089087580643 > ./result_8chains/node7_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_1 -p 720 -st topic7_4_0 -pt topic7_4_1 -u 0.003729317915532493 > ./result_8chains/node7_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_1 -p 799 -st topic7_5_0 -pt topic7_5_1 -u 0.02287733813438933 > ./result_8chains/node7_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_1 -p 932 -st topic7_6_0 -pt topic7_6_1 -u 0.01417770028778008 > ./result_8chains/node7_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_1 -p 961 -st topic7_7_0 -pt topic7_7_1 -u 0.0032402884993096657 > ./result_8chains/node7_7_1.txt &
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
    "./result_8chains/node7_0_1.txt 90"
    "./result_8chains/node7_1_1.txt 89"
    "./result_8chains/node7_2_1.txt 88"
    "./result_8chains/node7_3_1.txt 87"
    "./result_8chains/node7_4_1.txt 86"
    "./result_8chains/node7_5_1.txt 85"
    "./result_8chains/node7_6_1.txt 84"
    "./result_8chains/node7_7_1.txt 83"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
