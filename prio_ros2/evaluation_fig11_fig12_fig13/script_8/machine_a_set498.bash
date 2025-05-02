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
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_2 -p 68 -st topic498_0_1 -pt None -u 0.044089874335995816 > ./result_8chains/node498_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_2 -p 184 -st topic498_1_1 -pt None -u 0.04591331414894256 > ./result_8chains/node498_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_2 -p 324 -st topic498_2_1 -pt None -u 0.009180896480688538 > ./result_8chains/node498_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_2 -p 579 -st topic498_3_1 -pt None -u 0.0004216337570783768 > ./result_8chains/node498_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_2 -p 689 -st topic498_4_1 -pt None -u 0.016642631254066342 > ./result_8chains/node498_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_2 -p 729 -st topic498_5_1 -pt None -u 0.012221678975529698 > ./result_8chains/node498_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_2 -p 761 -st topic498_6_1 -pt None -u 0.00047946489127619757 > ./result_8chains/node498_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_2 -p 914 -st topic498_7_1 -pt None -u 0.02519692711525089 > ./result_8chains/node498_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_0 -p 68 -st none -pt topic498_0_0 -u 0.02158947406286893 > ./result_8chains/node498_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_0 -p 184 -st none -pt topic498_1_0 -u 0.04211272233843727 > ./result_8chains/node498_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_0 -p 324 -st none -pt topic498_2_0 -u 0.016077254405070074 > ./result_8chains/node498_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_0 -p 579 -st none -pt topic498_3_0 -u 0.03360688479746529 > ./result_8chains/node498_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_0 -p 689 -st none -pt topic498_4_0 -u 0.0065477172797815675 > ./result_8chains/node498_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_0 -p 729 -st none -pt topic498_5_0 -u 0.03316687366810653 > ./result_8chains/node498_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_0 -p 761 -st none -pt topic498_6_0 -u 0.03229931985230462 > ./result_8chains/node498_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_0 -p 914 -st none -pt topic498_7_0 -u 0.017645267483384137 > ./result_8chains/node498_7_0.txt &
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
    "./result_8chains/node498_0_0.txt 90"
    "./result_8chains/node498_0_2.txt 90"
    "./result_8chains/node498_1_0.txt 89"
    "./result_8chains/node498_1_2.txt 89"
    "./result_8chains/node498_2_0.txt 88"
    "./result_8chains/node498_2_2.txt 88"
    "./result_8chains/node498_3_0.txt 87"
    "./result_8chains/node498_3_2.txt 87"
    "./result_8chains/node498_4_0.txt 86"
    "./result_8chains/node498_4_2.txt 86"
    "./result_8chains/node498_5_0.txt 85"
    "./result_8chains/node498_5_2.txt 85"
    "./result_8chains/node498_6_0.txt 84"
    "./result_8chains/node498_6_2.txt 84"
    "./result_8chains/node498_7_0.txt 83"
    "./result_8chains/node498_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
