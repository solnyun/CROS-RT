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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_2 -p 158 -st topic310_0_1 -pt None -u 0.025059287205565883 > ./result_10chains/node310_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_2 -p 179 -st topic310_1_1 -pt None -u 0.0018401508490619167 > ./result_10chains/node310_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_2 -p 217 -st topic310_2_1 -pt None -u 0.001028558905106558 > ./result_10chains/node310_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_2 -p 316 -st topic310_3_1 -pt None -u 0.0014937599920585853 > ./result_10chains/node310_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_2 -p 382 -st topic310_4_1 -pt None -u 0.012089988926006379 > ./result_10chains/node310_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_2 -p 587 -st topic310_5_1 -pt None -u 0.02611770530395438 > ./result_10chains/node310_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_2 -p 682 -st topic310_6_1 -pt None -u 0.08253539533935689 > ./result_10chains/node310_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_2 -p 709 -st topic310_7_1 -pt None -u 0.011542631589284633 > ./result_10chains/node310_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_8_2 -p 790 -st topic310_8_1 -pt None -u 0.0003590677566231715 > ./result_10chains/node310_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_9_2 -p 957 -st topic310_9_1 -pt None -u 0.003316850290307618 > ./result_10chains/node310_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_0 -p 158 -st none -pt topic310_0_0 -u 0.01956840339720267 > ./result_10chains/node310_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_0 -p 179 -st none -pt topic310_1_0 -u 0.013917746996636504 > ./result_10chains/node310_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_0 -p 217 -st none -pt topic310_2_0 -u 0.021388988727177094 > ./result_10chains/node310_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_0 -p 316 -st none -pt topic310_3_0 -u 0.02547527802388272 > ./result_10chains/node310_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_0 -p 382 -st none -pt topic310_4_0 -u 0.0015916168396294395 > ./result_10chains/node310_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_0 -p 587 -st none -pt topic310_5_0 -u 0.02364623357881257 > ./result_10chains/node310_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_0 -p 682 -st none -pt topic310_6_0 -u 0.031043115486996203 > ./result_10chains/node310_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_0 -p 709 -st none -pt topic310_7_0 -u 0.007643023042043187 > ./result_10chains/node310_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_8_0 -p 790 -st none -pt topic310_8_0 -u 0.03899742171833363 > ./result_10chains/node310_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_9_0 -p 957 -st none -pt topic310_9_0 -u 0.013940711110032259 > ./result_10chains/node310_9_0.txt &
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
    "./result_10chains/node310_0_0.txt 90"
    "./result_10chains/node310_0_2.txt 90"
    "./result_10chains/node310_1_0.txt 89"
    "./result_10chains/node310_1_2.txt 89"
    "./result_10chains/node310_2_0.txt 88"
    "./result_10chains/node310_2_2.txt 88"
    "./result_10chains/node310_3_0.txt 87"
    "./result_10chains/node310_3_2.txt 87"
    "./result_10chains/node310_4_0.txt 86"
    "./result_10chains/node310_4_2.txt 86"
    "./result_10chains/node310_5_0.txt 85"
    "./result_10chains/node310_5_2.txt 85"
    "./result_10chains/node310_6_0.txt 84"
    "./result_10chains/node310_6_2.txt 84"
    "./result_10chains/node310_7_0.txt 83"
    "./result_10chains/node310_7_2.txt 83"
    "./result_10chains/node310_8_0.txt 82"
    "./result_10chains/node310_8_2.txt 82"
    "./result_10chains/node310_9_0.txt 81"
    "./result_10chains/node310_9_2.txt 81"
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
