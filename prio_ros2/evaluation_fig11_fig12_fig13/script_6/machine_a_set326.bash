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
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_2 -p 63 -st topic326_0_1 -pt None -u 0.00035209237090599865 > ./result_6chains/node326_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_2 -p 81 -st topic326_1_1 -pt None -u 0.036942921004267215 > ./result_6chains/node326_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_2 -p 414 -st topic326_2_1 -pt None -u 0.013304418929531103 > ./result_6chains/node326_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_2 -p 720 -st topic326_3_1 -pt None -u 0.0123095135273186 > ./result_6chains/node326_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_2 -p 887 -st topic326_4_1 -pt None -u 0.01751145487906456 > ./result_6chains/node326_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_2 -p 955 -st topic326_5_1 -pt None -u 0.0113873763396766 > ./result_6chains/node326_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_0 -p 63 -st none -pt topic326_0_0 -u 0.030764289250255428 > ./result_6chains/node326_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_0 -p 81 -st none -pt topic326_1_0 -u 0.03033601285452725 > ./result_6chains/node326_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_0 -p 414 -st none -pt topic326_2_0 -u 0.03120794566044144 > ./result_6chains/node326_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_0 -p 720 -st none -pt topic326_3_0 -u 0.11179058520739191 > ./result_6chains/node326_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_0 -p 887 -st none -pt topic326_4_0 -u 0.0008262121745072348 > ./result_6chains/node326_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_0 -p 955 -st none -pt topic326_5_0 -u 0.011442944471281646 > ./result_6chains/node326_5_0.txt &
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
    "./result_6chains/node326_0_0.txt 90"
    "./result_6chains/node326_0_2.txt 90"
    "./result_6chains/node326_1_0.txt 89"
    "./result_6chains/node326_1_2.txt 89"
    "./result_6chains/node326_2_0.txt 88"
    "./result_6chains/node326_2_2.txt 88"
    "./result_6chains/node326_3_0.txt 87"
    "./result_6chains/node326_3_2.txt 87"
    "./result_6chains/node326_4_0.txt 86"
    "./result_6chains/node326_4_2.txt 86"
    "./result_6chains/node326_5_0.txt 85"
    "./result_6chains/node326_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
