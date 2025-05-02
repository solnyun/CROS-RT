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
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_2 -p 100 -st topic177_0_1 -pt None -u 0.011530273166386329 > ./result_10chains/node177_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_2 -p 164 -st topic177_1_1 -pt None -u 0.014544168834495608 > ./result_10chains/node177_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_2 -p 194 -st topic177_2_1 -pt None -u 0.028257690008892222 > ./result_10chains/node177_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_2 -p 216 -st topic177_3_1 -pt None -u 0.017810811743233762 > ./result_10chains/node177_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_2 -p 730 -st topic177_4_1 -pt None -u 0.014571529194409877 > ./result_10chains/node177_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_2 -p 781 -st topic177_5_1 -pt None -u 0.014224638258909988 > ./result_10chains/node177_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_6_2 -p 899 -st topic177_6_1 -pt None -u 0.0027298371243212466 > ./result_10chains/node177_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_7_2 -p 927 -st topic177_7_1 -pt None -u 0.00045787576066640134 > ./result_10chains/node177_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_8_2 -p 957 -st topic177_8_1 -pt None -u 0.004270120906506983 > ./result_10chains/node177_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_9_2 -p 971 -st topic177_9_1 -pt None -u 0.011408655312104806 > ./result_10chains/node177_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_0 -p 100 -st none -pt topic177_0_0 -u 0.015154048475344462 > ./result_10chains/node177_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_0 -p 164 -st none -pt topic177_1_0 -u 0.1464689799027607 > ./result_10chains/node177_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_0 -p 194 -st none -pt topic177_2_0 -u 0.0029445548165500934 > ./result_10chains/node177_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_0 -p 216 -st none -pt topic177_3_0 -u 0.00665606382618622 > ./result_10chains/node177_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_0 -p 730 -st none -pt topic177_4_0 -u 0.007786181380677076 > ./result_10chains/node177_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_0 -p 781 -st none -pt topic177_5_0 -u 0.005140568221443015 > ./result_10chains/node177_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_6_0 -p 899 -st none -pt topic177_6_0 -u 0.038672673769980986 > ./result_10chains/node177_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_7_0 -p 927 -st none -pt topic177_7_0 -u 0.0024286899615079266 > ./result_10chains/node177_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_8_0 -p 957 -st none -pt topic177_8_0 -u 0.010290045123008962 > ./result_10chains/node177_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_9_0 -p 971 -st none -pt topic177_9_0 -u 0.0011393981898011156 > ./result_10chains/node177_9_0.txt &
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
    "./result_10chains/node177_0_0.txt 90"
    "./result_10chains/node177_0_2.txt 90"
    "./result_10chains/node177_1_0.txt 89"
    "./result_10chains/node177_1_2.txt 89"
    "./result_10chains/node177_2_0.txt 88"
    "./result_10chains/node177_2_2.txt 88"
    "./result_10chains/node177_3_0.txt 87"
    "./result_10chains/node177_3_2.txt 87"
    "./result_10chains/node177_4_0.txt 86"
    "./result_10chains/node177_4_2.txt 86"
    "./result_10chains/node177_5_0.txt 85"
    "./result_10chains/node177_5_2.txt 85"
    "./result_10chains/node177_6_0.txt 84"
    "./result_10chains/node177_6_2.txt 84"
    "./result_10chains/node177_7_0.txt 83"
    "./result_10chains/node177_7_2.txt 83"
    "./result_10chains/node177_8_0.txt 82"
    "./result_10chains/node177_8_2.txt 82"
    "./result_10chains/node177_9_0.txt 81"
    "./result_10chains/node177_9_2.txt 81"
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
