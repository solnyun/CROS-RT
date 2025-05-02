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
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_2 -p 252 -st topic243_0_1 -pt None -u 0.04208741257058857 > ./result_8chains/node243_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_2 -p 431 -st topic243_1_1 -pt None -u 0.018033325048160853 > ./result_8chains/node243_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_2 -p 447 -st topic243_2_1 -pt None -u 0.014690456339016444 > ./result_8chains/node243_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_2 -p 462 -st topic243_3_1 -pt None -u 0.038705371887473805 > ./result_8chains/node243_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_2 -p 481 -st topic243_4_1 -pt None -u 0.003899084780470713 > ./result_8chains/node243_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_2 -p 522 -st topic243_5_1 -pt None -u 0.04007007613059603 > ./result_8chains/node243_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_2 -p 687 -st topic243_6_1 -pt None -u 0.03230167502577426 > ./result_8chains/node243_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_2 -p 933 -st topic243_7_1 -pt None -u 0.012381618588034517 > ./result_8chains/node243_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_0 -p 252 -st none -pt topic243_0_0 -u 0.04625004024828572 > ./result_8chains/node243_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_0 -p 431 -st none -pt topic243_1_0 -u 0.02799340736462297 > ./result_8chains/node243_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_0 -p 447 -st none -pt topic243_2_0 -u 0.014498428845709288 > ./result_8chains/node243_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_0 -p 462 -st none -pt topic243_3_0 -u 0.007144827246512664 > ./result_8chains/node243_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_0 -p 481 -st none -pt topic243_4_0 -u 0.0008192905984361343 > ./result_8chains/node243_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_0 -p 522 -st none -pt topic243_5_0 -u 0.055053898340408386 > ./result_8chains/node243_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_0 -p 687 -st none -pt topic243_6_0 -u 0.0264884187207403 > ./result_8chains/node243_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_0 -p 933 -st none -pt topic243_7_0 -u 0.0026812714580624654 > ./result_8chains/node243_7_0.txt &
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
    "./result_8chains/node243_0_0.txt 90"
    "./result_8chains/node243_0_2.txt 90"
    "./result_8chains/node243_1_0.txt 89"
    "./result_8chains/node243_1_2.txt 89"
    "./result_8chains/node243_2_0.txt 88"
    "./result_8chains/node243_2_2.txt 88"
    "./result_8chains/node243_3_0.txt 87"
    "./result_8chains/node243_3_2.txt 87"
    "./result_8chains/node243_4_0.txt 86"
    "./result_8chains/node243_4_2.txt 86"
    "./result_8chains/node243_5_0.txt 85"
    "./result_8chains/node243_5_2.txt 85"
    "./result_8chains/node243_6_0.txt 84"
    "./result_8chains/node243_6_2.txt 84"
    "./result_8chains/node243_7_0.txt 83"
    "./result_8chains/node243_7_2.txt 83"
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
