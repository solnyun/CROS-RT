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
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_2 -p 17 -st topic96_0_1 -pt None -u 0.006687569789494474 > ./result_10chains/node96_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_2 -p 31 -st topic96_1_1 -pt None -u 0.004407482906553406 > ./result_10chains/node96_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_2 -p 120 -st topic96_2_1 -pt None -u 0.08742158994170945 > ./result_10chains/node96_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_2 -p 158 -st topic96_3_1 -pt None -u 0.006811405538391824 > ./result_10chains/node96_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_2 -p 193 -st topic96_4_1 -pt None -u 0.011269780610329766 > ./result_10chains/node96_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_2 -p 671 -st topic96_5_1 -pt None -u 0.024144934563271797 > ./result_10chains/node96_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_2 -p 772 -st topic96_6_1 -pt None -u 0.016583215953965807 > ./result_10chains/node96_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_2 -p 822 -st topic96_7_1 -pt None -u 0.009118288197772273 > ./result_10chains/node96_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_8_2 -p 905 -st topic96_8_1 -pt None -u 0.041900399473531885 > ./result_10chains/node96_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_9_2 -p 997 -st topic96_9_1 -pt None -u 0.015201603977669662 > ./result_10chains/node96_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_0 -p 17 -st none -pt topic96_0_0 -u 0.005597872081500532 > ./result_10chains/node96_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_0 -p 31 -st none -pt topic96_1_0 -u 0.0200796889538013 > ./result_10chains/node96_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_0 -p 120 -st none -pt topic96_2_0 -u 0.006273729783655813 > ./result_10chains/node96_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_0 -p 158 -st none -pt topic96_3_0 -u 0.016711901189229994 > ./result_10chains/node96_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_0 -p 193 -st none -pt topic96_4_0 -u 0.071415231208109 > ./result_10chains/node96_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_0 -p 671 -st none -pt topic96_5_0 -u 0.006368383298111263 > ./result_10chains/node96_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_0 -p 772 -st none -pt topic96_6_0 -u 0.019354627537331498 > ./result_10chains/node96_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_0 -p 822 -st none -pt topic96_7_0 -u 0.011261412027577272 > ./result_10chains/node96_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_8_0 -p 905 -st none -pt topic96_8_0 -u 0.032881106838389226 > ./result_10chains/node96_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_9_0 -p 997 -st none -pt topic96_9_0 -u 0.008005910091694119 > ./result_10chains/node96_9_0.txt &
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
    "./result_10chains/node96_0_0.txt 90"
    "./result_10chains/node96_0_2.txt 90"
    "./result_10chains/node96_1_0.txt 89"
    "./result_10chains/node96_1_2.txt 89"
    "./result_10chains/node96_2_0.txt 88"
    "./result_10chains/node96_2_2.txt 88"
    "./result_10chains/node96_3_0.txt 87"
    "./result_10chains/node96_3_2.txt 87"
    "./result_10chains/node96_4_0.txt 86"
    "./result_10chains/node96_4_2.txt 86"
    "./result_10chains/node96_5_0.txt 85"
    "./result_10chains/node96_5_2.txt 85"
    "./result_10chains/node96_6_0.txt 84"
    "./result_10chains/node96_6_2.txt 84"
    "./result_10chains/node96_7_0.txt 83"
    "./result_10chains/node96_7_2.txt 83"
    "./result_10chains/node96_8_0.txt 82"
    "./result_10chains/node96_8_2.txt 82"
    "./result_10chains/node96_9_0.txt 81"
    "./result_10chains/node96_9_2.txt 81"
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
