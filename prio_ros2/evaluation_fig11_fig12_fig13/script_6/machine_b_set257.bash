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
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_1 -p 50 -st topic257_0_0 -pt topic257_0_1 -u 0.0010284303282594998 > ./result_6chains/node257_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_1 -p 62 -st topic257_1_0 -pt topic257_1_1 -u 0.01414583847079015 > ./result_6chains/node257_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_1 -p 265 -st topic257_2_0 -pt topic257_2_1 -u 0.003161543111774523 > ./result_6chains/node257_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_1 -p 515 -st topic257_3_0 -pt topic257_3_1 -u 0.022669689934345927 > ./result_6chains/node257_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_1 -p 697 -st topic257_4_0 -pt topic257_4_1 -u 0.014662294147712085 > ./result_6chains/node257_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_1 -p 759 -st topic257_5_0 -pt topic257_5_1 -u 0.026409223241637924 > ./result_6chains/node257_5_1.txt &
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
    "./result_6chains/node257_0_1.txt 90"
    "./result_6chains/node257_1_1.txt 89"
    "./result_6chains/node257_2_1.txt 88"
    "./result_6chains/node257_3_1.txt 87"
    "./result_6chains/node257_4_1.txt 86"
    "./result_6chains/node257_5_1.txt 85"
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
