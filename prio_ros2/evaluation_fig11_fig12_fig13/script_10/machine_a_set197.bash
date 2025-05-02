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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_2 -p 77 -st topic197_0_1 -pt None -u 0.042587379816444004 > ./result_10chains/node197_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_2 -p 166 -st topic197_1_1 -pt None -u 0.031253360170554356 > ./result_10chains/node197_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_2 -p 184 -st topic197_2_1 -pt None -u 0.0003556717984911084 > ./result_10chains/node197_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_2 -p 253 -st topic197_3_1 -pt None -u 0.02591558972660865 > ./result_10chains/node197_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_2 -p 267 -st topic197_4_1 -pt None -u 0.003669590635990927 > ./result_10chains/node197_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_2 -p 303 -st topic197_5_1 -pt None -u 0.009261374762619567 > ./result_10chains/node197_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_2 -p 454 -st topic197_6_1 -pt None -u 0.007571740013446265 > ./result_10chains/node197_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_2 -p 551 -st topic197_7_1 -pt None -u 0.0182980592662067 > ./result_10chains/node197_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_8_2 -p 772 -st topic197_8_1 -pt None -u 0.03585473767770182 > ./result_10chains/node197_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_9_2 -p 951 -st topic197_9_1 -pt None -u 0.011765975938632635 > ./result_10chains/node197_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_0 -p 77 -st none -pt topic197_0_0 -u 0.07050226005509708 > ./result_10chains/node197_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_0 -p 166 -st none -pt topic197_1_0 -u 0.018757048661744602 > ./result_10chains/node197_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_0 -p 184 -st none -pt topic197_2_0 -u 0.008240540792606 > ./result_10chains/node197_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_0 -p 253 -st none -pt topic197_3_0 -u 0.014463097122440982 > ./result_10chains/node197_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_0 -p 267 -st none -pt topic197_4_0 -u 0.04901696293430119 > ./result_10chains/node197_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_0 -p 303 -st none -pt topic197_5_0 -u 0.0011333196555789182 > ./result_10chains/node197_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_0 -p 454 -st none -pt topic197_6_0 -u 0.008671030487223064 > ./result_10chains/node197_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_0 -p 551 -st none -pt topic197_7_0 -u 0.024015150456250828 > ./result_10chains/node197_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_8_0 -p 772 -st none -pt topic197_8_0 -u 0.005951018718987372 > ./result_10chains/node197_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_9_0 -p 951 -st none -pt topic197_9_0 -u 0.0016787369430473903 > ./result_10chains/node197_9_0.txt &
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
    "./result_10chains/node197_0_0.txt 90"
    "./result_10chains/node197_0_2.txt 90"
    "./result_10chains/node197_1_0.txt 89"
    "./result_10chains/node197_1_2.txt 89"
    "./result_10chains/node197_2_0.txt 88"
    "./result_10chains/node197_2_2.txt 88"
    "./result_10chains/node197_3_0.txt 87"
    "./result_10chains/node197_3_2.txt 87"
    "./result_10chains/node197_4_0.txt 86"
    "./result_10chains/node197_4_2.txt 86"
    "./result_10chains/node197_5_0.txt 85"
    "./result_10chains/node197_5_2.txt 85"
    "./result_10chains/node197_6_0.txt 84"
    "./result_10chains/node197_6_2.txt 84"
    "./result_10chains/node197_7_0.txt 83"
    "./result_10chains/node197_7_2.txt 83"
    "./result_10chains/node197_8_0.txt 82"
    "./result_10chains/node197_8_2.txt 82"
    "./result_10chains/node197_9_0.txt 81"
    "./result_10chains/node197_9_2.txt 81"
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
