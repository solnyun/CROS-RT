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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_2 -p 41 -st topic368_0_1 -pt None -u 0.004702883441596861 > ./result_10chains/node368_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_2 -p 246 -st topic368_1_1 -pt None -u 0.015620749187841898 > ./result_10chains/node368_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_2 -p 425 -st topic368_2_1 -pt None -u 0.00990890558748636 > ./result_10chains/node368_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_2 -p 436 -st topic368_3_1 -pt None -u 0.004302122537928388 > ./result_10chains/node368_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_2 -p 506 -st topic368_4_1 -pt None -u 0.03287932037540314 > ./result_10chains/node368_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_2 -p 523 -st topic368_5_1 -pt None -u 0.025196361957713492 > ./result_10chains/node368_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_2 -p 613 -st topic368_6_1 -pt None -u 0.013141805432336423 > ./result_10chains/node368_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_2 -p 616 -st topic368_7_1 -pt None -u 0.024092056151789346 > ./result_10chains/node368_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_8_2 -p 710 -st topic368_8_1 -pt None -u 0.0016654961438291593 > ./result_10chains/node368_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_9_2 -p 897 -st topic368_9_1 -pt None -u 0.02949362360230364 > ./result_10chains/node368_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_0 -p 41 -st none -pt topic368_0_0 -u 0.028932010451241497 > ./result_10chains/node368_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_0 -p 246 -st none -pt topic368_1_0 -u 0.007080039534604898 > ./result_10chains/node368_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_0 -p 425 -st none -pt topic368_2_0 -u 0.010078070104620751 > ./result_10chains/node368_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_0 -p 436 -st none -pt topic368_3_0 -u 0.015537082705780414 > ./result_10chains/node368_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_0 -p 506 -st none -pt topic368_4_0 -u 0.0006868309968973141 > ./result_10chains/node368_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_0 -p 523 -st none -pt topic368_5_0 -u 0.03699947808850043 > ./result_10chains/node368_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_0 -p 613 -st none -pt topic368_6_0 -u 0.006977778361780235 > ./result_10chains/node368_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_0 -p 616 -st none -pt topic368_7_0 -u 0.03365183230428645 > ./result_10chains/node368_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_8_0 -p 710 -st none -pt topic368_8_0 -u 0.003546083456055185 > ./result_10chains/node368_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_9_0 -p 897 -st none -pt topic368_9_0 -u 0.04178957013419344 > ./result_10chains/node368_9_0.txt &
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
    "./result_10chains/node368_0_0.txt 90"
    "./result_10chains/node368_0_2.txt 90"
    "./result_10chains/node368_1_0.txt 89"
    "./result_10chains/node368_1_2.txt 89"
    "./result_10chains/node368_2_0.txt 88"
    "./result_10chains/node368_2_2.txt 88"
    "./result_10chains/node368_3_0.txt 87"
    "./result_10chains/node368_3_2.txt 87"
    "./result_10chains/node368_4_0.txt 86"
    "./result_10chains/node368_4_2.txt 86"
    "./result_10chains/node368_5_0.txt 85"
    "./result_10chains/node368_5_2.txt 85"
    "./result_10chains/node368_6_0.txt 84"
    "./result_10chains/node368_6_2.txt 84"
    "./result_10chains/node368_7_0.txt 83"
    "./result_10chains/node368_7_2.txt 83"
    "./result_10chains/node368_8_0.txt 82"
    "./result_10chains/node368_8_2.txt 82"
    "./result_10chains/node368_9_0.txt 81"
    "./result_10chains/node368_9_2.txt 81"
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
