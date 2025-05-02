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
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_1 -p 210 -st topic75_0_0 -pt topic75_0_1 -u 0.007334392248875221 > ./result_8chains/node75_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_1 -p 227 -st topic75_1_0 -pt topic75_1_1 -u 0.01225559061808057 > ./result_8chains/node75_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_1 -p 326 -st topic75_2_0 -pt topic75_2_1 -u 0.037072412274748556 > ./result_8chains/node75_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_1 -p 406 -st topic75_3_0 -pt topic75_3_1 -u 0.013183261533383922 > ./result_8chains/node75_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_1 -p 434 -st topic75_4_0 -pt topic75_4_1 -u 0.007011706898441689 > ./result_8chains/node75_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_1 -p 736 -st topic75_5_0 -pt topic75_5_1 -u 0.0026133240754067366 > ./result_8chains/node75_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_1 -p 820 -st topic75_6_0 -pt topic75_6_1 -u 0.05618902374598502 > ./result_8chains/node75_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_1 -p 845 -st topic75_7_0 -pt topic75_7_1 -u 0.0020733877115212407 > ./result_8chains/node75_7_1.txt &
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
    "./result_8chains/node75_0_1.txt 90"
    "./result_8chains/node75_1_1.txt 89"
    "./result_8chains/node75_2_1.txt 88"
    "./result_8chains/node75_3_1.txt 87"
    "./result_8chains/node75_4_1.txt 86"
    "./result_8chains/node75_5_1.txt 85"
    "./result_8chains/node75_6_1.txt 84"
    "./result_8chains/node75_7_1.txt 83"
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
