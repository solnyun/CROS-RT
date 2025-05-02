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
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_2 -p 245 -st topic389_0_1 -pt None -u 0.009833229868126736 > ./result_8chains/node389_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_2 -p 284 -st topic389_1_1 -pt None -u 0.0007304039973954901 > ./result_8chains/node389_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_2 -p 316 -st topic389_2_1 -pt None -u 0.01608473207695721 > ./result_8chains/node389_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_2 -p 347 -st topic389_3_1 -pt None -u 0.015955493654039643 > ./result_8chains/node389_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_2 -p 380 -st topic389_4_1 -pt None -u 0.020439593144227913 > ./result_8chains/node389_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_2 -p 683 -st topic389_5_1 -pt None -u 0.013140688771655001 > ./result_8chains/node389_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_2 -p 772 -st topic389_6_1 -pt None -u 0.004905082878502887 > ./result_8chains/node389_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_2 -p 831 -st topic389_7_1 -pt None -u 0.0016419837323795703 > ./result_8chains/node389_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_0 -p 245 -st none -pt topic389_0_0 -u 0.013465311757731246 > ./result_8chains/node389_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_0 -p 284 -st none -pt topic389_1_0 -u 0.0014402233403210674 > ./result_8chains/node389_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_0 -p 316 -st none -pt topic389_2_0 -u 0.01986065880590049 > ./result_8chains/node389_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_0 -p 347 -st none -pt topic389_3_0 -u 0.0026057578064180853 > ./result_8chains/node389_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_0 -p 380 -st none -pt topic389_4_0 -u 0.03216883382872188 > ./result_8chains/node389_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_0 -p 683 -st none -pt topic389_5_0 -u 0.014079522901915248 > ./result_8chains/node389_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_0 -p 772 -st none -pt topic389_6_0 -u 0.006587248616846286 > ./result_8chains/node389_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_0 -p 831 -st none -pt topic389_7_0 -u 0.11525934182185513 > ./result_8chains/node389_7_0.txt &
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
    "./result_8chains/node389_0_0.txt 90"
    "./result_8chains/node389_0_2.txt 90"
    "./result_8chains/node389_1_0.txt 89"
    "./result_8chains/node389_1_2.txt 89"
    "./result_8chains/node389_2_0.txt 88"
    "./result_8chains/node389_2_2.txt 88"
    "./result_8chains/node389_3_0.txt 87"
    "./result_8chains/node389_3_2.txt 87"
    "./result_8chains/node389_4_0.txt 86"
    "./result_8chains/node389_4_2.txt 86"
    "./result_8chains/node389_5_0.txt 85"
    "./result_8chains/node389_5_2.txt 85"
    "./result_8chains/node389_6_0.txt 84"
    "./result_8chains/node389_6_2.txt 84"
    "./result_8chains/node389_7_0.txt 83"
    "./result_8chains/node389_7_2.txt 83"
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
