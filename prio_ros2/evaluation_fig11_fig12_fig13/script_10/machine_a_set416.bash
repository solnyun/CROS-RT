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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_2 -p 22 -st topic416_0_1 -pt None -u 0.02587650265223712 > ./result_10chains/node416_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_2 -p 376 -st topic416_1_1 -pt None -u 0.002602777886257679 > ./result_10chains/node416_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_2 -p 389 -st topic416_2_1 -pt None -u 0.026841298057607155 > ./result_10chains/node416_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_2 -p 508 -st topic416_3_1 -pt None -u 0.007854877441746566 > ./result_10chains/node416_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_2 -p 526 -st topic416_4_1 -pt None -u 0.03152914828178291 > ./result_10chains/node416_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_2 -p 620 -st topic416_5_1 -pt None -u 0.001498822218415241 > ./result_10chains/node416_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_6_2 -p 737 -st topic416_6_1 -pt None -u 0.002710738893386272 > ./result_10chains/node416_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_7_2 -p 847 -st topic416_7_1 -pt None -u 0.031597081057735815 > ./result_10chains/node416_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_8_2 -p 883 -st topic416_8_1 -pt None -u 0.009144907785860072 > ./result_10chains/node416_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_9_2 -p 989 -st topic416_9_1 -pt None -u 0.0018586883613954052 > ./result_10chains/node416_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_0 -p 22 -st none -pt topic416_0_0 -u 0.009506897284991267 > ./result_10chains/node416_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_0 -p 376 -st none -pt topic416_1_0 -u 0.021215148043118304 > ./result_10chains/node416_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_0 -p 389 -st none -pt topic416_2_0 -u 0.006755852642722104 > ./result_10chains/node416_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_0 -p 508 -st none -pt topic416_3_0 -u 0.004403799321141599 > ./result_10chains/node416_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_0 -p 526 -st none -pt topic416_4_0 -u 0.006545669677390953 > ./result_10chains/node416_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_0 -p 620 -st none -pt topic416_5_0 -u 0.004979086638515984 > ./result_10chains/node416_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_6_0 -p 737 -st none -pt topic416_6_0 -u 0.0062235953532812915 > ./result_10chains/node416_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_7_0 -p 847 -st none -pt topic416_7_0 -u 0.018542746280839795 > ./result_10chains/node416_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_8_0 -p 883 -st none -pt topic416_8_0 -u 0.07898293575395533 > ./result_10chains/node416_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_9_0 -p 989 -st none -pt topic416_9_0 -u 0.006022808673439316 > ./result_10chains/node416_9_0.txt &
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
    "./result_10chains/node416_0_0.txt 90"
    "./result_10chains/node416_0_2.txt 90"
    "./result_10chains/node416_1_0.txt 89"
    "./result_10chains/node416_1_2.txt 89"
    "./result_10chains/node416_2_0.txt 88"
    "./result_10chains/node416_2_2.txt 88"
    "./result_10chains/node416_3_0.txt 87"
    "./result_10chains/node416_3_2.txt 87"
    "./result_10chains/node416_4_0.txt 86"
    "./result_10chains/node416_4_2.txt 86"
    "./result_10chains/node416_5_0.txt 85"
    "./result_10chains/node416_5_2.txt 85"
    "./result_10chains/node416_6_0.txt 84"
    "./result_10chains/node416_6_2.txt 84"
    "./result_10chains/node416_7_0.txt 83"
    "./result_10chains/node416_7_2.txt 83"
    "./result_10chains/node416_8_0.txt 82"
    "./result_10chains/node416_8_2.txt 82"
    "./result_10chains/node416_9_0.txt 81"
    "./result_10chains/node416_9_2.txt 81"
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
