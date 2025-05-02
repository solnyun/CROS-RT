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
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_2 -p 112 -st topic382_0_1 -pt None -u 0.01386681278901869 > ./result_10chains/node382_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_2 -p 318 -st topic382_1_1 -pt None -u 0.0271070348049674 > ./result_10chains/node382_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_2 -p 401 -st topic382_2_1 -pt None -u 0.04553795041884423 > ./result_10chains/node382_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_2 -p 409 -st topic382_3_1 -pt None -u 0.018996905200790892 > ./result_10chains/node382_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_2 -p 531 -st topic382_4_1 -pt None -u 0.0037843309572763717 > ./result_10chains/node382_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_2 -p 537 -st topic382_5_1 -pt None -u 0.00842331804496993 > ./result_10chains/node382_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_6_2 -p 588 -st topic382_6_1 -pt None -u 0.0045606385653438886 > ./result_10chains/node382_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_7_2 -p 718 -st topic382_7_1 -pt None -u 0.015255493385689656 > ./result_10chains/node382_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_8_2 -p 774 -st topic382_8_1 -pt None -u 0.03896143757458792 > ./result_10chains/node382_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_9_2 -p 951 -st topic382_9_1 -pt None -u 0.002046160901056815 > ./result_10chains/node382_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_0 -p 112 -st none -pt topic382_0_0 -u 0.0014121025686744115 > ./result_10chains/node382_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_0 -p 318 -st none -pt topic382_1_0 -u 0.002852505709704134 > ./result_10chains/node382_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_0 -p 401 -st none -pt topic382_2_0 -u 0.016423538564548812 > ./result_10chains/node382_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_0 -p 409 -st none -pt topic382_3_0 -u 0.005226108572885857 > ./result_10chains/node382_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_0 -p 531 -st none -pt topic382_4_0 -u 0.010031351287925372 > ./result_10chains/node382_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_0 -p 537 -st none -pt topic382_5_0 -u 0.004940321483871801 > ./result_10chains/node382_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_6_0 -p 588 -st none -pt topic382_6_0 -u 0.02240781805109099 > ./result_10chains/node382_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_7_0 -p 718 -st none -pt topic382_7_0 -u 0.015062347983507335 > ./result_10chains/node382_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_8_0 -p 774 -st none -pt topic382_8_0 -u 0.00011339844416446976 > ./result_10chains/node382_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_9_0 -p 951 -st none -pt topic382_9_0 -u 0.05148923316196972 > ./result_10chains/node382_9_0.txt &
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
    "./result_10chains/node382_0_0.txt 90"
    "./result_10chains/node382_0_2.txt 90"
    "./result_10chains/node382_1_0.txt 89"
    "./result_10chains/node382_1_2.txt 89"
    "./result_10chains/node382_2_0.txt 88"
    "./result_10chains/node382_2_2.txt 88"
    "./result_10chains/node382_3_0.txt 87"
    "./result_10chains/node382_3_2.txt 87"
    "./result_10chains/node382_4_0.txt 86"
    "./result_10chains/node382_4_2.txt 86"
    "./result_10chains/node382_5_0.txt 85"
    "./result_10chains/node382_5_2.txt 85"
    "./result_10chains/node382_6_0.txt 84"
    "./result_10chains/node382_6_2.txt 84"
    "./result_10chains/node382_7_0.txt 83"
    "./result_10chains/node382_7_2.txt 83"
    "./result_10chains/node382_8_0.txt 82"
    "./result_10chains/node382_8_2.txt 82"
    "./result_10chains/node382_9_0.txt 81"
    "./result_10chains/node382_9_2.txt 81"
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
