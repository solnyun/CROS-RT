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
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_2 -p 42 -st topic13_0_1 -pt None -u 0.012301229404381941 > ./result_8chains/node13_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_2 -p 121 -st topic13_1_1 -pt None -u 0.01886528111764474 > ./result_8chains/node13_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_2 -p 152 -st topic13_2_1 -pt None -u 0.005733378727514782 > ./result_8chains/node13_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_2 -p 316 -st topic13_3_1 -pt None -u 0.005173022244999992 > ./result_8chains/node13_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_2 -p 318 -st topic13_4_1 -pt None -u 0.005668547077282926 > ./result_8chains/node13_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_2 -p 407 -st topic13_5_1 -pt None -u 0.026684787608238114 > ./result_8chains/node13_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_6_2 -p 542 -st topic13_6_1 -pt None -u 0.004370103049498308 > ./result_8chains/node13_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_7_2 -p 672 -st topic13_7_1 -pt None -u 0.09401830858958704 > ./result_8chains/node13_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_0 -p 42 -st none -pt topic13_0_0 -u 0.0033618246961356624 > ./result_8chains/node13_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_0 -p 121 -st none -pt topic13_1_0 -u 0.02621998813897425 > ./result_8chains/node13_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_0 -p 152 -st none -pt topic13_2_0 -u 0.0017528178777556636 > ./result_8chains/node13_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_0 -p 316 -st none -pt topic13_3_0 -u 0.008310787487651405 > ./result_8chains/node13_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_0 -p 318 -st none -pt topic13_4_0 -u 0.005983600824572055 > ./result_8chains/node13_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_0 -p 407 -st none -pt topic13_5_0 -u 0.018355809393838074 > ./result_8chains/node13_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_6_0 -p 542 -st none -pt topic13_6_0 -u 0.10144462003314669 > ./result_8chains/node13_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_7_0 -p 672 -st none -pt topic13_7_0 -u 0.023479227037551564 > ./result_8chains/node13_7_0.txt &
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
    "./result_8chains/node13_0_0.txt 90"
    "./result_8chains/node13_0_2.txt 90"
    "./result_8chains/node13_1_0.txt 89"
    "./result_8chains/node13_1_2.txt 89"
    "./result_8chains/node13_2_0.txt 88"
    "./result_8chains/node13_2_2.txt 88"
    "./result_8chains/node13_3_0.txt 87"
    "./result_8chains/node13_3_2.txt 87"
    "./result_8chains/node13_4_0.txt 86"
    "./result_8chains/node13_4_2.txt 86"
    "./result_8chains/node13_5_0.txt 85"
    "./result_8chains/node13_5_2.txt 85"
    "./result_8chains/node13_6_0.txt 84"
    "./result_8chains/node13_6_2.txt 84"
    "./result_8chains/node13_7_0.txt 83"
    "./result_8chains/node13_7_2.txt 83"
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
