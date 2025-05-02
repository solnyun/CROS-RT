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
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_2 -p 181 -st topic405_0_1 -pt None -u 0.0019026887107779777 > ./result_10chains/node405_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_2 -p 311 -st topic405_1_1 -pt None -u 0.001238380174002518 > ./result_10chains/node405_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_2 -p 354 -st topic405_2_1 -pt None -u 0.006725275241968531 > ./result_10chains/node405_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_2 -p 405 -st topic405_3_1 -pt None -u 0.0004678958179152315 > ./result_10chains/node405_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_2 -p 513 -st topic405_4_1 -pt None -u 0.006420658857937411 > ./result_10chains/node405_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_2 -p 560 -st topic405_5_1 -pt None -u 0.022931449447851665 > ./result_10chains/node405_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_6_2 -p 677 -st topic405_6_1 -pt None -u 0.014906701233806718 > ./result_10chains/node405_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_7_2 -p 802 -st topic405_7_1 -pt None -u 0.04834727713484399 > ./result_10chains/node405_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_8_2 -p 843 -st topic405_8_1 -pt None -u 0.022731720672280853 > ./result_10chains/node405_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_9_2 -p 884 -st topic405_9_1 -pt None -u 0.005497829064817349 > ./result_10chains/node405_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_0 -p 181 -st none -pt topic405_0_0 -u 0.020085560035300987 > ./result_10chains/node405_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_0 -p 311 -st none -pt topic405_1_0 -u 0.016288983426957282 > ./result_10chains/node405_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_0 -p 354 -st none -pt topic405_2_0 -u 0.01972122908254459 > ./result_10chains/node405_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_0 -p 405 -st none -pt topic405_3_0 -u 0.04150682741968814 > ./result_10chains/node405_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_0 -p 513 -st none -pt topic405_4_0 -u 0.014871153290770989 > ./result_10chains/node405_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_0 -p 560 -st none -pt topic405_5_0 -u 0.04554663070922271 > ./result_10chains/node405_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_6_0 -p 677 -st none -pt topic405_6_0 -u 0.029524711730481268 > ./result_10chains/node405_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_7_0 -p 802 -st none -pt topic405_7_0 -u 0.009871860031018975 > ./result_10chains/node405_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_8_0 -p 843 -st none -pt topic405_8_0 -u 0.014951162934874647 > ./result_10chains/node405_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_9_0 -p 884 -st none -pt topic405_9_0 -u 0.0038136569053403664 > ./result_10chains/node405_9_0.txt &
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
    "./result_10chains/node405_0_0.txt 90"
    "./result_10chains/node405_0_2.txt 90"
    "./result_10chains/node405_1_0.txt 89"
    "./result_10chains/node405_1_2.txt 89"
    "./result_10chains/node405_2_0.txt 88"
    "./result_10chains/node405_2_2.txt 88"
    "./result_10chains/node405_3_0.txt 87"
    "./result_10chains/node405_3_2.txt 87"
    "./result_10chains/node405_4_0.txt 86"
    "./result_10chains/node405_4_2.txt 86"
    "./result_10chains/node405_5_0.txt 85"
    "./result_10chains/node405_5_2.txt 85"
    "./result_10chains/node405_6_0.txt 84"
    "./result_10chains/node405_6_2.txt 84"
    "./result_10chains/node405_7_0.txt 83"
    "./result_10chains/node405_7_2.txt 83"
    "./result_10chains/node405_8_0.txt 82"
    "./result_10chains/node405_8_2.txt 82"
    "./result_10chains/node405_9_0.txt 81"
    "./result_10chains/node405_9_2.txt 81"
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
