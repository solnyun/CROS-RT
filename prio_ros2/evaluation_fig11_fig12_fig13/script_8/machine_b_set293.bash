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
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_1 -p 354 -st topic293_0_0 -pt topic293_0_1 -u 0.030662293556562803 > ./result_8chains/node293_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_1 -p 521 -st topic293_1_0 -pt topic293_1_1 -u 0.004718400063861039 > ./result_8chains/node293_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_1 -p 558 -st topic293_2_0 -pt topic293_2_1 -u 0.016630507833927166 > ./result_8chains/node293_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_1 -p 626 -st topic293_3_0 -pt topic293_3_1 -u 0.009337307494453828 > ./result_8chains/node293_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_1 -p 646 -st topic293_4_0 -pt topic293_4_1 -u 0.039684347930354 > ./result_8chains/node293_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_1 -p 651 -st topic293_5_0 -pt topic293_5_1 -u 0.019339100279200522 > ./result_8chains/node293_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_1 -p 698 -st topic293_6_0 -pt topic293_6_1 -u 0.04665598722887339 > ./result_8chains/node293_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_1 -p 801 -st topic293_7_0 -pt topic293_7_1 -u 0.021169881402260726 > ./result_8chains/node293_7_1.txt &
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
    "./result_8chains/node293_0_1.txt 90"
    "./result_8chains/node293_1_1.txt 89"
    "./result_8chains/node293_2_1.txt 88"
    "./result_8chains/node293_3_1.txt 87"
    "./result_8chains/node293_4_1.txt 86"
    "./result_8chains/node293_5_1.txt 85"
    "./result_8chains/node293_6_1.txt 84"
    "./result_8chains/node293_7_1.txt 83"
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
