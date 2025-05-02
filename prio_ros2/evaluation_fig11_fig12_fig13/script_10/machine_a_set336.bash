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
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_2 -p 80 -st topic336_0_1 -pt None -u 0.0073116076651830175 > ./result_10chains/node336_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_2 -p 138 -st topic336_1_1 -pt None -u 0.0031790773717398357 > ./result_10chains/node336_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_2 -p 143 -st topic336_2_1 -pt None -u 0.0021261833168443878 > ./result_10chains/node336_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_2 -p 193 -st topic336_3_1 -pt None -u 0.02906043423937249 > ./result_10chains/node336_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_2 -p 226 -st topic336_4_1 -pt None -u 0.04428808458434069 > ./result_10chains/node336_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_2 -p 364 -st topic336_5_1 -pt None -u 0.016806927304779118 > ./result_10chains/node336_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_6_2 -p 425 -st topic336_6_1 -pt None -u 0.003103714765797072 > ./result_10chains/node336_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_7_2 -p 631 -st topic336_7_1 -pt None -u 0.012775994234596993 > ./result_10chains/node336_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_8_2 -p 805 -st topic336_8_1 -pt None -u 0.004076125427269317 > ./result_10chains/node336_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_9_2 -p 987 -st topic336_9_1 -pt None -u 0.009148215179984983 > ./result_10chains/node336_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_0 -p 80 -st none -pt topic336_0_0 -u 0.014748990130234563 > ./result_10chains/node336_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_0 -p 138 -st none -pt topic336_1_0 -u 0.0425464794977542 > ./result_10chains/node336_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_0 -p 143 -st none -pt topic336_2_0 -u 0.027089205130061966 > ./result_10chains/node336_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_0 -p 193 -st none -pt topic336_3_0 -u 0.008972204159844566 > ./result_10chains/node336_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_0 -p 226 -st none -pt topic336_4_0 -u 0.0013451976276985245 > ./result_10chains/node336_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_0 -p 364 -st none -pt topic336_5_0 -u 0.009169374177906864 > ./result_10chains/node336_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_6_0 -p 425 -st none -pt topic336_6_0 -u 0.003462161614781023 > ./result_10chains/node336_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_7_0 -p 631 -st none -pt topic336_7_0 -u 0.007183113863098001 > ./result_10chains/node336_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_8_0 -p 805 -st none -pt topic336_8_0 -u 0.00021007817644830284 > ./result_10chains/node336_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_9_0 -p 987 -st none -pt topic336_9_0 -u 0.10099080569056307 > ./result_10chains/node336_9_0.txt &
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
    "./result_10chains/node336_0_0.txt 90"
    "./result_10chains/node336_0_2.txt 90"
    "./result_10chains/node336_1_0.txt 89"
    "./result_10chains/node336_1_2.txt 89"
    "./result_10chains/node336_2_0.txt 88"
    "./result_10chains/node336_2_2.txt 88"
    "./result_10chains/node336_3_0.txt 87"
    "./result_10chains/node336_3_2.txt 87"
    "./result_10chains/node336_4_0.txt 86"
    "./result_10chains/node336_4_2.txt 86"
    "./result_10chains/node336_5_0.txt 85"
    "./result_10chains/node336_5_2.txt 85"
    "./result_10chains/node336_6_0.txt 84"
    "./result_10chains/node336_6_2.txt 84"
    "./result_10chains/node336_7_0.txt 83"
    "./result_10chains/node336_7_2.txt 83"
    "./result_10chains/node336_8_0.txt 82"
    "./result_10chains/node336_8_2.txt 82"
    "./result_10chains/node336_9_0.txt 81"
    "./result_10chains/node336_9_2.txt 81"
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
