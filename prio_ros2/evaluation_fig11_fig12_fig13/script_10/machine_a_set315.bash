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
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_2 -p 204 -st topic315_0_1 -pt None -u 0.02091552780423267 > ./result_10chains/node315_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_2 -p 205 -st topic315_1_1 -pt None -u 0.018017177225830128 > ./result_10chains/node315_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_2 -p 259 -st topic315_2_1 -pt None -u 0.0201900002510923 > ./result_10chains/node315_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_2 -p 379 -st topic315_3_1 -pt None -u 0.07222042270974066 > ./result_10chains/node315_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_2 -p 491 -st topic315_4_1 -pt None -u 0.052447263390703575 > ./result_10chains/node315_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_2 -p 536 -st topic315_5_1 -pt None -u 0.005582329337689901 > ./result_10chains/node315_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_6_2 -p 625 -st topic315_6_1 -pt None -u 0.00039823879789695205 > ./result_10chains/node315_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_7_2 -p 828 -st topic315_7_1 -pt None -u 0.004950709108959284 > ./result_10chains/node315_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_8_2 -p 876 -st topic315_8_1 -pt None -u 0.004647333857379327 > ./result_10chains/node315_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_9_2 -p 974 -st topic315_9_1 -pt None -u 0.013490446737352463 > ./result_10chains/node315_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_0 -p 204 -st none -pt topic315_0_0 -u 5.339551331473569e-06 > ./result_10chains/node315_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_0 -p 205 -st none -pt topic315_1_0 -u 0.003658273219401431 > ./result_10chains/node315_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_0 -p 259 -st none -pt topic315_2_0 -u 0.003432735125896036 > ./result_10chains/node315_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_0 -p 379 -st none -pt topic315_3_0 -u 0.051040375622377177 > ./result_10chains/node315_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_0 -p 491 -st none -pt topic315_4_0 -u 0.01842863137657888 > ./result_10chains/node315_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_0 -p 536 -st none -pt topic315_5_0 -u 0.009680997774063227 > ./result_10chains/node315_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_6_0 -p 625 -st none -pt topic315_6_0 -u 0.021117301289532306 > ./result_10chains/node315_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_7_0 -p 828 -st none -pt topic315_7_0 -u 0.02058977877669399 > ./result_10chains/node315_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_8_0 -p 876 -st none -pt topic315_8_0 -u 0.016450575678695928 > ./result_10chains/node315_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_9_0 -p 974 -st none -pt topic315_9_0 -u 0.01102640632155835 > ./result_10chains/node315_9_0.txt &
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
    "./result_10chains/node315_0_0.txt 90"
    "./result_10chains/node315_0_2.txt 90"
    "./result_10chains/node315_1_0.txt 89"
    "./result_10chains/node315_1_2.txt 89"
    "./result_10chains/node315_2_0.txt 88"
    "./result_10chains/node315_2_2.txt 88"
    "./result_10chains/node315_3_0.txt 87"
    "./result_10chains/node315_3_2.txt 87"
    "./result_10chains/node315_4_0.txt 86"
    "./result_10chains/node315_4_2.txt 86"
    "./result_10chains/node315_5_0.txt 85"
    "./result_10chains/node315_5_2.txt 85"
    "./result_10chains/node315_6_0.txt 84"
    "./result_10chains/node315_6_2.txt 84"
    "./result_10chains/node315_7_0.txt 83"
    "./result_10chains/node315_7_2.txt 83"
    "./result_10chains/node315_8_0.txt 82"
    "./result_10chains/node315_8_2.txt 82"
    "./result_10chains/node315_9_0.txt 81"
    "./result_10chains/node315_9_2.txt 81"
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
