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
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_2 -p 13 -st topic92_0_1 -pt None -u 0.01279828300981145 > ./result_10chains/node92_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_2 -p 47 -st topic92_1_1 -pt None -u 0.011369223743857904 > ./result_10chains/node92_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_2 -p 184 -st topic92_2_1 -pt None -u 0.08839736955683303 > ./result_10chains/node92_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_2 -p 338 -st topic92_3_1 -pt None -u 0.0066773112321573125 > ./result_10chains/node92_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_2 -p 353 -st topic92_4_1 -pt None -u 0.008546655063124575 > ./result_10chains/node92_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_2 -p 391 -st topic92_5_1 -pt None -u 0.0017696284281165098 > ./result_10chains/node92_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_6_2 -p 409 -st topic92_6_1 -pt None -u 0.0116805595260564 > ./result_10chains/node92_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_7_2 -p 539 -st topic92_7_1 -pt None -u 0.013681035492119173 > ./result_10chains/node92_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_8_2 -p 858 -st topic92_8_1 -pt None -u 0.011684149560511253 > ./result_10chains/node92_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_9_2 -p 900 -st topic92_9_1 -pt None -u 0.058267707254671765 > ./result_10chains/node92_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_0 -p 13 -st none -pt topic92_0_0 -u 0.01113270957636997 > ./result_10chains/node92_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_0 -p 47 -st none -pt topic92_1_0 -u 0.0043654217949243845 > ./result_10chains/node92_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_0 -p 184 -st none -pt topic92_2_0 -u 0.012297714197382681 > ./result_10chains/node92_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_0 -p 338 -st none -pt topic92_3_0 -u 0.000519610951713434 > ./result_10chains/node92_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_0 -p 353 -st none -pt topic92_4_0 -u 0.020807935186665266 > ./result_10chains/node92_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_0 -p 391 -st none -pt topic92_5_0 -u 0.024781726921919184 > ./result_10chains/node92_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_6_0 -p 409 -st none -pt topic92_6_0 -u 0.0014871753652175024 > ./result_10chains/node92_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_7_0 -p 539 -st none -pt topic92_7_0 -u 0.0023599021832060307 > ./result_10chains/node92_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_8_0 -p 858 -st none -pt topic92_8_0 -u 0.0034912725870959588 > ./result_10chains/node92_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_9_0 -p 900 -st none -pt topic92_9_0 -u 0.007706357225464949 > ./result_10chains/node92_9_0.txt &
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
    "./result_10chains/node92_0_0.txt 90"
    "./result_10chains/node92_0_2.txt 90"
    "./result_10chains/node92_1_0.txt 89"
    "./result_10chains/node92_1_2.txt 89"
    "./result_10chains/node92_2_0.txt 88"
    "./result_10chains/node92_2_2.txt 88"
    "./result_10chains/node92_3_0.txt 87"
    "./result_10chains/node92_3_2.txt 87"
    "./result_10chains/node92_4_0.txt 86"
    "./result_10chains/node92_4_2.txt 86"
    "./result_10chains/node92_5_0.txt 85"
    "./result_10chains/node92_5_2.txt 85"
    "./result_10chains/node92_6_0.txt 84"
    "./result_10chains/node92_6_2.txt 84"
    "./result_10chains/node92_7_0.txt 83"
    "./result_10chains/node92_7_2.txt 83"
    "./result_10chains/node92_8_0.txt 82"
    "./result_10chains/node92_8_2.txt 82"
    "./result_10chains/node92_9_0.txt 81"
    "./result_10chains/node92_9_2.txt 81"
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
