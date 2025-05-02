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
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_2 -p 32 -st topic143_0_1 -pt None -u 0.04390998769155968 > ./result_6chains/node143_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_2 -p 79 -st topic143_1_1 -pt None -u 0.01979278520057967 > ./result_6chains/node143_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_2 -p 247 -st topic143_2_1 -pt None -u 0.021067237358418048 > ./result_6chains/node143_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_2 -p 393 -st topic143_3_1 -pt None -u 0.01762993473075393 > ./result_6chains/node143_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_2 -p 866 -st topic143_4_1 -pt None -u 0.01538475633225348 > ./result_6chains/node143_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_2 -p 985 -st topic143_5_1 -pt None -u 0.0037655935236204025 > ./result_6chains/node143_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_0 -p 32 -st none -pt topic143_0_0 -u 0.12237010213305255 > ./result_6chains/node143_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_0 -p 79 -st none -pt topic143_1_0 -u 0.045752125714587144 > ./result_6chains/node143_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_0 -p 247 -st none -pt topic143_2_0 -u 0.007681915251268406 > ./result_6chains/node143_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_0 -p 393 -st none -pt topic143_3_0 -u 0.003836835910348821 > ./result_6chains/node143_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_0 -p 866 -st none -pt topic143_4_0 -u 0.012238123853642244 > ./result_6chains/node143_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_0 -p 985 -st none -pt topic143_5_0 -u 0.001442566684387499 > ./result_6chains/node143_5_0.txt &
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
    "./result_6chains/node143_0_0.txt 90"
    "./result_6chains/node143_0_2.txt 90"
    "./result_6chains/node143_1_0.txt 89"
    "./result_6chains/node143_1_2.txt 89"
    "./result_6chains/node143_2_0.txt 88"
    "./result_6chains/node143_2_2.txt 88"
    "./result_6chains/node143_3_0.txt 87"
    "./result_6chains/node143_3_2.txt 87"
    "./result_6chains/node143_4_0.txt 86"
    "./result_6chains/node143_4_2.txt 86"
    "./result_6chains/node143_5_0.txt 85"
    "./result_6chains/node143_5_2.txt 85"
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
