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
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_2 -p 63 -st topic173_0_1 -pt None -u 0.06567274108062188 > ./result_6chains/node173_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_2 -p 269 -st topic173_1_1 -pt None -u 0.004108488311643621 > ./result_6chains/node173_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_2 -p 500 -st topic173_2_1 -pt None -u 0.0410671027449227 > ./result_6chains/node173_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_2 -p 651 -st topic173_3_1 -pt None -u 0.017197992951415997 > ./result_6chains/node173_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_2 -p 684 -st topic173_4_1 -pt None -u 0.013355431018212988 > ./result_6chains/node173_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_2 -p 723 -st topic173_5_1 -pt None -u 0.028679155665904277 > ./result_6chains/node173_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_0 -p 63 -st none -pt topic173_0_0 -u 0.009087711019056033 > ./result_6chains/node173_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_0 -p 269 -st none -pt topic173_1_0 -u 0.004070681329569559 > ./result_6chains/node173_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_0 -p 500 -st none -pt topic173_2_0 -u 0.024854530575976252 > ./result_6chains/node173_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_0 -p 651 -st none -pt topic173_3_0 -u 0.037656333701878764 > ./result_6chains/node173_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_0 -p 684 -st none -pt topic173_4_0 -u 0.07304307590438919 > ./result_6chains/node173_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_0 -p 723 -st none -pt topic173_5_0 -u 0.05117448087032151 > ./result_6chains/node173_5_0.txt &
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
    "./result_6chains/node173_0_0.txt 90"
    "./result_6chains/node173_0_2.txt 90"
    "./result_6chains/node173_1_0.txt 89"
    "./result_6chains/node173_1_2.txt 89"
    "./result_6chains/node173_2_0.txt 88"
    "./result_6chains/node173_2_2.txt 88"
    "./result_6chains/node173_3_0.txt 87"
    "./result_6chains/node173_3_2.txt 87"
    "./result_6chains/node173_4_0.txt 86"
    "./result_6chains/node173_4_2.txt 86"
    "./result_6chains/node173_5_0.txt 85"
    "./result_6chains/node173_5_2.txt 85"
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
