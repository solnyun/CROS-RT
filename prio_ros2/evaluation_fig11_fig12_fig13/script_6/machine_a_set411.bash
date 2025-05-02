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
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_2 -p 156 -st topic411_0_1 -pt None -u 0.00044830278834046 > ./result_6chains/node411_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_2 -p 308 -st topic411_1_1 -pt None -u 0.021680277483621835 > ./result_6chains/node411_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_2 -p 698 -st topic411_2_1 -pt None -u 0.000940003417118529 > ./result_6chains/node411_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_2 -p 826 -st topic411_3_1 -pt None -u 0.024097429478802362 > ./result_6chains/node411_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_2 -p 946 -st topic411_4_1 -pt None -u 0.021491401008635946 > ./result_6chains/node411_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_2 -p 997 -st topic411_5_1 -pt None -u 0.0035751558349100686 > ./result_6chains/node411_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_0 -p 156 -st none -pt topic411_0_0 -u 0.024713105092155574 > ./result_6chains/node411_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_0 -p 308 -st none -pt topic411_1_0 -u 0.002641316574520214 > ./result_6chains/node411_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_0 -p 698 -st none -pt topic411_2_0 -u 0.024217618252619366 > ./result_6chains/node411_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_0 -p 826 -st none -pt topic411_3_0 -u 0.02745779564017392 > ./result_6chains/node411_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_0 -p 946 -st none -pt topic411_4_0 -u 0.0011969400434365396 > ./result_6chains/node411_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_0 -p 997 -st none -pt topic411_5_0 -u 0.11650700616646588 > ./result_6chains/node411_5_0.txt &
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
    "./result_6chains/node411_0_0.txt 90"
    "./result_6chains/node411_0_2.txt 90"
    "./result_6chains/node411_1_0.txt 89"
    "./result_6chains/node411_1_2.txt 89"
    "./result_6chains/node411_2_0.txt 88"
    "./result_6chains/node411_2_2.txt 88"
    "./result_6chains/node411_3_0.txt 87"
    "./result_6chains/node411_3_2.txt 87"
    "./result_6chains/node411_4_0.txt 86"
    "./result_6chains/node411_4_2.txt 86"
    "./result_6chains/node411_5_0.txt 85"
    "./result_6chains/node411_5_2.txt 85"
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
