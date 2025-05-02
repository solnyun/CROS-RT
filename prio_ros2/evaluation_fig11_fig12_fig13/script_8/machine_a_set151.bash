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
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_2 -p 237 -st topic151_0_1 -pt None -u 0.030952925622047378 > ./result_8chains/node151_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_2 -p 255 -st topic151_1_1 -pt None -u 0.023530554604403175 > ./result_8chains/node151_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_2 -p 352 -st topic151_2_1 -pt None -u 0.02791450157639158 > ./result_8chains/node151_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_2 -p 358 -st topic151_3_1 -pt None -u 0.020988074277484947 > ./result_8chains/node151_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_2 -p 443 -st topic151_4_1 -pt None -u 0.010643907824606558 > ./result_8chains/node151_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_2 -p 706 -st topic151_5_1 -pt None -u 0.025494791590853716 > ./result_8chains/node151_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_2 -p 780 -st topic151_6_1 -pt None -u 0.022055683889499023 > ./result_8chains/node151_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_2 -p 932 -st topic151_7_1 -pt None -u 0.020370613327103576 > ./result_8chains/node151_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_0 -p 237 -st none -pt topic151_0_0 -u 0.03006347834358558 > ./result_8chains/node151_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_0 -p 255 -st none -pt topic151_1_0 -u 0.015594352700577796 > ./result_8chains/node151_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_0 -p 352 -st none -pt topic151_2_0 -u 0.037399497665284 > ./result_8chains/node151_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_0 -p 358 -st none -pt topic151_3_0 -u 0.0076917774418335805 > ./result_8chains/node151_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_0 -p 443 -st none -pt topic151_4_0 -u 0.034421373494153834 > ./result_8chains/node151_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_0 -p 706 -st none -pt topic151_5_0 -u 0.0028505148236482036 > ./result_8chains/node151_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_0 -p 780 -st none -pt topic151_6_0 -u 0.04024969066648251 > ./result_8chains/node151_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_0 -p 932 -st none -pt topic151_7_0 -u 0.0037125010329071423 > ./result_8chains/node151_7_0.txt &
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
    "./result_8chains/node151_0_0.txt 90"
    "./result_8chains/node151_0_2.txt 90"
    "./result_8chains/node151_1_0.txt 89"
    "./result_8chains/node151_1_2.txt 89"
    "./result_8chains/node151_2_0.txt 88"
    "./result_8chains/node151_2_2.txt 88"
    "./result_8chains/node151_3_0.txt 87"
    "./result_8chains/node151_3_2.txt 87"
    "./result_8chains/node151_4_0.txt 86"
    "./result_8chains/node151_4_2.txt 86"
    "./result_8chains/node151_5_0.txt 85"
    "./result_8chains/node151_5_2.txt 85"
    "./result_8chains/node151_6_0.txt 84"
    "./result_8chains/node151_6_2.txt 84"
    "./result_8chains/node151_7_0.txt 83"
    "./result_8chains/node151_7_2.txt 83"
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
