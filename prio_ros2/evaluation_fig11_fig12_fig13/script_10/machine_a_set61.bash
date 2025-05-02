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
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_2 -p 64 -st topic61_0_1 -pt None -u 0.007466099214260169 > ./result_10chains/node61_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_2 -p 105 -st topic61_1_1 -pt None -u 0.009477129393017869 > ./result_10chains/node61_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_2 -p 211 -st topic61_2_1 -pt None -u 0.01537168670895045 > ./result_10chains/node61_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_2 -p 219 -st topic61_3_1 -pt None -u 0.0042748322477143 > ./result_10chains/node61_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_2 -p 399 -st topic61_4_1 -pt None -u 0.0034188131179880288 > ./result_10chains/node61_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_2 -p 424 -st topic61_5_1 -pt None -u 0.037540327543965024 > ./result_10chains/node61_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_2 -p 794 -st topic61_6_1 -pt None -u 0.0010375747312610373 > ./result_10chains/node61_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_2 -p 812 -st topic61_7_1 -pt None -u 0.00583603395271956 > ./result_10chains/node61_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_8_2 -p 815 -st topic61_8_1 -pt None -u 0.02661387309742505 > ./result_10chains/node61_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_9_2 -p 883 -st topic61_9_1 -pt None -u 0.002580376456187849 > ./result_10chains/node61_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_0 -p 64 -st none -pt topic61_0_0 -u 0.011926769097280243 > ./result_10chains/node61_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_0 -p 105 -st none -pt topic61_1_0 -u 0.04223781894646883 > ./result_10chains/node61_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_0 -p 211 -st none -pt topic61_2_0 -u 0.019473472501438105 > ./result_10chains/node61_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_0 -p 219 -st none -pt topic61_3_0 -u 0.0033001129304892074 > ./result_10chains/node61_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_0 -p 399 -st none -pt topic61_4_0 -u 0.008964380238517755 > ./result_10chains/node61_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_0 -p 424 -st none -pt topic61_5_0 -u 0.017126392147557734 > ./result_10chains/node61_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_0 -p 794 -st none -pt topic61_6_0 -u 0.006779193161922659 > ./result_10chains/node61_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_0 -p 812 -st none -pt topic61_7_0 -u 0.032410384214036886 > ./result_10chains/node61_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_8_0 -p 815 -st none -pt topic61_8_0 -u 0.007830485489603828 > ./result_10chains/node61_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_9_0 -p 883 -st none -pt topic61_9_0 -u 0.06128215202065222 > ./result_10chains/node61_9_0.txt &
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
    "./result_10chains/node61_0_0.txt 90"
    "./result_10chains/node61_0_2.txt 90"
    "./result_10chains/node61_1_0.txt 89"
    "./result_10chains/node61_1_2.txt 89"
    "./result_10chains/node61_2_0.txt 88"
    "./result_10chains/node61_2_2.txt 88"
    "./result_10chains/node61_3_0.txt 87"
    "./result_10chains/node61_3_2.txt 87"
    "./result_10chains/node61_4_0.txt 86"
    "./result_10chains/node61_4_2.txt 86"
    "./result_10chains/node61_5_0.txt 85"
    "./result_10chains/node61_5_2.txt 85"
    "./result_10chains/node61_6_0.txt 84"
    "./result_10chains/node61_6_2.txt 84"
    "./result_10chains/node61_7_0.txt 83"
    "./result_10chains/node61_7_2.txt 83"
    "./result_10chains/node61_8_0.txt 82"
    "./result_10chains/node61_8_2.txt 82"
    "./result_10chains/node61_9_0.txt 81"
    "./result_10chains/node61_9_2.txt 81"
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
