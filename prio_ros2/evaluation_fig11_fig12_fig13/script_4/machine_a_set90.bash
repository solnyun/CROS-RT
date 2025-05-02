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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_2 -p 262 -st topic90_0_1 -pt None -u 0.06108624705475946 > ./result_4chains/node90_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_2 -p 342 -st topic90_1_1 -pt None -u 0.013691326504534335 > ./result_4chains/node90_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_2 -p 679 -st topic90_2_1 -pt None -u 0.05154475265418443 > ./result_4chains/node90_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_2 -p 808 -st topic90_3_1 -pt None -u 0.020761150139566736 > ./result_4chains/node90_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_0 -p 262 -st none -pt topic90_0_0 -u 0.05822622631236457 > ./result_4chains/node90_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_0 -p 342 -st none -pt topic90_1_0 -u 0.07437712495796844 > ./result_4chains/node90_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_0 -p 679 -st none -pt topic90_2_0 -u 0.01791115171225674 > ./result_4chains/node90_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_0 -p 808 -st none -pt topic90_3_0 -u 0.00015000062428119354 > ./result_4chains/node90_3_0.txt &
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
    "./result_4chains/node90_0_0.txt 90"
    "./result_4chains/node90_0_2.txt 90"
    "./result_4chains/node90_1_0.txt 89"
    "./result_4chains/node90_1_2.txt 89"
    "./result_4chains/node90_2_0.txt 88"
    "./result_4chains/node90_2_2.txt 88"
    "./result_4chains/node90_3_0.txt 87"
    "./result_4chains/node90_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
