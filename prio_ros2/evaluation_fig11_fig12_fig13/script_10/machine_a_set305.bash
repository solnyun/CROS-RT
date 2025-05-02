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
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_2 -p 110 -st topic305_0_1 -pt None -u 0.00391954804013539 > ./result_10chains/node305_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_2 -p 136 -st topic305_1_1 -pt None -u 0.014922042146335357 > ./result_10chains/node305_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_2 -p 373 -st topic305_2_1 -pt None -u 0.042378158151775924 > ./result_10chains/node305_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_2 -p 455 -st topic305_3_1 -pt None -u 0.011332325277294386 > ./result_10chains/node305_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_2 -p 619 -st topic305_4_1 -pt None -u 0.012925811794017417 > ./result_10chains/node305_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_2 -p 682 -st topic305_5_1 -pt None -u 0.007945843569617278 > ./result_10chains/node305_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_6_2 -p 745 -st topic305_6_1 -pt None -u 0.007605207404165815 > ./result_10chains/node305_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_7_2 -p 794 -st topic305_7_1 -pt None -u 0.0038347870844922943 > ./result_10chains/node305_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_8_2 -p 830 -st topic305_8_1 -pt None -u 0.002398448120039441 > ./result_10chains/node305_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_9_2 -p 936 -st topic305_9_1 -pt None -u 0.01786644406484345 > ./result_10chains/node305_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_0 -p 110 -st none -pt topic305_0_0 -u 0.03082824113013949 > ./result_10chains/node305_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_0 -p 136 -st none -pt topic305_1_0 -u 0.020727524132406194 > ./result_10chains/node305_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_0 -p 373 -st none -pt topic305_2_0 -u 0.00335920084104252 > ./result_10chains/node305_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_0 -p 455 -st none -pt topic305_3_0 -u 0.013755863222366382 > ./result_10chains/node305_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_0 -p 619 -st none -pt topic305_4_0 -u 0.011781159135934693 > ./result_10chains/node305_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_0 -p 682 -st none -pt topic305_5_0 -u 0.010013170370623214 > ./result_10chains/node305_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_6_0 -p 745 -st none -pt topic305_6_0 -u 0.05946202916915033 > ./result_10chains/node305_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_7_0 -p 794 -st none -pt topic305_7_0 -u 0.027572915263207584 > ./result_10chains/node305_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_8_0 -p 830 -st none -pt topic305_8_0 -u 0.03392988963751544 > ./result_10chains/node305_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_9_0 -p 936 -st none -pt topic305_9_0 -u 0.002834764298399201 > ./result_10chains/node305_9_0.txt &
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
    "./result_10chains/node305_0_0.txt 90"
    "./result_10chains/node305_0_2.txt 90"
    "./result_10chains/node305_1_0.txt 89"
    "./result_10chains/node305_1_2.txt 89"
    "./result_10chains/node305_2_0.txt 88"
    "./result_10chains/node305_2_2.txt 88"
    "./result_10chains/node305_3_0.txt 87"
    "./result_10chains/node305_3_2.txt 87"
    "./result_10chains/node305_4_0.txt 86"
    "./result_10chains/node305_4_2.txt 86"
    "./result_10chains/node305_5_0.txt 85"
    "./result_10chains/node305_5_2.txt 85"
    "./result_10chains/node305_6_0.txt 84"
    "./result_10chains/node305_6_2.txt 84"
    "./result_10chains/node305_7_0.txt 83"
    "./result_10chains/node305_7_2.txt 83"
    "./result_10chains/node305_8_0.txt 82"
    "./result_10chains/node305_8_2.txt 82"
    "./result_10chains/node305_9_0.txt 81"
    "./result_10chains/node305_9_2.txt 81"
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
