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
ros2 run evaluation_3_randomdag uunifast_node -n node299_0_2 -p 97 -st topic299_0_1 -pt None -u 0.013537090404644014 > ./result_8chains/node299_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_1_2 -p 142 -st topic299_1_1 -pt None -u 0.03125271906533561 > ./result_8chains/node299_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_2_2 -p 412 -st topic299_2_1 -pt None -u 0.020671714986965628 > ./result_8chains/node299_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_3_2 -p 418 -st topic299_3_1 -pt None -u 0.06261710773674495 > ./result_8chains/node299_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_4_2 -p 562 -st topic299_4_1 -pt None -u 0.02982319712684879 > ./result_8chains/node299_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_5_2 -p 753 -st topic299_5_1 -pt None -u 0.01765234842634525 > ./result_8chains/node299_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_6_2 -p 894 -st topic299_6_1 -pt None -u 0.009232438409955624 > ./result_8chains/node299_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_7_2 -p 986 -st topic299_7_1 -pt None -u 0.014085633400684984 > ./result_8chains/node299_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_0_0 -p 97 -st none -pt topic299_0_0 -u 0.009163820925655153 > ./result_8chains/node299_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_1_0 -p 142 -st none -pt topic299_1_0 -u 0.021771340139138284 > ./result_8chains/node299_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_2_0 -p 412 -st none -pt topic299_2_0 -u 0.010886033587053534 > ./result_8chains/node299_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_3_0 -p 418 -st none -pt topic299_3_0 -u 0.07461586717473995 > ./result_8chains/node299_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_4_0 -p 562 -st none -pt topic299_4_0 -u 0.011718060850888834 > ./result_8chains/node299_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_5_0 -p 753 -st none -pt topic299_5_0 -u 0.017905059262959058 > ./result_8chains/node299_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_6_0 -p 894 -st none -pt topic299_6_0 -u 0.026604752841786337 > ./result_8chains/node299_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_7_0 -p 986 -st none -pt topic299_7_0 -u 0.0033106654015116477 > ./result_8chains/node299_7_0.txt &
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
    "./result_8chains/node299_0_0.txt 90"
    "./result_8chains/node299_0_2.txt 90"
    "./result_8chains/node299_1_0.txt 89"
    "./result_8chains/node299_1_2.txt 89"
    "./result_8chains/node299_2_0.txt 88"
    "./result_8chains/node299_2_2.txt 88"
    "./result_8chains/node299_3_0.txt 87"
    "./result_8chains/node299_3_2.txt 87"
    "./result_8chains/node299_4_0.txt 86"
    "./result_8chains/node299_4_2.txt 86"
    "./result_8chains/node299_5_0.txt 85"
    "./result_8chains/node299_5_2.txt 85"
    "./result_8chains/node299_6_0.txt 84"
    "./result_8chains/node299_6_2.txt 84"
    "./result_8chains/node299_7_0.txt 83"
    "./result_8chains/node299_7_2.txt 83"
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
