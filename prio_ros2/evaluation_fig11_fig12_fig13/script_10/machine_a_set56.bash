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
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_2 -p 12 -st topic56_0_1 -pt None -u 0.005105814038289969 > ./result_10chains/node56_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_2 -p 41 -st topic56_1_1 -pt None -u 0.019054608811226947 > ./result_10chains/node56_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_2 -p 131 -st topic56_2_1 -pt None -u 0.051185792527184304 > ./result_10chains/node56_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_2 -p 180 -st topic56_3_1 -pt None -u 0.0153638740772436 > ./result_10chains/node56_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_2 -p 181 -st topic56_4_1 -pt None -u 0.004353669612562006 > ./result_10chains/node56_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_2 -p 419 -st topic56_5_1 -pt None -u 0.011840380594237337 > ./result_10chains/node56_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_6_2 -p 640 -st topic56_6_1 -pt None -u 0.010526488511396759 > ./result_10chains/node56_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_7_2 -p 688 -st topic56_7_1 -pt None -u 0.0015801670030417547 > ./result_10chains/node56_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_8_2 -p 775 -st topic56_8_1 -pt None -u 0.010599214569459725 > ./result_10chains/node56_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_9_2 -p 854 -st topic56_9_1 -pt None -u 0.0030133355653218273 > ./result_10chains/node56_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_0 -p 12 -st none -pt topic56_0_0 -u 0.00690043901206161 > ./result_10chains/node56_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_0 -p 41 -st none -pt topic56_1_0 -u 0.02205584145754741 > ./result_10chains/node56_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_0 -p 131 -st none -pt topic56_2_0 -u 0.00020354792023469237 > ./result_10chains/node56_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_0 -p 180 -st none -pt topic56_3_0 -u 0.011694447458979684 > ./result_10chains/node56_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_0 -p 181 -st none -pt topic56_4_0 -u 0.041869687406581424 > ./result_10chains/node56_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_0 -p 419 -st none -pt topic56_5_0 -u 0.0015292545505246058 > ./result_10chains/node56_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_6_0 -p 640 -st none -pt topic56_6_0 -u 0.00966606505654094 > ./result_10chains/node56_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_7_0 -p 688 -st none -pt topic56_7_0 -u 0.02387157159215117 > ./result_10chains/node56_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_8_0 -p 775 -st none -pt topic56_8_0 -u 0.004152814437434385 > ./result_10chains/node56_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_9_0 -p 854 -st none -pt topic56_9_0 -u 0.03726007282485472 > ./result_10chains/node56_9_0.txt &
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
    "./result_10chains/node56_0_0.txt 90"
    "./result_10chains/node56_0_2.txt 90"
    "./result_10chains/node56_1_0.txt 89"
    "./result_10chains/node56_1_2.txt 89"
    "./result_10chains/node56_2_0.txt 88"
    "./result_10chains/node56_2_2.txt 88"
    "./result_10chains/node56_3_0.txt 87"
    "./result_10chains/node56_3_2.txt 87"
    "./result_10chains/node56_4_0.txt 86"
    "./result_10chains/node56_4_2.txt 86"
    "./result_10chains/node56_5_0.txt 85"
    "./result_10chains/node56_5_2.txt 85"
    "./result_10chains/node56_6_0.txt 84"
    "./result_10chains/node56_6_2.txt 84"
    "./result_10chains/node56_7_0.txt 83"
    "./result_10chains/node56_7_2.txt 83"
    "./result_10chains/node56_8_0.txt 82"
    "./result_10chains/node56_8_2.txt 82"
    "./result_10chains/node56_9_0.txt 81"
    "./result_10chains/node56_9_2.txt 81"
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
