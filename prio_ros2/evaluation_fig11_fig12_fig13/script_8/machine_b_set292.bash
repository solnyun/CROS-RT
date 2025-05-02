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
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_1 -p 30 -st topic292_0_0 -pt topic292_0_1 -u 0.006358434665917012 > ./result_8chains/node292_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_1 -p 145 -st topic292_1_0 -pt topic292_1_1 -u 0.011756773925973074 > ./result_8chains/node292_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_1 -p 363 -st topic292_2_0 -pt topic292_2_1 -u 0.01395038785001429 > ./result_8chains/node292_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_1 -p 607 -st topic292_3_0 -pt topic292_3_1 -u 0.019212962255618 > ./result_8chains/node292_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_1 -p 700 -st topic292_4_0 -pt topic292_4_1 -u 0.004217706958145412 > ./result_8chains/node292_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_1 -p 857 -st topic292_5_0 -pt topic292_5_1 -u 0.009579311676214841 > ./result_8chains/node292_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_1 -p 858 -st topic292_6_0 -pt topic292_6_1 -u 0.024704418646904737 > ./result_8chains/node292_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_1 -p 953 -st topic292_7_0 -pt topic292_7_1 -u 0.0014170740388124389 > ./result_8chains/node292_7_1.txt &
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
    "./result_8chains/node292_0_1.txt 90"
    "./result_8chains/node292_1_1.txt 89"
    "./result_8chains/node292_2_1.txt 88"
    "./result_8chains/node292_3_1.txt 87"
    "./result_8chains/node292_4_1.txt 86"
    "./result_8chains/node292_5_1.txt 85"
    "./result_8chains/node292_6_1.txt 84"
    "./result_8chains/node292_7_1.txt 83"
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
