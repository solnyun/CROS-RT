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
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_2 -p 66 -st topic21_0_1 -pt None -u 0.013254851320841143 > ./result_10chains/node21_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_2 -p 70 -st topic21_1_1 -pt None -u 0.03851493185797106 > ./result_10chains/node21_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_2 -p 274 -st topic21_2_1 -pt None -u 0.013648776216694358 > ./result_10chains/node21_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_2 -p 354 -st topic21_3_1 -pt None -u 0.01174800497419648 > ./result_10chains/node21_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_2 -p 575 -st topic21_4_1 -pt None -u 0.0512380510143296 > ./result_10chains/node21_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_2 -p 595 -st topic21_5_1 -pt None -u 0.0025180478179562815 > ./result_10chains/node21_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_6_2 -p 637 -st topic21_6_1 -pt None -u 0.007331207628140615 > ./result_10chains/node21_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_7_2 -p 911 -st topic21_7_1 -pt None -u 0.036744234023809094 > ./result_10chains/node21_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_8_2 -p 915 -st topic21_8_1 -pt None -u 0.0007032111008570784 > ./result_10chains/node21_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_9_2 -p 929 -st topic21_9_1 -pt None -u 0.0014437099265472181 > ./result_10chains/node21_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_0 -p 66 -st none -pt topic21_0_0 -u 0.04635105851790833 > ./result_10chains/node21_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_0 -p 70 -st none -pt topic21_1_0 -u 0.0007818159927448498 > ./result_10chains/node21_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_0 -p 274 -st none -pt topic21_2_0 -u 0.0012514831337123722 > ./result_10chains/node21_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_0 -p 354 -st none -pt topic21_3_0 -u 0.018919116727985796 > ./result_10chains/node21_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_0 -p 575 -st none -pt topic21_4_0 -u 0.02393211830987957 > ./result_10chains/node21_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_0 -p 595 -st none -pt topic21_5_0 -u 0.023854470329318228 > ./result_10chains/node21_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_6_0 -p 637 -st none -pt topic21_6_0 -u 0.03490916821692573 > ./result_10chains/node21_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_7_0 -p 911 -st none -pt topic21_7_0 -u 0.005421520966090179 > ./result_10chains/node21_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_8_0 -p 915 -st none -pt topic21_8_0 -u 0.0011444583601937577 > ./result_10chains/node21_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_9_0 -p 929 -st none -pt topic21_9_0 -u 0.01317086236560823 > ./result_10chains/node21_9_0.txt &
sleep 10
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
    "./result_10chains/node21_0_0.txt 90"
    "./result_10chains/node21_0_2.txt 90"
    "./result_10chains/node21_1_0.txt 89"
    "./result_10chains/node21_1_2.txt 89"
    "./result_10chains/node21_2_0.txt 88"
    "./result_10chains/node21_2_2.txt 88"
    "./result_10chains/node21_3_0.txt 87"
    "./result_10chains/node21_3_2.txt 87"
    "./result_10chains/node21_4_0.txt 86"
    "./result_10chains/node21_4_2.txt 86"
    "./result_10chains/node21_5_0.txt 85"
    "./result_10chains/node21_5_2.txt 85"
    "./result_10chains/node21_6_0.txt 84"
    "./result_10chains/node21_6_2.txt 84"
    "./result_10chains/node21_7_0.txt 83"
    "./result_10chains/node21_7_2.txt 83"
    "./result_10chains/node21_8_0.txt 82"
    "./result_10chains/node21_8_2.txt 82"
    "./result_10chains/node21_9_0.txt 81"
    "./result_10chains/node21_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
