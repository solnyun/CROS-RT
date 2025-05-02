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
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_2 -p 27 -st topic223_0_1 -pt None -u 0.0038185980534208297 > ./result_10chains/node223_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_2 -p 150 -st topic223_1_1 -pt None -u 0.02645100957688795 > ./result_10chains/node223_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_2 -p 283 -st topic223_2_1 -pt None -u 0.03790714373431725 > ./result_10chains/node223_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_2 -p 400 -st topic223_3_1 -pt None -u 0.004784910598924719 > ./result_10chains/node223_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_2 -p 407 -st topic223_4_1 -pt None -u 0.0005024029191800228 > ./result_10chains/node223_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_2 -p 637 -st topic223_5_1 -pt None -u 0.0067919900378405895 > ./result_10chains/node223_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_6_2 -p 796 -st topic223_6_1 -pt None -u 0.005396750259679339 > ./result_10chains/node223_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_7_2 -p 813 -st topic223_7_1 -pt None -u 0.018538663104190944 > ./result_10chains/node223_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_8_2 -p 864 -st topic223_8_1 -pt None -u 0.0013171000059292552 > ./result_10chains/node223_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_9_2 -p 966 -st topic223_9_1 -pt None -u 0.006493751735483837 > ./result_10chains/node223_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_0 -p 27 -st none -pt topic223_0_0 -u 0.008277503764746008 > ./result_10chains/node223_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_0 -p 150 -st none -pt topic223_1_0 -u 0.04854133482936124 > ./result_10chains/node223_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_0 -p 283 -st none -pt topic223_2_0 -u 0.009939009490150641 > ./result_10chains/node223_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_0 -p 400 -st none -pt topic223_3_0 -u 0.011810091498697217 > ./result_10chains/node223_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_0 -p 407 -st none -pt topic223_4_0 -u 0.010055694300042661 > ./result_10chains/node223_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_0 -p 637 -st none -pt topic223_5_0 -u 0.02743740315446791 > ./result_10chains/node223_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_6_0 -p 796 -st none -pt topic223_6_0 -u 0.009046084641073954 > ./result_10chains/node223_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_7_0 -p 813 -st none -pt topic223_7_0 -u 0.007139591259986755 > ./result_10chains/node223_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_8_0 -p 864 -st none -pt topic223_8_0 -u 0.0353953417458146 > ./result_10chains/node223_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_9_0 -p 966 -st none -pt topic223_9_0 -u 0.007218079091702308 > ./result_10chains/node223_9_0.txt &
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
    "./result_10chains/node223_0_0.txt 90"
    "./result_10chains/node223_0_2.txt 90"
    "./result_10chains/node223_1_0.txt 89"
    "./result_10chains/node223_1_2.txt 89"
    "./result_10chains/node223_2_0.txt 88"
    "./result_10chains/node223_2_2.txt 88"
    "./result_10chains/node223_3_0.txt 87"
    "./result_10chains/node223_3_2.txt 87"
    "./result_10chains/node223_4_0.txt 86"
    "./result_10chains/node223_4_2.txt 86"
    "./result_10chains/node223_5_0.txt 85"
    "./result_10chains/node223_5_2.txt 85"
    "./result_10chains/node223_6_0.txt 84"
    "./result_10chains/node223_6_2.txt 84"
    "./result_10chains/node223_7_0.txt 83"
    "./result_10chains/node223_7_2.txt 83"
    "./result_10chains/node223_8_0.txt 82"
    "./result_10chains/node223_8_2.txt 82"
    "./result_10chains/node223_9_0.txt 81"
    "./result_10chains/node223_9_2.txt 81"
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
