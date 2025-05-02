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
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_2 -p 83 -st topic133_0_1 -pt None -u 0.0340485814603948 > ./result_8chains/node133_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_2 -p 237 -st topic133_1_1 -pt None -u 0.024411032639376384 > ./result_8chains/node133_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_2 -p 279 -st topic133_2_1 -pt None -u 0.011443474098496859 > ./result_8chains/node133_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_2 -p 451 -st topic133_3_1 -pt None -u 0.021676776504381656 > ./result_8chains/node133_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_2 -p 489 -st topic133_4_1 -pt None -u 0.002213631550872064 > ./result_8chains/node133_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_2 -p 812 -st topic133_5_1 -pt None -u 0.011550603782043811 > ./result_8chains/node133_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_2 -p 924 -st topic133_6_1 -pt None -u 0.013908401382537766 > ./result_8chains/node133_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_2 -p 936 -st topic133_7_1 -pt None -u 0.017866672992774123 > ./result_8chains/node133_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_0 -p 83 -st none -pt topic133_0_0 -u 0.013360213694852241 > ./result_8chains/node133_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_0 -p 237 -st none -pt topic133_1_0 -u 0.020014659174427074 > ./result_8chains/node133_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_0 -p 279 -st none -pt topic133_2_0 -u 0.027825813413765887 > ./result_8chains/node133_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_0 -p 451 -st none -pt topic133_3_0 -u 0.01479150431440765 > ./result_8chains/node133_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_0 -p 489 -st none -pt topic133_4_0 -u 0.004557020068906792 > ./result_8chains/node133_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_0 -p 812 -st none -pt topic133_5_0 -u 0.009712709707226458 > ./result_8chains/node133_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_0 -p 924 -st none -pt topic133_6_0 -u 0.03353501652708808 > ./result_8chains/node133_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_0 -p 936 -st none -pt topic133_7_0 -u 0.013373404191025048 > ./result_8chains/node133_7_0.txt &
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
    "./result_8chains/node133_0_0.txt 90"
    "./result_8chains/node133_0_2.txt 90"
    "./result_8chains/node133_1_0.txt 89"
    "./result_8chains/node133_1_2.txt 89"
    "./result_8chains/node133_2_0.txt 88"
    "./result_8chains/node133_2_2.txt 88"
    "./result_8chains/node133_3_0.txt 87"
    "./result_8chains/node133_3_2.txt 87"
    "./result_8chains/node133_4_0.txt 86"
    "./result_8chains/node133_4_2.txt 86"
    "./result_8chains/node133_5_0.txt 85"
    "./result_8chains/node133_5_2.txt 85"
    "./result_8chains/node133_6_0.txt 84"
    "./result_8chains/node133_6_2.txt 84"
    "./result_8chains/node133_7_0.txt 83"
    "./result_8chains/node133_7_2.txt 83"
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
