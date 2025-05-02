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
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_2 -p 21 -st topic494_0_1 -pt None -u 0.0329267580118045 > ./result_10chains/node494_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_2 -p 122 -st topic494_1_1 -pt None -u 0.0015537438802891712 > ./result_10chains/node494_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_2 -p 215 -st topic494_2_1 -pt None -u 0.0024042366153377848 > ./result_10chains/node494_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_2 -p 284 -st topic494_3_1 -pt None -u 0.00026525166033480874 > ./result_10chains/node494_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_2 -p 606 -st topic494_4_1 -pt None -u 0.05025031451690809 > ./result_10chains/node494_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_2 -p 642 -st topic494_5_1 -pt None -u 0.020344424558765895 > ./result_10chains/node494_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_6_2 -p 670 -st topic494_6_1 -pt None -u 0.006964821212066957 > ./result_10chains/node494_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_7_2 -p 805 -st topic494_7_1 -pt None -u 0.002222570612254511 > ./result_10chains/node494_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_8_2 -p 951 -st topic494_8_1 -pt None -u 0.005178979753408357 > ./result_10chains/node494_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_9_2 -p 961 -st topic494_9_1 -pt None -u 0.03545667100818922 > ./result_10chains/node494_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_0 -p 21 -st none -pt topic494_0_0 -u 0.02051045935838114 > ./result_10chains/node494_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_0 -p 122 -st none -pt topic494_1_0 -u 0.0026862367108563268 > ./result_10chains/node494_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_0 -p 215 -st none -pt topic494_2_0 -u 0.02846910794731189 > ./result_10chains/node494_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_0 -p 284 -st none -pt topic494_3_0 -u 0.0004923994267521103 > ./result_10chains/node494_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_0 -p 606 -st none -pt topic494_4_0 -u 0.0007588451526064355 > ./result_10chains/node494_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_0 -p 642 -st none -pt topic494_5_0 -u 0.0004854799329913062 > ./result_10chains/node494_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_6_0 -p 670 -st none -pt topic494_6_0 -u 0.05172058323680792 > ./result_10chains/node494_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_7_0 -p 805 -st none -pt topic494_7_0 -u 0.07927099010702401 > ./result_10chains/node494_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_8_0 -p 951 -st none -pt topic494_8_0 -u 0.00037917082354698567 > ./result_10chains/node494_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_9_0 -p 961 -st none -pt topic494_9_0 -u 0.0009514895867788267 > ./result_10chains/node494_9_0.txt &
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
    "./result_10chains/node494_0_0.txt 90"
    "./result_10chains/node494_0_2.txt 90"
    "./result_10chains/node494_1_0.txt 89"
    "./result_10chains/node494_1_2.txt 89"
    "./result_10chains/node494_2_0.txt 88"
    "./result_10chains/node494_2_2.txt 88"
    "./result_10chains/node494_3_0.txt 87"
    "./result_10chains/node494_3_2.txt 87"
    "./result_10chains/node494_4_0.txt 86"
    "./result_10chains/node494_4_2.txt 86"
    "./result_10chains/node494_5_0.txt 85"
    "./result_10chains/node494_5_2.txt 85"
    "./result_10chains/node494_6_0.txt 84"
    "./result_10chains/node494_6_2.txt 84"
    "./result_10chains/node494_7_0.txt 83"
    "./result_10chains/node494_7_2.txt 83"
    "./result_10chains/node494_8_0.txt 82"
    "./result_10chains/node494_8_2.txt 82"
    "./result_10chains/node494_9_0.txt 81"
    "./result_10chains/node494_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
