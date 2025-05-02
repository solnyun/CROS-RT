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
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_2 -p 119 -st topic317_0_1 -pt None -u 0.0006437537563847018 > ./result_10chains/node317_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_2 -p 174 -st topic317_1_1 -pt None -u 0.015270413073306288 > ./result_10chains/node317_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_2 -p 328 -st topic317_2_1 -pt None -u 0.010959254192471901 > ./result_10chains/node317_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_2 -p 347 -st topic317_3_1 -pt None -u 0.02284702986485948 > ./result_10chains/node317_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_2 -p 353 -st topic317_4_1 -pt None -u 0.0034422330390900813 > ./result_10chains/node317_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_2 -p 369 -st topic317_5_1 -pt None -u 0.022344937942829712 > ./result_10chains/node317_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_2 -p 396 -st topic317_6_1 -pt None -u 0.005148438413831613 > ./result_10chains/node317_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_2 -p 493 -st topic317_7_1 -pt None -u 0.0028723998022755493 > ./result_10chains/node317_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_8_2 -p 843 -st topic317_8_1 -pt None -u 0.020116973016646333 > ./result_10chains/node317_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_9_2 -p 960 -st topic317_9_1 -pt None -u 0.05003677827216435 > ./result_10chains/node317_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_0 -p 119 -st none -pt topic317_0_0 -u 0.01005512147243992 > ./result_10chains/node317_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_0 -p 174 -st none -pt topic317_1_0 -u 0.00540916042100098 > ./result_10chains/node317_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_0 -p 328 -st none -pt topic317_2_0 -u 0.0016045650925745059 > ./result_10chains/node317_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_0 -p 347 -st none -pt topic317_3_0 -u 0.009138740077691943 > ./result_10chains/node317_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_0 -p 353 -st none -pt topic317_4_0 -u 0.006015912665848722 > ./result_10chains/node317_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_0 -p 369 -st none -pt topic317_5_0 -u 0.0018691528831503157 > ./result_10chains/node317_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_0 -p 396 -st none -pt topic317_6_0 -u 0.019935461463206128 > ./result_10chains/node317_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_0 -p 493 -st none -pt topic317_7_0 -u 0.06869282826137546 > ./result_10chains/node317_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_8_0 -p 843 -st none -pt topic317_8_0 -u 0.062436264847441886 > ./result_10chains/node317_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_9_0 -p 960 -st none -pt topic317_9_0 -u 0.01139407110753754 > ./result_10chains/node317_9_0.txt &
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
    "./result_10chains/node317_0_0.txt 90"
    "./result_10chains/node317_0_2.txt 90"
    "./result_10chains/node317_1_0.txt 89"
    "./result_10chains/node317_1_2.txt 89"
    "./result_10chains/node317_2_0.txt 88"
    "./result_10chains/node317_2_2.txt 88"
    "./result_10chains/node317_3_0.txt 87"
    "./result_10chains/node317_3_2.txt 87"
    "./result_10chains/node317_4_0.txt 86"
    "./result_10chains/node317_4_2.txt 86"
    "./result_10chains/node317_5_0.txt 85"
    "./result_10chains/node317_5_2.txt 85"
    "./result_10chains/node317_6_0.txt 84"
    "./result_10chains/node317_6_2.txt 84"
    "./result_10chains/node317_7_0.txt 83"
    "./result_10chains/node317_7_2.txt 83"
    "./result_10chains/node317_8_0.txt 82"
    "./result_10chains/node317_8_2.txt 82"
    "./result_10chains/node317_9_0.txt 81"
    "./result_10chains/node317_9_2.txt 81"
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
