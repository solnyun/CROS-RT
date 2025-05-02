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
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_1 -p 105 -st topic363_0_0 -pt topic363_0_1 -u 0.05775599854687091 > ./result_8chains/node363_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_1 -p 132 -st topic363_1_0 -pt topic363_1_1 -u 0.01533905589360851 > ./result_8chains/node363_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_1 -p 172 -st topic363_2_0 -pt topic363_2_1 -u 0.015111573280024104 > ./result_8chains/node363_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_1 -p 313 -st topic363_3_0 -pt topic363_3_1 -u 0.009778746261268234 > ./result_8chains/node363_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_1 -p 815 -st topic363_4_0 -pt topic363_4_1 -u 0.00927760420380172 > ./result_8chains/node363_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_1 -p 852 -st topic363_5_0 -pt topic363_5_1 -u 1.335817734884892e-05 > ./result_8chains/node363_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_1 -p 866 -st topic363_6_0 -pt topic363_6_1 -u 0.016634417765670678 > ./result_8chains/node363_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_1 -p 992 -st topic363_7_0 -pt topic363_7_1 -u 0.03925273303480056 > ./result_8chains/node363_7_1.txt &
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
    "./result_8chains/node363_0_1.txt 90"
    "./result_8chains/node363_1_1.txt 89"
    "./result_8chains/node363_2_1.txt 88"
    "./result_8chains/node363_3_1.txt 87"
    "./result_8chains/node363_4_1.txt 86"
    "./result_8chains/node363_5_1.txt 85"
    "./result_8chains/node363_6_1.txt 84"
    "./result_8chains/node363_7_1.txt 83"
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
