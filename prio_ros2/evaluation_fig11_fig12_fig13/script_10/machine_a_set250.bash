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
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_2 -p 183 -st topic250_0_1 -pt None -u 0.002397876144771105 > ./result_10chains/node250_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_2 -p 241 -st topic250_1_1 -pt None -u 0.023015368693322102 > ./result_10chains/node250_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_2 -p 299 -st topic250_2_1 -pt None -u 0.006573662101616695 > ./result_10chains/node250_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_2 -p 325 -st topic250_3_1 -pt None -u 0.002955884847877732 > ./result_10chains/node250_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_2 -p 370 -st topic250_4_1 -pt None -u 0.005153953445312887 > ./result_10chains/node250_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_2 -p 445 -st topic250_5_1 -pt None -u 0.028297757406679502 > ./result_10chains/node250_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_6_2 -p 714 -st topic250_6_1 -pt None -u 0.023365659774172626 > ./result_10chains/node250_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_7_2 -p 762 -st topic250_7_1 -pt None -u 0.04299229615570743 > ./result_10chains/node250_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_8_2 -p 780 -st topic250_8_1 -pt None -u 0.017117115840819562 > ./result_10chains/node250_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_9_2 -p 866 -st topic250_9_1 -pt None -u 0.017279082318610108 > ./result_10chains/node250_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_0 -p 183 -st none -pt topic250_0_0 -u 0.028985466517541636 > ./result_10chains/node250_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_0 -p 241 -st none -pt topic250_1_0 -u 0.003951803545045651 > ./result_10chains/node250_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_0 -p 299 -st none -pt topic250_2_0 -u 0.013875295593364645 > ./result_10chains/node250_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_0 -p 325 -st none -pt topic250_3_0 -u 0.01540983844221977 > ./result_10chains/node250_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_0 -p 370 -st none -pt topic250_4_0 -u 0.02824059435522447 > ./result_10chains/node250_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_0 -p 445 -st none -pt topic250_5_0 -u 0.008503464254723037 > ./result_10chains/node250_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_6_0 -p 714 -st none -pt topic250_6_0 -u 0.034985347036105785 > ./result_10chains/node250_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_7_0 -p 762 -st none -pt topic250_7_0 -u 0.00877456040264235 > ./result_10chains/node250_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_8_0 -p 780 -st none -pt topic250_8_0 -u 0.02196686536840249 > ./result_10chains/node250_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_9_0 -p 866 -st none -pt topic250_9_0 -u 0.025761193811487122 > ./result_10chains/node250_9_0.txt &
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
    "./result_10chains/node250_0_0.txt 90"
    "./result_10chains/node250_0_2.txt 90"
    "./result_10chains/node250_1_0.txt 89"
    "./result_10chains/node250_1_2.txt 89"
    "./result_10chains/node250_2_0.txt 88"
    "./result_10chains/node250_2_2.txt 88"
    "./result_10chains/node250_3_0.txt 87"
    "./result_10chains/node250_3_2.txt 87"
    "./result_10chains/node250_4_0.txt 86"
    "./result_10chains/node250_4_2.txt 86"
    "./result_10chains/node250_5_0.txt 85"
    "./result_10chains/node250_5_2.txt 85"
    "./result_10chains/node250_6_0.txt 84"
    "./result_10chains/node250_6_2.txt 84"
    "./result_10chains/node250_7_0.txt 83"
    "./result_10chains/node250_7_2.txt 83"
    "./result_10chains/node250_8_0.txt 82"
    "./result_10chains/node250_8_2.txt 82"
    "./result_10chains/node250_9_0.txt 81"
    "./result_10chains/node250_9_2.txt 81"
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
