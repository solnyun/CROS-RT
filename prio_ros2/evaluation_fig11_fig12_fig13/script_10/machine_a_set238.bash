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
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_2 -p 183 -st topic238_0_1 -pt None -u 0.0006971038465287682 > ./result_10chains/node238_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_2 -p 326 -st topic238_1_1 -pt None -u 0.02187272964352993 > ./result_10chains/node238_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_2 -p 397 -st topic238_2_1 -pt None -u 0.0015674795499129868 > ./result_10chains/node238_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_2 -p 455 -st topic238_3_1 -pt None -u 0.03524748009883505 > ./result_10chains/node238_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_2 -p 640 -st topic238_4_1 -pt None -u 0.008501387333520904 > ./result_10chains/node238_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_2 -p 653 -st topic238_5_1 -pt None -u 0.04296645476294217 > ./result_10chains/node238_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_2 -p 739 -st topic238_6_1 -pt None -u 0.023769532608526045 > ./result_10chains/node238_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_2 -p 753 -st topic238_7_1 -pt None -u 0.011742529333603369 > ./result_10chains/node238_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_8_2 -p 919 -st topic238_8_1 -pt None -u 0.0007920265158747053 > ./result_10chains/node238_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_9_2 -p 969 -st topic238_9_1 -pt None -u 0.01420280175102257 > ./result_10chains/node238_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_0 -p 183 -st none -pt topic238_0_0 -u 0.0006780295817603865 > ./result_10chains/node238_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_0 -p 326 -st none -pt topic238_1_0 -u 0.0034520474749099583 > ./result_10chains/node238_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_0 -p 397 -st none -pt topic238_2_0 -u 0.0028923830092390523 > ./result_10chains/node238_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_0 -p 455 -st none -pt topic238_3_0 -u 0.00844475472923406 > ./result_10chains/node238_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_0 -p 640 -st none -pt topic238_4_0 -u 0.011007083117711813 > ./result_10chains/node238_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_0 -p 653 -st none -pt topic238_5_0 -u 0.015116225208397116 > ./result_10chains/node238_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_0 -p 739 -st none -pt topic238_6_0 -u 0.00027288216371901264 > ./result_10chains/node238_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_0 -p 753 -st none -pt topic238_7_0 -u 0.011634288861455094 > ./result_10chains/node238_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_8_0 -p 919 -st none -pt topic238_8_0 -u 0.026092922642124178 > ./result_10chains/node238_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node238_9_0 -p 969 -st none -pt topic238_9_0 -u 0.006187845314810883 > ./result_10chains/node238_9_0.txt &
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
    "./result_10chains/node238_0_0.txt 90"
    "./result_10chains/node238_0_2.txt 90"
    "./result_10chains/node238_1_0.txt 89"
    "./result_10chains/node238_1_2.txt 89"
    "./result_10chains/node238_2_0.txt 88"
    "./result_10chains/node238_2_2.txt 88"
    "./result_10chains/node238_3_0.txt 87"
    "./result_10chains/node238_3_2.txt 87"
    "./result_10chains/node238_4_0.txt 86"
    "./result_10chains/node238_4_2.txt 86"
    "./result_10chains/node238_5_0.txt 85"
    "./result_10chains/node238_5_2.txt 85"
    "./result_10chains/node238_6_0.txt 84"
    "./result_10chains/node238_6_2.txt 84"
    "./result_10chains/node238_7_0.txt 83"
    "./result_10chains/node238_7_2.txt 83"
    "./result_10chains/node238_8_0.txt 82"
    "./result_10chains/node238_8_2.txt 82"
    "./result_10chains/node238_9_0.txt 81"
    "./result_10chains/node238_9_2.txt 81"
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
