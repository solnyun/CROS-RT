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
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_2 -p 93 -st topic424_0_1 -pt None -u 0.005614223399052154 > ./result_8chains/node424_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_2 -p 277 -st topic424_1_1 -pt None -u 0.024723057066446175 > ./result_8chains/node424_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_2 -p 474 -st topic424_2_1 -pt None -u 0.021811954143894086 > ./result_8chains/node424_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_2 -p 486 -st topic424_3_1 -pt None -u 0.002862432246832247 > ./result_8chains/node424_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_2 -p 554 -st topic424_4_1 -pt None -u 0.010751270295120657 > ./result_8chains/node424_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_2 -p 768 -st topic424_5_1 -pt None -u 0.05597804783130114 > ./result_8chains/node424_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_2 -p 886 -st topic424_6_1 -pt None -u 0.043990136986985964 > ./result_8chains/node424_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_2 -p 902 -st topic424_7_1 -pt None -u 0.016387975081527003 > ./result_8chains/node424_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_0 -p 93 -st none -pt topic424_0_0 -u 0.026106401913253585 > ./result_8chains/node424_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_0 -p 277 -st none -pt topic424_1_0 -u 0.005144179092034629 > ./result_8chains/node424_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_0 -p 474 -st none -pt topic424_2_0 -u 0.02715440202860514 > ./result_8chains/node424_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_0 -p 486 -st none -pt topic424_3_0 -u 0.037415608243971055 > ./result_8chains/node424_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_0 -p 554 -st none -pt topic424_4_0 -u 0.02675200019098703 > ./result_8chains/node424_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_0 -p 768 -st none -pt topic424_5_0 -u 0.021133656314812815 > ./result_8chains/node424_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_0 -p 886 -st none -pt topic424_6_0 -u 0.035417385154920086 > ./result_8chains/node424_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_0 -p 902 -st none -pt topic424_7_0 -u 0.0011195006746717064 > ./result_8chains/node424_7_0.txt &
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
    "./result_8chains/node424_0_0.txt 90"
    "./result_8chains/node424_0_2.txt 90"
    "./result_8chains/node424_1_0.txt 89"
    "./result_8chains/node424_1_2.txt 89"
    "./result_8chains/node424_2_0.txt 88"
    "./result_8chains/node424_2_2.txt 88"
    "./result_8chains/node424_3_0.txt 87"
    "./result_8chains/node424_3_2.txt 87"
    "./result_8chains/node424_4_0.txt 86"
    "./result_8chains/node424_4_2.txt 86"
    "./result_8chains/node424_5_0.txt 85"
    "./result_8chains/node424_5_2.txt 85"
    "./result_8chains/node424_6_0.txt 84"
    "./result_8chains/node424_6_2.txt 84"
    "./result_8chains/node424_7_0.txt 83"
    "./result_8chains/node424_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
