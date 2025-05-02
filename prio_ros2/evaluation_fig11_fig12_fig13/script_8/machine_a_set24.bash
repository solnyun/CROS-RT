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
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_2 -p 267 -st topic24_0_1 -pt None -u 0.010694579126354797 > ./result_8chains/node24_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_2 -p 292 -st topic24_1_1 -pt None -u 0.015675326372504628 > ./result_8chains/node24_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_2 -p 317 -st topic24_2_1 -pt None -u 0.05244753864822499 > ./result_8chains/node24_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_2 -p 321 -st topic24_3_1 -pt None -u 0.0183154951887865 > ./result_8chains/node24_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_2 -p 500 -st topic24_4_1 -pt None -u 0.0018365686490229294 > ./result_8chains/node24_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_2 -p 561 -st topic24_5_1 -pt None -u 0.013452633379589407 > ./result_8chains/node24_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_6_2 -p 665 -st topic24_6_1 -pt None -u 0.09698753602155488 > ./result_8chains/node24_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_7_2 -p 924 -st topic24_7_1 -pt None -u 0.0037514564281857263 > ./result_8chains/node24_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_0 -p 267 -st none -pt topic24_0_0 -u 0.0024699997419839193 > ./result_8chains/node24_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_0 -p 292 -st none -pt topic24_1_0 -u 0.07984346200172326 > ./result_8chains/node24_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_0 -p 317 -st none -pt topic24_2_0 -u 0.025341786928012755 > ./result_8chains/node24_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_0 -p 321 -st none -pt topic24_3_0 -u 0.011938090363074305 > ./result_8chains/node24_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_0 -p 500 -st none -pt topic24_4_0 -u 0.007059113463776606 > ./result_8chains/node24_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_0 -p 561 -st none -pt topic24_5_0 -u 0.0014751454078478776 > ./result_8chains/node24_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_6_0 -p 665 -st none -pt topic24_6_0 -u 0.02220692782406311 > ./result_8chains/node24_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_7_0 -p 924 -st none -pt topic24_7_0 -u 0.019065198611756498 > ./result_8chains/node24_7_0.txt &
sleep 10
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
    "./result_8chains/node24_0_0.txt 90"
    "./result_8chains/node24_0_2.txt 90"
    "./result_8chains/node24_1_0.txt 89"
    "./result_8chains/node24_1_2.txt 89"
    "./result_8chains/node24_2_0.txt 88"
    "./result_8chains/node24_2_2.txt 88"
    "./result_8chains/node24_3_0.txt 87"
    "./result_8chains/node24_3_2.txt 87"
    "./result_8chains/node24_4_0.txt 86"
    "./result_8chains/node24_4_2.txt 86"
    "./result_8chains/node24_5_0.txt 85"
    "./result_8chains/node24_5_2.txt 85"
    "./result_8chains/node24_6_0.txt 84"
    "./result_8chains/node24_6_2.txt 84"
    "./result_8chains/node24_7_0.txt 83"
    "./result_8chains/node24_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
