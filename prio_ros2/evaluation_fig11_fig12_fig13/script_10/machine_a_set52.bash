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
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_2 -p 31 -st topic52_0_1 -pt None -u 0.003683060233251545 > ./result_10chains/node52_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_2 -p 102 -st topic52_1_1 -pt None -u 0.023168254227017848 > ./result_10chains/node52_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_2 -p 281 -st topic52_2_1 -pt None -u 0.030132351053142437 > ./result_10chains/node52_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_2 -p 500 -st topic52_3_1 -pt None -u 0.0030423676477168704 > ./result_10chains/node52_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_2 -p 577 -st topic52_4_1 -pt None -u 0.012117878168087626 > ./result_10chains/node52_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_2 -p 635 -st topic52_5_1 -pt None -u 0.002104043233217251 > ./result_10chains/node52_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_2 -p 778 -st topic52_6_1 -pt None -u 0.040556715605007676 > ./result_10chains/node52_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_2 -p 954 -st topic52_7_1 -pt None -u 0.018533446737166906 > ./result_10chains/node52_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_8_2 -p 985 -st topic52_8_1 -pt None -u 0.0017061220930712356 > ./result_10chains/node52_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_9_2 -p 986 -st topic52_9_1 -pt None -u 0.046743729421125105 > ./result_10chains/node52_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_0 -p 31 -st none -pt topic52_0_0 -u 0.020019786986770816 > ./result_10chains/node52_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_0 -p 102 -st none -pt topic52_1_0 -u 0.0010419149467096878 > ./result_10chains/node52_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_0 -p 281 -st none -pt topic52_2_0 -u 0.02467470746400302 > ./result_10chains/node52_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_0 -p 500 -st none -pt topic52_3_0 -u 0.00011090223349746742 > ./result_10chains/node52_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_0 -p 577 -st none -pt topic52_4_0 -u 0.0226399084388772 > ./result_10chains/node52_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_0 -p 635 -st none -pt topic52_5_0 -u 0.013678993482734214 > ./result_10chains/node52_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_0 -p 778 -st none -pt topic52_6_0 -u 0.009866087321773742 > ./result_10chains/node52_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_0 -p 954 -st none -pt topic52_7_0 -u 0.004805424875132858 > ./result_10chains/node52_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_8_0 -p 985 -st none -pt topic52_8_0 -u 0.03171994609842706 > ./result_10chains/node52_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_9_0 -p 986 -st none -pt topic52_9_0 -u 0.010832527862556743 > ./result_10chains/node52_9_0.txt &
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
    "./result_10chains/node52_0_0.txt 90"
    "./result_10chains/node52_0_2.txt 90"
    "./result_10chains/node52_1_0.txt 89"
    "./result_10chains/node52_1_2.txt 89"
    "./result_10chains/node52_2_0.txt 88"
    "./result_10chains/node52_2_2.txt 88"
    "./result_10chains/node52_3_0.txt 87"
    "./result_10chains/node52_3_2.txt 87"
    "./result_10chains/node52_4_0.txt 86"
    "./result_10chains/node52_4_2.txt 86"
    "./result_10chains/node52_5_0.txt 85"
    "./result_10chains/node52_5_2.txt 85"
    "./result_10chains/node52_6_0.txt 84"
    "./result_10chains/node52_6_2.txt 84"
    "./result_10chains/node52_7_0.txt 83"
    "./result_10chains/node52_7_2.txt 83"
    "./result_10chains/node52_8_0.txt 82"
    "./result_10chains/node52_8_2.txt 82"
    "./result_10chains/node52_9_0.txt 81"
    "./result_10chains/node52_9_2.txt 81"
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
