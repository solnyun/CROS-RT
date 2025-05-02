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
ros2 run evaluation_3_randomdag uunifast_node -n node164_0_2 -p 24 -st topic164_0_1 -pt None -u 0.054459046211106255 > ./result_10chains/node164_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_1_2 -p 287 -st topic164_1_1 -pt None -u 0.018084385244829082 > ./result_10chains/node164_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_2_2 -p 376 -st topic164_2_1 -pt None -u 0.011856140455765884 > ./result_10chains/node164_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_3_2 -p 486 -st topic164_3_1 -pt None -u 0.006724956733413501 > ./result_10chains/node164_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_4_2 -p 615 -st topic164_4_1 -pt None -u 0.012384942262802512 > ./result_10chains/node164_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_5_2 -p 616 -st topic164_5_1 -pt None -u 0.014941786680619046 > ./result_10chains/node164_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_6_2 -p 754 -st topic164_6_1 -pt None -u 0.05625346236248478 > ./result_10chains/node164_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_7_2 -p 803 -st topic164_7_1 -pt None -u 0.013675345674228435 > ./result_10chains/node164_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_8_2 -p 854 -st topic164_8_1 -pt None -u 0.0011731841250048475 > ./result_10chains/node164_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_9_2 -p 987 -st topic164_9_1 -pt None -u 0.008720091407279825 > ./result_10chains/node164_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_0_0 -p 24 -st none -pt topic164_0_0 -u 0.020137099826597615 > ./result_10chains/node164_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_1_0 -p 287 -st none -pt topic164_1_0 -u 0.0018105048876334018 > ./result_10chains/node164_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_2_0 -p 376 -st none -pt topic164_2_0 -u 0.011548452850163704 > ./result_10chains/node164_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_3_0 -p 486 -st none -pt topic164_3_0 -u 0.06337419970614255 > ./result_10chains/node164_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_4_0 -p 615 -st none -pt topic164_4_0 -u 0.020109098469935527 > ./result_10chains/node164_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_5_0 -p 616 -st none -pt topic164_5_0 -u 0.023075965126987535 > ./result_10chains/node164_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_6_0 -p 754 -st none -pt topic164_6_0 -u 0.005228205095827304 > ./result_10chains/node164_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_7_0 -p 803 -st none -pt topic164_7_0 -u 0.01833128170609693 > ./result_10chains/node164_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_8_0 -p 854 -st none -pt topic164_8_0 -u 0.0006391559166763899 > ./result_10chains/node164_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_9_0 -p 987 -st none -pt topic164_9_0 -u 0.010398914572440887 > ./result_10chains/node164_9_0.txt &
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
    "./result_10chains/node164_0_0.txt 90"
    "./result_10chains/node164_0_2.txt 90"
    "./result_10chains/node164_1_0.txt 89"
    "./result_10chains/node164_1_2.txt 89"
    "./result_10chains/node164_2_0.txt 88"
    "./result_10chains/node164_2_2.txt 88"
    "./result_10chains/node164_3_0.txt 87"
    "./result_10chains/node164_3_2.txt 87"
    "./result_10chains/node164_4_0.txt 86"
    "./result_10chains/node164_4_2.txt 86"
    "./result_10chains/node164_5_0.txt 85"
    "./result_10chains/node164_5_2.txt 85"
    "./result_10chains/node164_6_0.txt 84"
    "./result_10chains/node164_6_2.txt 84"
    "./result_10chains/node164_7_0.txt 83"
    "./result_10chains/node164_7_2.txt 83"
    "./result_10chains/node164_8_0.txt 82"
    "./result_10chains/node164_8_2.txt 82"
    "./result_10chains/node164_9_0.txt 81"
    "./result_10chains/node164_9_2.txt 81"
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
