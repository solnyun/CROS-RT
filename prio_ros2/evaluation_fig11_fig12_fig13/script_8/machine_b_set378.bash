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
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_1 -p 88 -st topic378_0_0 -pt topic378_0_1 -u 5.678801788766563e-05 > ./result_8chains/node378_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_1 -p 138 -st topic378_1_0 -pt topic378_1_1 -u 0.009195343363733732 > ./result_8chains/node378_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_1 -p 322 -st topic378_2_0 -pt topic378_2_1 -u 0.11334700124022229 > ./result_8chains/node378_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_1 -p 421 -st topic378_3_0 -pt topic378_3_1 -u 0.004467708630676581 > ./result_8chains/node378_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_1 -p 497 -st topic378_4_0 -pt topic378_4_1 -u 0.021656531191474065 > ./result_8chains/node378_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_1 -p 557 -st topic378_5_0 -pt topic378_5_1 -u 0.0033154295984546 > ./result_8chains/node378_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_1 -p 607 -st topic378_6_0 -pt topic378_6_1 -u 0.02821028916175372 > ./result_8chains/node378_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_1 -p 940 -st topic378_7_0 -pt topic378_7_1 -u 0.017247268983264723 > ./result_8chains/node378_7_1.txt &
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
    "./result_8chains/node378_0_1.txt 90"
    "./result_8chains/node378_1_1.txt 89"
    "./result_8chains/node378_2_1.txt 88"
    "./result_8chains/node378_3_1.txt 87"
    "./result_8chains/node378_4_1.txt 86"
    "./result_8chains/node378_5_1.txt 85"
    "./result_8chains/node378_6_1.txt 84"
    "./result_8chains/node378_7_1.txt 83"
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
