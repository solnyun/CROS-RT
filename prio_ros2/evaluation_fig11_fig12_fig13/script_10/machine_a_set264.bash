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
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_2 -p 164 -st topic264_0_1 -pt None -u 0.02199375986748653 > ./result_10chains/node264_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_2 -p 357 -st topic264_1_1 -pt None -u 0.03162010550229666 > ./result_10chains/node264_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_2 -p 473 -st topic264_2_1 -pt None -u 0.010732322751268342 > ./result_10chains/node264_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_2 -p 489 -st topic264_3_1 -pt None -u 0.002964390521335014 > ./result_10chains/node264_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_2 -p 521 -st topic264_4_1 -pt None -u 0.01099551355809758 > ./result_10chains/node264_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_2 -p 859 -st topic264_5_1 -pt None -u 0.006388402204671767 > ./result_10chains/node264_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_2 -p 875 -st topic264_6_1 -pt None -u 0.00418085057531889 > ./result_10chains/node264_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_2 -p 937 -st topic264_7_1 -pt None -u 0.013071194126853994 > ./result_10chains/node264_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_8_2 -p 957 -st topic264_8_1 -pt None -u 0.01686521053432255 > ./result_10chains/node264_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_9_2 -p 991 -st topic264_9_1 -pt None -u 0.010771707830967819 > ./result_10chains/node264_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_0 -p 164 -st none -pt topic264_0_0 -u 0.03031883936017099 > ./result_10chains/node264_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_0 -p 357 -st none -pt topic264_1_0 -u 0.045703778567662445 > ./result_10chains/node264_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_0 -p 473 -st none -pt topic264_2_0 -u 0.007322468563736029 > ./result_10chains/node264_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_0 -p 489 -st none -pt topic264_3_0 -u 0.011263570885652774 > ./result_10chains/node264_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_0 -p 521 -st none -pt topic264_4_0 -u 0.024750195642925188 > ./result_10chains/node264_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_0 -p 859 -st none -pt topic264_5_0 -u 0.03381981916574675 > ./result_10chains/node264_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_0 -p 875 -st none -pt topic264_6_0 -u 0.019017694609110597 > ./result_10chains/node264_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_0 -p 937 -st none -pt topic264_7_0 -u 0.003409563703332369 > ./result_10chains/node264_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_8_0 -p 957 -st none -pt topic264_8_0 -u 0.0020333782625567565 > ./result_10chains/node264_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_9_0 -p 991 -st none -pt topic264_9_0 -u 0.010883167842311688 > ./result_10chains/node264_9_0.txt &
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
    "./result_10chains/node264_0_0.txt 90"
    "./result_10chains/node264_0_2.txt 90"
    "./result_10chains/node264_1_0.txt 89"
    "./result_10chains/node264_1_2.txt 89"
    "./result_10chains/node264_2_0.txt 88"
    "./result_10chains/node264_2_2.txt 88"
    "./result_10chains/node264_3_0.txt 87"
    "./result_10chains/node264_3_2.txt 87"
    "./result_10chains/node264_4_0.txt 86"
    "./result_10chains/node264_4_2.txt 86"
    "./result_10chains/node264_5_0.txt 85"
    "./result_10chains/node264_5_2.txt 85"
    "./result_10chains/node264_6_0.txt 84"
    "./result_10chains/node264_6_2.txt 84"
    "./result_10chains/node264_7_0.txt 83"
    "./result_10chains/node264_7_2.txt 83"
    "./result_10chains/node264_8_0.txt 82"
    "./result_10chains/node264_8_2.txt 82"
    "./result_10chains/node264_9_0.txt 81"
    "./result_10chains/node264_9_2.txt 81"
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
