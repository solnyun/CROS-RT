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
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_2 -p 126 -st topic37_0_1 -pt None -u 0.005366874889929485 > ./result_10chains/node37_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_2 -p 364 -st topic37_1_1 -pt None -u 0.003860577304321877 > ./result_10chains/node37_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_2 -p 449 -st topic37_2_1 -pt None -u 0.0015845098380020683 > ./result_10chains/node37_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_2 -p 548 -st topic37_3_1 -pt None -u 0.0010377506084934263 > ./result_10chains/node37_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_2 -p 654 -st topic37_4_1 -pt None -u 0.07927728165398407 > ./result_10chains/node37_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_2 -p 675 -st topic37_5_1 -pt None -u 0.011022862491676721 > ./result_10chains/node37_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_2 -p 699 -st topic37_6_1 -pt None -u 0.007532872755836362 > ./result_10chains/node37_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_2 -p 702 -st topic37_7_1 -pt None -u 0.010880145446468578 > ./result_10chains/node37_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_8_2 -p 729 -st topic37_8_1 -pt None -u 0.015075450353889651 > ./result_10chains/node37_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_9_2 -p 731 -st topic37_9_1 -pt None -u 0.013022177439581154 > ./result_10chains/node37_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_0 -p 126 -st none -pt topic37_0_0 -u 0.018837167354144868 > ./result_10chains/node37_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_0 -p 364 -st none -pt topic37_1_0 -u 0.0005560229660412919 > ./result_10chains/node37_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_0 -p 449 -st none -pt topic37_2_0 -u 0.010299007261030335 > ./result_10chains/node37_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_0 -p 548 -st none -pt topic37_3_0 -u 0.0026269871078025697 > ./result_10chains/node37_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_0 -p 654 -st none -pt topic37_4_0 -u 0.01331577484867974 > ./result_10chains/node37_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_0 -p 675 -st none -pt topic37_5_0 -u 0.0019846214614371305 > ./result_10chains/node37_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_0 -p 699 -st none -pt topic37_6_0 -u 0.019384617177421487 > ./result_10chains/node37_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_0 -p 702 -st none -pt topic37_7_0 -u 0.0821706812444628 > ./result_10chains/node37_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_8_0 -p 729 -st none -pt topic37_8_0 -u 0.003339701974951856 > ./result_10chains/node37_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_9_0 -p 731 -st none -pt topic37_9_0 -u 0.03750587653500694 > ./result_10chains/node37_9_0.txt &
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
    "./result_10chains/node37_0_0.txt 90"
    "./result_10chains/node37_0_2.txt 90"
    "./result_10chains/node37_1_0.txt 89"
    "./result_10chains/node37_1_2.txt 89"
    "./result_10chains/node37_2_0.txt 88"
    "./result_10chains/node37_2_2.txt 88"
    "./result_10chains/node37_3_0.txt 87"
    "./result_10chains/node37_3_2.txt 87"
    "./result_10chains/node37_4_0.txt 86"
    "./result_10chains/node37_4_2.txt 86"
    "./result_10chains/node37_5_0.txt 85"
    "./result_10chains/node37_5_2.txt 85"
    "./result_10chains/node37_6_0.txt 84"
    "./result_10chains/node37_6_2.txt 84"
    "./result_10chains/node37_7_0.txt 83"
    "./result_10chains/node37_7_2.txt 83"
    "./result_10chains/node37_8_0.txt 82"
    "./result_10chains/node37_8_2.txt 82"
    "./result_10chains/node37_9_0.txt 81"
    "./result_10chains/node37_9_2.txt 81"
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
