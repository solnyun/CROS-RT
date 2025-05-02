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
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_2 -p 64 -st topic271_0_1 -pt None -u 0.0006220587016768087 > ./result_10chains/node271_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_2 -p 85 -st topic271_1_1 -pt None -u 0.009617490073102142 > ./result_10chains/node271_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_2 -p 95 -st topic271_2_1 -pt None -u 0.03095545960780982 > ./result_10chains/node271_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_2 -p 206 -st topic271_3_1 -pt None -u 0.0016802900251563502 > ./result_10chains/node271_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_2 -p 369 -st topic271_4_1 -pt None -u 0.012436921639572995 > ./result_10chains/node271_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_2 -p 448 -st topic271_5_1 -pt None -u 0.026457938493606337 > ./result_10chains/node271_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_2 -p 540 -st topic271_6_1 -pt None -u 0.0002076170008102063 > ./result_10chains/node271_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_2 -p 716 -st topic271_7_1 -pt None -u 0.004423046752722176 > ./result_10chains/node271_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_8_2 -p 764 -st topic271_8_1 -pt None -u 0.003968512658683518 > ./result_10chains/node271_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_9_2 -p 905 -st topic271_9_1 -pt None -u 0.025814795491657307 > ./result_10chains/node271_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_0 -p 64 -st none -pt topic271_0_0 -u 0.010623902424959974 > ./result_10chains/node271_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_0 -p 85 -st none -pt topic271_1_0 -u 0.029420275339626933 > ./result_10chains/node271_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_0 -p 95 -st none -pt topic271_2_0 -u 0.0017791221236863053 > ./result_10chains/node271_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_0 -p 206 -st none -pt topic271_3_0 -u 0.00541465679615144 > ./result_10chains/node271_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_0 -p 369 -st none -pt topic271_4_0 -u 0.016918615108888146 > ./result_10chains/node271_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_0 -p 448 -st none -pt topic271_5_0 -u 0.010236023062471455 > ./result_10chains/node271_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_0 -p 540 -st none -pt topic271_6_0 -u 0.04657845351892098 > ./result_10chains/node271_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_0 -p 716 -st none -pt topic271_7_0 -u 0.009769114285455516 > ./result_10chains/node271_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_8_0 -p 764 -st none -pt topic271_8_0 -u 0.011136675923453479 > ./result_10chains/node271_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_9_0 -p 905 -st none -pt topic271_9_0 -u 0.0035446471989135364 > ./result_10chains/node271_9_0.txt &
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
    "./result_10chains/node271_0_0.txt 90"
    "./result_10chains/node271_0_2.txt 90"
    "./result_10chains/node271_1_0.txt 89"
    "./result_10chains/node271_1_2.txt 89"
    "./result_10chains/node271_2_0.txt 88"
    "./result_10chains/node271_2_2.txt 88"
    "./result_10chains/node271_3_0.txt 87"
    "./result_10chains/node271_3_2.txt 87"
    "./result_10chains/node271_4_0.txt 86"
    "./result_10chains/node271_4_2.txt 86"
    "./result_10chains/node271_5_0.txt 85"
    "./result_10chains/node271_5_2.txt 85"
    "./result_10chains/node271_6_0.txt 84"
    "./result_10chains/node271_6_2.txt 84"
    "./result_10chains/node271_7_0.txt 83"
    "./result_10chains/node271_7_2.txt 83"
    "./result_10chains/node271_8_0.txt 82"
    "./result_10chains/node271_8_2.txt 82"
    "./result_10chains/node271_9_0.txt 81"
    "./result_10chains/node271_9_2.txt 81"
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
