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
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_2 -p 54 -st topic179_0_1 -pt None -u 0.0061218112765615285 > ./result_10chains/node179_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_2 -p 136 -st topic179_1_1 -pt None -u 0.0033606222799401064 > ./result_10chains/node179_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_2 -p 243 -st topic179_2_1 -pt None -u 0.00745407450195229 > ./result_10chains/node179_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_2 -p 389 -st topic179_3_1 -pt None -u 0.0011152202154162127 > ./result_10chains/node179_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_2 -p 421 -st topic179_4_1 -pt None -u 0.01254367580120197 > ./result_10chains/node179_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_2 -p 539 -st topic179_5_1 -pt None -u 0.007050133493236688 > ./result_10chains/node179_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_2 -p 692 -st topic179_6_1 -pt None -u 0.035399000852973206 > ./result_10chains/node179_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_2 -p 776 -st topic179_7_1 -pt None -u 0.0024355049085684755 > ./result_10chains/node179_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_8_2 -p 856 -st topic179_8_1 -pt None -u 0.025745185940949974 > ./result_10chains/node179_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_9_2 -p 934 -st topic179_9_1 -pt None -u 0.003602518486006429 > ./result_10chains/node179_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_0 -p 54 -st none -pt topic179_0_0 -u 0.007857185580325166 > ./result_10chains/node179_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_0 -p 136 -st none -pt topic179_1_0 -u 0.005715902647810911 > ./result_10chains/node179_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_0 -p 243 -st none -pt topic179_2_0 -u 0.00671957430313741 > ./result_10chains/node179_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_0 -p 389 -st none -pt topic179_3_0 -u 0.009637061885650444 > ./result_10chains/node179_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_0 -p 421 -st none -pt topic179_4_0 -u 0.00848538803694443 > ./result_10chains/node179_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_0 -p 539 -st none -pt topic179_5_0 -u 0.03289697072525699 > ./result_10chains/node179_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_0 -p 692 -st none -pt topic179_6_0 -u 0.01662586862897031 > ./result_10chains/node179_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_0 -p 776 -st none -pt topic179_7_0 -u 0.010964698367736253 > ./result_10chains/node179_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_8_0 -p 856 -st none -pt topic179_8_0 -u 0.030104252682331856 > ./result_10chains/node179_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_9_0 -p 934 -st none -pt topic179_9_0 -u 0.09614264072676404 > ./result_10chains/node179_9_0.txt &
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
    "./result_10chains/node179_0_0.txt 90"
    "./result_10chains/node179_0_2.txt 90"
    "./result_10chains/node179_1_0.txt 89"
    "./result_10chains/node179_1_2.txt 89"
    "./result_10chains/node179_2_0.txt 88"
    "./result_10chains/node179_2_2.txt 88"
    "./result_10chains/node179_3_0.txt 87"
    "./result_10chains/node179_3_2.txt 87"
    "./result_10chains/node179_4_0.txt 86"
    "./result_10chains/node179_4_2.txt 86"
    "./result_10chains/node179_5_0.txt 85"
    "./result_10chains/node179_5_2.txt 85"
    "./result_10chains/node179_6_0.txt 84"
    "./result_10chains/node179_6_2.txt 84"
    "./result_10chains/node179_7_0.txt 83"
    "./result_10chains/node179_7_2.txt 83"
    "./result_10chains/node179_8_0.txt 82"
    "./result_10chains/node179_8_2.txt 82"
    "./result_10chains/node179_9_0.txt 81"
    "./result_10chains/node179_9_2.txt 81"
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
