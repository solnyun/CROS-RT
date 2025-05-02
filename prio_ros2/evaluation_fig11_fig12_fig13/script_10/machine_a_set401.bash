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
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_2 -p 42 -st topic401_0_1 -pt None -u 0.013072711810602322 > ./result_10chains/node401_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_2 -p 70 -st topic401_1_1 -pt None -u 0.004363686020061097 > ./result_10chains/node401_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_2 -p 174 -st topic401_2_1 -pt None -u 0.017967771119008602 > ./result_10chains/node401_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_2 -p 226 -st topic401_3_1 -pt None -u 0.009069663545256346 > ./result_10chains/node401_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_2 -p 259 -st topic401_4_1 -pt None -u 0.005270492543014593 > ./result_10chains/node401_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_2 -p 331 -st topic401_5_1 -pt None -u 0.041386466129955585 > ./result_10chains/node401_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_2 -p 465 -st topic401_6_1 -pt None -u 0.02790733321050609 > ./result_10chains/node401_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_2 -p 487 -st topic401_7_1 -pt None -u 0.0042914513313667135 > ./result_10chains/node401_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_8_2 -p 589 -st topic401_8_1 -pt None -u 0.011904943881064466 > ./result_10chains/node401_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_9_2 -p 608 -st topic401_9_1 -pt None -u 0.022141341046064623 > ./result_10chains/node401_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_0 -p 42 -st none -pt topic401_0_0 -u 0.017691845875216772 > ./result_10chains/node401_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_0 -p 70 -st none -pt topic401_1_0 -u 0.009015003362028762 > ./result_10chains/node401_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_0 -p 174 -st none -pt topic401_2_0 -u 0.00836234991715984 > ./result_10chains/node401_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_0 -p 226 -st none -pt topic401_3_0 -u 0.026823364044521736 > ./result_10chains/node401_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_0 -p 259 -st none -pt topic401_4_0 -u 0.01740954246298304 > ./result_10chains/node401_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_0 -p 331 -st none -pt topic401_5_0 -u 0.004661837009771241 > ./result_10chains/node401_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_0 -p 465 -st none -pt topic401_6_0 -u 0.009467301153510299 > ./result_10chains/node401_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_0 -p 487 -st none -pt topic401_7_0 -u 0.0011228044176517793 > ./result_10chains/node401_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_8_0 -p 589 -st none -pt topic401_8_0 -u 0.05657046184143254 > ./result_10chains/node401_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_9_0 -p 608 -st none -pt topic401_9_0 -u 0.008548214220689118 > ./result_10chains/node401_9_0.txt &
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
    "./result_10chains/node401_0_0.txt 90"
    "./result_10chains/node401_0_2.txt 90"
    "./result_10chains/node401_1_0.txt 89"
    "./result_10chains/node401_1_2.txt 89"
    "./result_10chains/node401_2_0.txt 88"
    "./result_10chains/node401_2_2.txt 88"
    "./result_10chains/node401_3_0.txt 87"
    "./result_10chains/node401_3_2.txt 87"
    "./result_10chains/node401_4_0.txt 86"
    "./result_10chains/node401_4_2.txt 86"
    "./result_10chains/node401_5_0.txt 85"
    "./result_10chains/node401_5_2.txt 85"
    "./result_10chains/node401_6_0.txt 84"
    "./result_10chains/node401_6_2.txt 84"
    "./result_10chains/node401_7_0.txt 83"
    "./result_10chains/node401_7_2.txt 83"
    "./result_10chains/node401_8_0.txt 82"
    "./result_10chains/node401_8_2.txt 82"
    "./result_10chains/node401_9_0.txt 81"
    "./result_10chains/node401_9_2.txt 81"
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
