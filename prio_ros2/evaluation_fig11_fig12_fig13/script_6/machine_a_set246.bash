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
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_2 -p 69 -st topic246_0_1 -pt None -u 0.00453669391257705 > ./result_6chains/node246_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_2 -p 512 -st topic246_1_1 -pt None -u 0.0678731574739116 > ./result_6chains/node246_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_2 -p 565 -st topic246_2_1 -pt None -u 0.033132211718033544 > ./result_6chains/node246_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_2 -p 748 -st topic246_3_1 -pt None -u 0.01914251029247177 > ./result_6chains/node246_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_2 -p 864 -st topic246_4_1 -pt None -u 0.004752368095692142 > ./result_6chains/node246_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_2 -p 941 -st topic246_5_1 -pt None -u 0.058486791139971475 > ./result_6chains/node246_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_0 -p 69 -st none -pt topic246_0_0 -u 0.06701631536108882 > ./result_6chains/node246_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_0 -p 512 -st none -pt topic246_1_0 -u 0.004645931198956288 > ./result_6chains/node246_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_0 -p 565 -st none -pt topic246_2_0 -u 0.024644088259852814 > ./result_6chains/node246_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_0 -p 748 -st none -pt topic246_3_0 -u 0.04476461294115738 > ./result_6chains/node246_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_0 -p 864 -st none -pt topic246_4_0 -u 0.005893868123744692 > ./result_6chains/node246_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_0 -p 941 -st none -pt topic246_5_0 -u 0.018146546279686482 > ./result_6chains/node246_5_0.txt &
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
    "./result_6chains/node246_0_0.txt 90"
    "./result_6chains/node246_0_2.txt 90"
    "./result_6chains/node246_1_0.txt 89"
    "./result_6chains/node246_1_2.txt 89"
    "./result_6chains/node246_2_0.txt 88"
    "./result_6chains/node246_2_2.txt 88"
    "./result_6chains/node246_3_0.txt 87"
    "./result_6chains/node246_3_2.txt 87"
    "./result_6chains/node246_4_0.txt 86"
    "./result_6chains/node246_4_2.txt 86"
    "./result_6chains/node246_5_0.txt 85"
    "./result_6chains/node246_5_2.txt 85"
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
