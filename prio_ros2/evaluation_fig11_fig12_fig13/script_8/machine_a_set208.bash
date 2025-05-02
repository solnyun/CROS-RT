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
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_2 -p 85 -st topic208_0_1 -pt None -u 0.0009522297873377217 > ./result_8chains/node208_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_2 -p 463 -st topic208_1_1 -pt None -u 0.045292272698307545 > ./result_8chains/node208_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_2 -p 466 -st topic208_2_1 -pt None -u 0.007972982318161681 > ./result_8chains/node208_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_2 -p 630 -st topic208_3_1 -pt None -u 0.06193465605519599 > ./result_8chains/node208_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_4_2 -p 688 -st topic208_4_1 -pt None -u 0.02047235366138439 > ./result_8chains/node208_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_5_2 -p 794 -st topic208_5_1 -pt None -u 0.000769548554383076 > ./result_8chains/node208_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_6_2 -p 894 -st topic208_6_1 -pt None -u 0.012974055625997613 > ./result_8chains/node208_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_7_2 -p 910 -st topic208_7_1 -pt None -u 0.02371859022331947 > ./result_8chains/node208_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_0 -p 85 -st none -pt topic208_0_0 -u 0.021492244597226595 > ./result_8chains/node208_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_0 -p 463 -st none -pt topic208_1_0 -u 0.037852625831520104 > ./result_8chains/node208_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_0 -p 466 -st none -pt topic208_2_0 -u 0.039934555098170565 > ./result_8chains/node208_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_0 -p 630 -st none -pt topic208_3_0 -u 0.0017530935693907401 > ./result_8chains/node208_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_4_0 -p 688 -st none -pt topic208_4_0 -u 0.038509429065224615 > ./result_8chains/node208_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_5_0 -p 794 -st none -pt topic208_5_0 -u 0.004832761570608121 > ./result_8chains/node208_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_6_0 -p 894 -st none -pt topic208_6_0 -u 0.010487305744845243 > ./result_8chains/node208_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_7_0 -p 910 -st none -pt topic208_7_0 -u 0.004742176118132949 > ./result_8chains/node208_7_0.txt &
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
    "./result_8chains/node208_0_0.txt 90"
    "./result_8chains/node208_0_2.txt 90"
    "./result_8chains/node208_1_0.txt 89"
    "./result_8chains/node208_1_2.txt 89"
    "./result_8chains/node208_2_0.txt 88"
    "./result_8chains/node208_2_2.txt 88"
    "./result_8chains/node208_3_0.txt 87"
    "./result_8chains/node208_3_2.txt 87"
    "./result_8chains/node208_4_0.txt 86"
    "./result_8chains/node208_4_2.txt 86"
    "./result_8chains/node208_5_0.txt 85"
    "./result_8chains/node208_5_2.txt 85"
    "./result_8chains/node208_6_0.txt 84"
    "./result_8chains/node208_6_2.txt 84"
    "./result_8chains/node208_7_0.txt 83"
    "./result_8chains/node208_7_2.txt 83"
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
