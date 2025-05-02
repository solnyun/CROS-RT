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
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_2 -p 117 -st topic286_0_1 -pt None -u 0.01668406786452936 > ./result_10chains/node286_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_2 -p 172 -st topic286_1_1 -pt None -u 0.015868114432560032 > ./result_10chains/node286_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_2 -p 348 -st topic286_2_1 -pt None -u 0.00990796987525766 > ./result_10chains/node286_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_2 -p 620 -st topic286_3_1 -pt None -u 0.011166937412076527 > ./result_10chains/node286_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_2 -p 695 -st topic286_4_1 -pt None -u 0.00013346223586363504 > ./result_10chains/node286_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_2 -p 884 -st topic286_5_1 -pt None -u 0.00015516551846206372 > ./result_10chains/node286_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_6_2 -p 897 -st topic286_6_1 -pt None -u 0.0013240762747322998 > ./result_10chains/node286_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_7_2 -p 955 -st topic286_7_1 -pt None -u 0.006420632218973529 > ./result_10chains/node286_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_8_2 -p 977 -st topic286_8_1 -pt None -u 0.05595746082160462 > ./result_10chains/node286_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_9_2 -p 986 -st topic286_9_1 -pt None -u 7.909306038534459e-05 > ./result_10chains/node286_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_0 -p 117 -st none -pt topic286_0_0 -u 0.008822243549107822 > ./result_10chains/node286_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_0 -p 172 -st none -pt topic286_1_0 -u 0.014908568361361174 > ./result_10chains/node286_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_0 -p 348 -st none -pt topic286_2_0 -u 0.06405231280741203 > ./result_10chains/node286_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_0 -p 620 -st none -pt topic286_3_0 -u 0.0071335184172315325 > ./result_10chains/node286_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_0 -p 695 -st none -pt topic286_4_0 -u 0.019920656660770697 > ./result_10chains/node286_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_0 -p 884 -st none -pt topic286_5_0 -u 0.014700771840283067 > ./result_10chains/node286_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_6_0 -p 897 -st none -pt topic286_6_0 -u 0.0043886479858088745 > ./result_10chains/node286_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_7_0 -p 955 -st none -pt topic286_7_0 -u 0.032624404534666473 > ./result_10chains/node286_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_8_0 -p 977 -st none -pt topic286_8_0 -u 0.010417749090223055 > ./result_10chains/node286_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_9_0 -p 986 -st none -pt topic286_9_0 -u 0.011891513556549368 > ./result_10chains/node286_9_0.txt &
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
    "./result_10chains/node286_0_0.txt 90"
    "./result_10chains/node286_0_2.txt 90"
    "./result_10chains/node286_1_0.txt 89"
    "./result_10chains/node286_1_2.txt 89"
    "./result_10chains/node286_2_0.txt 88"
    "./result_10chains/node286_2_2.txt 88"
    "./result_10chains/node286_3_0.txt 87"
    "./result_10chains/node286_3_2.txt 87"
    "./result_10chains/node286_4_0.txt 86"
    "./result_10chains/node286_4_2.txt 86"
    "./result_10chains/node286_5_0.txt 85"
    "./result_10chains/node286_5_2.txt 85"
    "./result_10chains/node286_6_0.txt 84"
    "./result_10chains/node286_6_2.txt 84"
    "./result_10chains/node286_7_0.txt 83"
    "./result_10chains/node286_7_2.txt 83"
    "./result_10chains/node286_8_0.txt 82"
    "./result_10chains/node286_8_2.txt 82"
    "./result_10chains/node286_9_0.txt 81"
    "./result_10chains/node286_9_2.txt 81"
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
