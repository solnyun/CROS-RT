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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_2 -p 132 -st topic499_0_1 -pt None -u 0.03210052828449644 > ./result_10chains/node499_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_2 -p 300 -st topic499_1_1 -pt None -u 0.057479946300864004 > ./result_10chains/node499_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_2 -p 411 -st topic499_2_1 -pt None -u 0.0018529640279884019 > ./result_10chains/node499_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_2 -p 493 -st topic499_3_1 -pt None -u 0.0024113591803100465 > ./result_10chains/node499_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_2 -p 503 -st topic499_4_1 -pt None -u 0.04072875432368356 > ./result_10chains/node499_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_2 -p 537 -st topic499_5_1 -pt None -u 0.0009523195046147459 > ./result_10chains/node499_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_2 -p 564 -st topic499_6_1 -pt None -u 0.008318730712916611 > ./result_10chains/node499_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_2 -p 882 -st topic499_7_1 -pt None -u 0.010081556375280354 > ./result_10chains/node499_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_8_2 -p 974 -st topic499_8_1 -pt None -u 0.02788798048201957 > ./result_10chains/node499_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_9_2 -p 985 -st topic499_9_1 -pt None -u 0.023278183113635026 > ./result_10chains/node499_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_0 -p 132 -st none -pt topic499_0_0 -u 0.02049689361902174 > ./result_10chains/node499_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_0 -p 300 -st none -pt topic499_1_0 -u 0.01271515773373999 > ./result_10chains/node499_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_0 -p 411 -st none -pt topic499_2_0 -u 0.012971102881447927 > ./result_10chains/node499_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_0 -p 493 -st none -pt topic499_3_0 -u 0.007760029433195426 > ./result_10chains/node499_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_0 -p 503 -st none -pt topic499_4_0 -u 0.004720208049237895 > ./result_10chains/node499_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_0 -p 537 -st none -pt topic499_5_0 -u 0.03085255885270785 > ./result_10chains/node499_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_0 -p 564 -st none -pt topic499_6_0 -u 0.004287778793328478 > ./result_10chains/node499_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_0 -p 882 -st none -pt topic499_7_0 -u 0.014732296299705405 > ./result_10chains/node499_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_8_0 -p 974 -st none -pt topic499_8_0 -u 0.01820019403248478 > ./result_10chains/node499_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_9_0 -p 985 -st none -pt topic499_9_0 -u 0.062123000060170463 > ./result_10chains/node499_9_0.txt &
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
    "./result_10chains/node499_0_0.txt 90"
    "./result_10chains/node499_0_2.txt 90"
    "./result_10chains/node499_1_0.txt 89"
    "./result_10chains/node499_1_2.txt 89"
    "./result_10chains/node499_2_0.txt 88"
    "./result_10chains/node499_2_2.txt 88"
    "./result_10chains/node499_3_0.txt 87"
    "./result_10chains/node499_3_2.txt 87"
    "./result_10chains/node499_4_0.txt 86"
    "./result_10chains/node499_4_2.txt 86"
    "./result_10chains/node499_5_0.txt 85"
    "./result_10chains/node499_5_2.txt 85"
    "./result_10chains/node499_6_0.txt 84"
    "./result_10chains/node499_6_2.txt 84"
    "./result_10chains/node499_7_0.txt 83"
    "./result_10chains/node499_7_2.txt 83"
    "./result_10chains/node499_8_0.txt 82"
    "./result_10chains/node499_8_2.txt 82"
    "./result_10chains/node499_9_0.txt 81"
    "./result_10chains/node499_9_2.txt 81"
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
