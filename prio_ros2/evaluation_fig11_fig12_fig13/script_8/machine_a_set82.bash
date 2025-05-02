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
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_2 -p 83 -st topic82_0_1 -pt None -u 0.04183666589518814 > ./result_8chains/node82_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_2 -p 122 -st topic82_1_1 -pt None -u 0.014202048716529803 > ./result_8chains/node82_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_2 -p 239 -st topic82_2_1 -pt None -u 0.008386605940508607 > ./result_8chains/node82_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_2 -p 411 -st topic82_3_1 -pt None -u 0.021913829370333315 > ./result_8chains/node82_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_2 -p 682 -st topic82_4_1 -pt None -u 0.019696560229045118 > ./result_8chains/node82_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_2 -p 894 -st topic82_5_1 -pt None -u 0.008610604548861006 > ./result_8chains/node82_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_2 -p 938 -st topic82_6_1 -pt None -u 0.0009156262136400389 > ./result_8chains/node82_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_2 -p 964 -st topic82_7_1 -pt None -u 0.009972470948062865 > ./result_8chains/node82_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_0 -p 83 -st none -pt topic82_0_0 -u 0.030241884400415253 > ./result_8chains/node82_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_0 -p 122 -st none -pt topic82_1_0 -u 0.06193550577283835 > ./result_8chains/node82_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_0 -p 239 -st none -pt topic82_2_0 -u 0.05314299327872468 > ./result_8chains/node82_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_0 -p 411 -st none -pt topic82_3_0 -u 0.041994778520167364 > ./result_8chains/node82_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_0 -p 682 -st none -pt topic82_4_0 -u 0.016707614451488467 > ./result_8chains/node82_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_0 -p 894 -st none -pt topic82_5_0 -u 0.019781607413074512 > ./result_8chains/node82_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_0 -p 938 -st none -pt topic82_6_0 -u 0.02760425093458712 > ./result_8chains/node82_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_0 -p 964 -st none -pt topic82_7_0 -u 0.01306136536141661 > ./result_8chains/node82_7_0.txt &
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
    "./result_8chains/node82_0_0.txt 90"
    "./result_8chains/node82_0_2.txt 90"
    "./result_8chains/node82_1_0.txt 89"
    "./result_8chains/node82_1_2.txt 89"
    "./result_8chains/node82_2_0.txt 88"
    "./result_8chains/node82_2_2.txt 88"
    "./result_8chains/node82_3_0.txt 87"
    "./result_8chains/node82_3_2.txt 87"
    "./result_8chains/node82_4_0.txt 86"
    "./result_8chains/node82_4_2.txt 86"
    "./result_8chains/node82_5_0.txt 85"
    "./result_8chains/node82_5_2.txt 85"
    "./result_8chains/node82_6_0.txt 84"
    "./result_8chains/node82_6_2.txt 84"
    "./result_8chains/node82_7_0.txt 83"
    "./result_8chains/node82_7_2.txt 83"
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
