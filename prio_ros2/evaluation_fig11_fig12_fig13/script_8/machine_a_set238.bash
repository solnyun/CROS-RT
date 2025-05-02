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
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_2 -p 36 -st topic238_0_1 -pt None -u 0.030450835554365674 > ./result_8chains/node238_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_2 -p 266 -st topic238_1_1 -pt None -u 0.03203025333139037 > ./result_8chains/node238_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_2 -p 496 -st topic238_2_1 -pt None -u 0.018517782050811393 > ./result_8chains/node238_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_2 -p 531 -st topic238_3_1 -pt None -u 0.01405412752441737 > ./result_8chains/node238_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_2 -p 586 -st topic238_4_1 -pt None -u 0.011283095118206826 > ./result_8chains/node238_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_2 -p 691 -st topic238_5_1 -pt None -u 0.07497145733583443 > ./result_8chains/node238_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_2 -p 845 -st topic238_6_1 -pt None -u 0.012919131623232716 > ./result_8chains/node238_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_2 -p 970 -st topic238_7_1 -pt None -u 0.028998732402405535 > ./result_8chains/node238_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_0 -p 36 -st none -pt topic238_0_0 -u 0.007583335533128566 > ./result_8chains/node238_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_0 -p 266 -st none -pt topic238_1_0 -u 0.022300107909159206 > ./result_8chains/node238_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_0 -p 496 -st none -pt topic238_2_0 -u 0.007587541063123482 > ./result_8chains/node238_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_0 -p 531 -st none -pt topic238_3_0 -u 0.0397045471147312 > ./result_8chains/node238_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_0 -p 586 -st none -pt topic238_4_0 -u 0.0037408178656096747 > ./result_8chains/node238_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_0 -p 691 -st none -pt topic238_5_0 -u 0.0115489790817066 > ./result_8chains/node238_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_0 -p 845 -st none -pt topic238_6_0 -u 0.0053578953647354655 > ./result_8chains/node238_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_0 -p 970 -st none -pt topic238_7_0 -u 0.02775055205208983 > ./result_8chains/node238_7_0.txt &
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
    "./result_8chains/node238_0_0.txt 90"
    "./result_8chains/node238_0_2.txt 90"
    "./result_8chains/node238_1_0.txt 89"
    "./result_8chains/node238_1_2.txt 89"
    "./result_8chains/node238_2_0.txt 88"
    "./result_8chains/node238_2_2.txt 88"
    "./result_8chains/node238_3_0.txt 87"
    "./result_8chains/node238_3_2.txt 87"
    "./result_8chains/node238_4_0.txt 86"
    "./result_8chains/node238_4_2.txt 86"
    "./result_8chains/node238_5_0.txt 85"
    "./result_8chains/node238_5_2.txt 85"
    "./result_8chains/node238_6_0.txt 84"
    "./result_8chains/node238_6_2.txt 84"
    "./result_8chains/node238_7_0.txt 83"
    "./result_8chains/node238_7_2.txt 83"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
