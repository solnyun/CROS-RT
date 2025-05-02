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
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_1 -p 45 -st topic27_0_0 -pt topic27_0_1 -u 0.030970825037747618 > ./result_8chains/node27_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_1 -p 329 -st topic27_1_0 -pt topic27_1_1 -u 0.03906725639818326 > ./result_8chains/node27_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_1 -p 437 -st topic27_2_0 -pt topic27_2_1 -u 0.032765627724004875 > ./result_8chains/node27_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_1 -p 518 -st topic27_3_0 -pt topic27_3_1 -u 0.017121125658224934 > ./result_8chains/node27_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_1 -p 547 -st topic27_4_0 -pt topic27_4_1 -u 0.06150135050693467 > ./result_8chains/node27_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_1 -p 778 -st topic27_5_0 -pt topic27_5_1 -u 0.03837079092706261 > ./result_8chains/node27_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_1 -p 815 -st topic27_6_0 -pt topic27_6_1 -u 6.723550412034152e-05 > ./result_8chains/node27_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_1 -p 973 -st topic27_7_0 -pt topic27_7_1 -u 0.033015257178734644 > ./result_8chains/node27_7_1.txt &
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
    "./result_8chains/node27_0_1.txt 90"
    "./result_8chains/node27_1_1.txt 89"
    "./result_8chains/node27_2_1.txt 88"
    "./result_8chains/node27_3_1.txt 87"
    "./result_8chains/node27_4_1.txt 86"
    "./result_8chains/node27_5_1.txt 85"
    "./result_8chains/node27_6_1.txt 84"
    "./result_8chains/node27_7_1.txt 83"
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
