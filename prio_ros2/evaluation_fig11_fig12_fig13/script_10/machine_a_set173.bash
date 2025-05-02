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
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_2 -p 37 -st topic173_0_1 -pt None -u 0.004453750276160684 > ./result_10chains/node173_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_2 -p 180 -st topic173_1_1 -pt None -u 0.023625671827283812 > ./result_10chains/node173_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_2 -p 203 -st topic173_2_1 -pt None -u 0.012667577891376292 > ./result_10chains/node173_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_2 -p 527 -st topic173_3_1 -pt None -u 0.03356601707455248 > ./result_10chains/node173_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_2 -p 817 -st topic173_4_1 -pt None -u 0.012404671558834679 > ./result_10chains/node173_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_2 -p 839 -st topic173_5_1 -pt None -u 0.01089446344289563 > ./result_10chains/node173_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_6_2 -p 841 -st topic173_6_1 -pt None -u 0.03965829550041172 > ./result_10chains/node173_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_7_2 -p 862 -st topic173_7_1 -pt None -u 0.06293871754298759 > ./result_10chains/node173_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_8_2 -p 962 -st topic173_8_1 -pt None -u 0.012859615188192508 > ./result_10chains/node173_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_9_2 -p 973 -st topic173_9_1 -pt None -u 0.03018133539498534 > ./result_10chains/node173_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_0 -p 37 -st none -pt topic173_0_0 -u 0.0006830657763737258 > ./result_10chains/node173_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_0 -p 180 -st none -pt topic173_1_0 -u 0.019758830584625575 > ./result_10chains/node173_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_0 -p 203 -st none -pt topic173_2_0 -u 0.009001381350479398 > ./result_10chains/node173_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_0 -p 527 -st none -pt topic173_3_0 -u 0.0033059379710757564 > ./result_10chains/node173_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_0 -p 817 -st none -pt topic173_4_0 -u 0.0002434154062959104 > ./result_10chains/node173_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_0 -p 839 -st none -pt topic173_5_0 -u 0.020007611455716723 > ./result_10chains/node173_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_6_0 -p 841 -st none -pt topic173_6_0 -u 0.009943878628895453 > ./result_10chains/node173_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_7_0 -p 862 -st none -pt topic173_7_0 -u 0.009338185449654174 > ./result_10chains/node173_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_8_0 -p 962 -st none -pt topic173_8_0 -u 0.016991791702720874 > ./result_10chains/node173_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_9_0 -p 973 -st none -pt topic173_9_0 -u 0.010079657149769973 > ./result_10chains/node173_9_0.txt &
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
    "./result_10chains/node173_0_0.txt 90"
    "./result_10chains/node173_0_2.txt 90"
    "./result_10chains/node173_1_0.txt 89"
    "./result_10chains/node173_1_2.txt 89"
    "./result_10chains/node173_2_0.txt 88"
    "./result_10chains/node173_2_2.txt 88"
    "./result_10chains/node173_3_0.txt 87"
    "./result_10chains/node173_3_2.txt 87"
    "./result_10chains/node173_4_0.txt 86"
    "./result_10chains/node173_4_2.txt 86"
    "./result_10chains/node173_5_0.txt 85"
    "./result_10chains/node173_5_2.txt 85"
    "./result_10chains/node173_6_0.txt 84"
    "./result_10chains/node173_6_2.txt 84"
    "./result_10chains/node173_7_0.txt 83"
    "./result_10chains/node173_7_2.txt 83"
    "./result_10chains/node173_8_0.txt 82"
    "./result_10chains/node173_8_2.txt 82"
    "./result_10chains/node173_9_0.txt 81"
    "./result_10chains/node173_9_2.txt 81"
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
