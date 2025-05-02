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
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_2 -p 19 -st topic95_0_1 -pt None -u 0.05493850255367877 > ./result_10chains/node95_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_2 -p 147 -st topic95_1_1 -pt None -u 0.0018181053967697425 > ./result_10chains/node95_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_2 -p 271 -st topic95_2_1 -pt None -u 0.005932100533934781 > ./result_10chains/node95_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_2 -p 367 -st topic95_3_1 -pt None -u 0.012237240398251192 > ./result_10chains/node95_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_2 -p 621 -st topic95_4_1 -pt None -u 0.005824489548202888 > ./result_10chains/node95_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_2 -p 714 -st topic95_5_1 -pt None -u 0.008127152040517144 > ./result_10chains/node95_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_2 -p 742 -st topic95_6_1 -pt None -u 0.004121834507396227 > ./result_10chains/node95_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_2 -p 772 -st topic95_7_1 -pt None -u 0.028857586807601476 > ./result_10chains/node95_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_8_2 -p 849 -st topic95_8_1 -pt None -u 0.00991283441749271 > ./result_10chains/node95_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_9_2 -p 885 -st topic95_9_1 -pt None -u 0.012137721595329611 > ./result_10chains/node95_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_0 -p 19 -st none -pt topic95_0_0 -u 0.0021456122664842425 > ./result_10chains/node95_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_0 -p 147 -st none -pt topic95_1_0 -u 0.04140734887814923 > ./result_10chains/node95_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_0 -p 271 -st none -pt topic95_2_0 -u 0.007410936539459789 > ./result_10chains/node95_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_0 -p 367 -st none -pt topic95_3_0 -u 0.023069271223855492 > ./result_10chains/node95_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_0 -p 621 -st none -pt topic95_4_0 -u 0.0057368459590552145 > ./result_10chains/node95_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_0 -p 714 -st none -pt topic95_5_0 -u 0.0009151884844454949 > ./result_10chains/node95_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_0 -p 742 -st none -pt topic95_6_0 -u 0.013517423543066537 > ./result_10chains/node95_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_0 -p 772 -st none -pt topic95_7_0 -u 0.027247788323304212 > ./result_10chains/node95_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_8_0 -p 849 -st none -pt topic95_8_0 -u 0.012987217184353014 > ./result_10chains/node95_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_9_0 -p 885 -st none -pt topic95_9_0 -u 0.013267670909303034 > ./result_10chains/node95_9_0.txt &
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
    "./result_10chains/node95_0_0.txt 90"
    "./result_10chains/node95_0_2.txt 90"
    "./result_10chains/node95_1_0.txt 89"
    "./result_10chains/node95_1_2.txt 89"
    "./result_10chains/node95_2_0.txt 88"
    "./result_10chains/node95_2_2.txt 88"
    "./result_10chains/node95_3_0.txt 87"
    "./result_10chains/node95_3_2.txt 87"
    "./result_10chains/node95_4_0.txt 86"
    "./result_10chains/node95_4_2.txt 86"
    "./result_10chains/node95_5_0.txt 85"
    "./result_10chains/node95_5_2.txt 85"
    "./result_10chains/node95_6_0.txt 84"
    "./result_10chains/node95_6_2.txt 84"
    "./result_10chains/node95_7_0.txt 83"
    "./result_10chains/node95_7_2.txt 83"
    "./result_10chains/node95_8_0.txt 82"
    "./result_10chains/node95_8_2.txt 82"
    "./result_10chains/node95_9_0.txt 81"
    "./result_10chains/node95_9_2.txt 81"
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
