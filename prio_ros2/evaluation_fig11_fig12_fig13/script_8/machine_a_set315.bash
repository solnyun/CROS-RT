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
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_2 -p 15 -st topic315_0_1 -pt None -u 0.018594706344806533 > ./result_8chains/node315_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_2 -p 27 -st topic315_1_1 -pt None -u 0.010573386710736377 > ./result_8chains/node315_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_2 -p 183 -st topic315_2_1 -pt None -u 0.024495269844373446 > ./result_8chains/node315_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_2 -p 237 -st topic315_3_1 -pt None -u 0.04100298831010474 > ./result_8chains/node315_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_2 -p 637 -st topic315_4_1 -pt None -u 0.00421211419399195 > ./result_8chains/node315_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_2 -p 735 -st topic315_5_1 -pt None -u 0.016603518863389774 > ./result_8chains/node315_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_6_2 -p 834 -st topic315_6_1 -pt None -u 0.0168251635083114 > ./result_8chains/node315_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_7_2 -p 953 -st topic315_7_1 -pt None -u 0.018144077575729344 > ./result_8chains/node315_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_0 -p 15 -st none -pt topic315_0_0 -u 0.026615272202459517 > ./result_8chains/node315_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_0 -p 27 -st none -pt topic315_1_0 -u 0.02896446763276378 > ./result_8chains/node315_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_0 -p 183 -st none -pt topic315_2_0 -u 0.05869790819053339 > ./result_8chains/node315_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_0 -p 237 -st none -pt topic315_3_0 -u 0.013450062991253453 > ./result_8chains/node315_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_0 -p 637 -st none -pt topic315_4_0 -u 0.01670023030982301 > ./result_8chains/node315_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_0 -p 735 -st none -pt topic315_5_0 -u 0.02756153287104035 > ./result_8chains/node315_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_6_0 -p 834 -st none -pt topic315_6_0 -u 0.022160560671799383 > ./result_8chains/node315_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_7_0 -p 953 -st none -pt topic315_7_0 -u 0.007467820224035103 > ./result_8chains/node315_7_0.txt &
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
    "./result_8chains/node315_0_0.txt 90"
    "./result_8chains/node315_0_2.txt 90"
    "./result_8chains/node315_1_0.txt 89"
    "./result_8chains/node315_1_2.txt 89"
    "./result_8chains/node315_2_0.txt 88"
    "./result_8chains/node315_2_2.txt 88"
    "./result_8chains/node315_3_0.txt 87"
    "./result_8chains/node315_3_2.txt 87"
    "./result_8chains/node315_4_0.txt 86"
    "./result_8chains/node315_4_2.txt 86"
    "./result_8chains/node315_5_0.txt 85"
    "./result_8chains/node315_5_2.txt 85"
    "./result_8chains/node315_6_0.txt 84"
    "./result_8chains/node315_6_2.txt 84"
    "./result_8chains/node315_7_0.txt 83"
    "./result_8chains/node315_7_2.txt 83"
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
