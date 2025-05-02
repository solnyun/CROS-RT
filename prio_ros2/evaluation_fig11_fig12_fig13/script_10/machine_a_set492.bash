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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_2 -p 13 -st topic492_0_1 -pt None -u 0.0013683495065405782 > ./result_10chains/node492_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_2 -p 200 -st topic492_1_1 -pt None -u 0.009473896651686298 > ./result_10chains/node492_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_2 -p 266 -st topic492_2_1 -pt None -u 0.015574959987328385 > ./result_10chains/node492_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_2 -p 455 -st topic492_3_1 -pt None -u 0.036161162181658546 > ./result_10chains/node492_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_2 -p 500 -st topic492_4_1 -pt None -u 0.017781519517567124 > ./result_10chains/node492_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_2 -p 574 -st topic492_5_1 -pt None -u 0.012378869529676623 > ./result_10chains/node492_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_2 -p 706 -st topic492_6_1 -pt None -u 0.004543687862027995 > ./result_10chains/node492_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_2 -p 738 -st topic492_7_1 -pt None -u 0.02096273155715833 > ./result_10chains/node492_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_8_2 -p 899 -st topic492_8_1 -pt None -u 0.02627787858150181 > ./result_10chains/node492_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_9_2 -p 909 -st topic492_9_1 -pt None -u 0.009995803896101487 > ./result_10chains/node492_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_0 -p 13 -st none -pt topic492_0_0 -u 0.00261444138450595 > ./result_10chains/node492_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_0 -p 200 -st none -pt topic492_1_0 -u 0.014166297157871266 > ./result_10chains/node492_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_0 -p 266 -st none -pt topic492_2_0 -u 0.03958488644202085 > ./result_10chains/node492_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_0 -p 455 -st none -pt topic492_3_0 -u 0.009733110978517423 > ./result_10chains/node492_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_0 -p 500 -st none -pt topic492_4_0 -u 0.011933495906294445 > ./result_10chains/node492_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_0 -p 574 -st none -pt topic492_5_0 -u 0.0002341972993555319 > ./result_10chains/node492_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_0 -p 706 -st none -pt topic492_6_0 -u 0.002734849197011585 > ./result_10chains/node492_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_0 -p 738 -st none -pt topic492_7_0 -u 0.025033758496547945 > ./result_10chains/node492_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_8_0 -p 899 -st none -pt topic492_8_0 -u 0.02273537494419685 > ./result_10chains/node492_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_9_0 -p 909 -st none -pt topic492_9_0 -u 0.0002382954419285696 > ./result_10chains/node492_9_0.txt &
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
    "./result_10chains/node492_0_0.txt 90"
    "./result_10chains/node492_0_2.txt 90"
    "./result_10chains/node492_1_0.txt 89"
    "./result_10chains/node492_1_2.txt 89"
    "./result_10chains/node492_2_0.txt 88"
    "./result_10chains/node492_2_2.txt 88"
    "./result_10chains/node492_3_0.txt 87"
    "./result_10chains/node492_3_2.txt 87"
    "./result_10chains/node492_4_0.txt 86"
    "./result_10chains/node492_4_2.txt 86"
    "./result_10chains/node492_5_0.txt 85"
    "./result_10chains/node492_5_2.txt 85"
    "./result_10chains/node492_6_0.txt 84"
    "./result_10chains/node492_6_2.txt 84"
    "./result_10chains/node492_7_0.txt 83"
    "./result_10chains/node492_7_2.txt 83"
    "./result_10chains/node492_8_0.txt 82"
    "./result_10chains/node492_8_2.txt 82"
    "./result_10chains/node492_9_0.txt 81"
    "./result_10chains/node492_9_2.txt 81"
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
