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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_2 -p 184 -st topic361_0_1 -pt None -u 0.022096499376677847 > ./result_10chains/node361_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_2 -p 352 -st topic361_1_1 -pt None -u 0.007015212419332173 > ./result_10chains/node361_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_2 -p 412 -st topic361_2_1 -pt None -u 0.010572384441198068 > ./result_10chains/node361_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_2 -p 526 -st topic361_3_1 -pt None -u 0.0005452382029405844 > ./result_10chains/node361_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_2 -p 635 -st topic361_4_1 -pt None -u 0.017396627530790437 > ./result_10chains/node361_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_2 -p 817 -st topic361_5_1 -pt None -u 0.006460211565384788 > ./result_10chains/node361_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_2 -p 844 -st topic361_6_1 -pt None -u 0.002073337530540828 > ./result_10chains/node361_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_2 -p 936 -st topic361_7_1 -pt None -u 0.015611307192535215 > ./result_10chains/node361_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_8_2 -p 975 -st topic361_8_1 -pt None -u 0.008839587453914482 > ./result_10chains/node361_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_9_2 -p 993 -st topic361_9_1 -pt None -u 0.004375340097289889 > ./result_10chains/node361_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_0 -p 184 -st none -pt topic361_0_0 -u 0.0055353771073316516 > ./result_10chains/node361_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_0 -p 352 -st none -pt topic361_1_0 -u 0.03371504415701587 > ./result_10chains/node361_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_0 -p 412 -st none -pt topic361_2_0 -u 0.05106590567519931 > ./result_10chains/node361_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_0 -p 526 -st none -pt topic361_3_0 -u 0.0140645775299163 > ./result_10chains/node361_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_0 -p 635 -st none -pt topic361_4_0 -u 0.015071173496828932 > ./result_10chains/node361_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_0 -p 817 -st none -pt topic361_5_0 -u 0.044276479482903947 > ./result_10chains/node361_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_0 -p 844 -st none -pt topic361_6_0 -u 0.011775728507593897 > ./result_10chains/node361_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_0 -p 936 -st none -pt topic361_7_0 -u 0.03183886754949235 > ./result_10chains/node361_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_8_0 -p 975 -st none -pt topic361_8_0 -u 0.006063259341246352 > ./result_10chains/node361_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_9_0 -p 993 -st none -pt topic361_9_0 -u 0.006024264672000047 > ./result_10chains/node361_9_0.txt &
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
    "./result_10chains/node361_0_0.txt 90"
    "./result_10chains/node361_0_2.txt 90"
    "./result_10chains/node361_1_0.txt 89"
    "./result_10chains/node361_1_2.txt 89"
    "./result_10chains/node361_2_0.txt 88"
    "./result_10chains/node361_2_2.txt 88"
    "./result_10chains/node361_3_0.txt 87"
    "./result_10chains/node361_3_2.txt 87"
    "./result_10chains/node361_4_0.txt 86"
    "./result_10chains/node361_4_2.txt 86"
    "./result_10chains/node361_5_0.txt 85"
    "./result_10chains/node361_5_2.txt 85"
    "./result_10chains/node361_6_0.txt 84"
    "./result_10chains/node361_6_2.txt 84"
    "./result_10chains/node361_7_0.txt 83"
    "./result_10chains/node361_7_2.txt 83"
    "./result_10chains/node361_8_0.txt 82"
    "./result_10chains/node361_8_2.txt 82"
    "./result_10chains/node361_9_0.txt 81"
    "./result_10chains/node361_9_2.txt 81"
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
