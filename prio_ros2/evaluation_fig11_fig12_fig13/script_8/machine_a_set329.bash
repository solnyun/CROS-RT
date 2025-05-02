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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_2 -p 63 -st topic329_0_1 -pt None -u 0.0035603602767041442 > ./result_8chains/node329_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_2 -p 64 -st topic329_1_1 -pt None -u 0.05961119049358071 > ./result_8chains/node329_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_2 -p 88 -st topic329_2_1 -pt None -u 0.018515678044453865 > ./result_8chains/node329_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_2 -p 281 -st topic329_3_1 -pt None -u 6.498758728068488e-05 > ./result_8chains/node329_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_2 -p 420 -st topic329_4_1 -pt None -u 0.00907144160569473 > ./result_8chains/node329_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_2 -p 500 -st topic329_5_1 -pt None -u 0.03645454804393172 > ./result_8chains/node329_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_6_2 -p 526 -st topic329_6_1 -pt None -u 0.00729330135319009 > ./result_8chains/node329_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_7_2 -p 546 -st topic329_7_1 -pt None -u 0.004454638442767024 > ./result_8chains/node329_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_0 -p 63 -st none -pt topic329_0_0 -u 0.029352157228691333 > ./result_8chains/node329_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_0 -p 64 -st none -pt topic329_1_0 -u 0.02100844264336349 > ./result_8chains/node329_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_0 -p 88 -st none -pt topic329_2_0 -u 0.013061469429765327 > ./result_8chains/node329_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_0 -p 281 -st none -pt topic329_3_0 -u 0.009042337447026816 > ./result_8chains/node329_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_0 -p 420 -st none -pt topic329_4_0 -u 0.016108939569165703 > ./result_8chains/node329_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_0 -p 500 -st none -pt topic329_5_0 -u 0.04439771355920921 > ./result_8chains/node329_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_6_0 -p 526 -st none -pt topic329_6_0 -u 0.04036350883698635 > ./result_8chains/node329_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_7_0 -p 546 -st none -pt topic329_7_0 -u 0.05037171596011205 > ./result_8chains/node329_7_0.txt &
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
    "./result_8chains/node329_0_0.txt 90"
    "./result_8chains/node329_0_2.txt 90"
    "./result_8chains/node329_1_0.txt 89"
    "./result_8chains/node329_1_2.txt 89"
    "./result_8chains/node329_2_0.txt 88"
    "./result_8chains/node329_2_2.txt 88"
    "./result_8chains/node329_3_0.txt 87"
    "./result_8chains/node329_3_2.txt 87"
    "./result_8chains/node329_4_0.txt 86"
    "./result_8chains/node329_4_2.txt 86"
    "./result_8chains/node329_5_0.txt 85"
    "./result_8chains/node329_5_2.txt 85"
    "./result_8chains/node329_6_0.txt 84"
    "./result_8chains/node329_6_2.txt 84"
    "./result_8chains/node329_7_0.txt 83"
    "./result_8chains/node329_7_2.txt 83"
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
