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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_2 -p 269 -st topic383_0_1 -pt None -u 0.007527875812195828 > ./result_4chains/node383_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_2 -p 322 -st topic383_1_1 -pt None -u 0.024981488370945715 > ./result_4chains/node383_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_2 -p 871 -st topic383_2_1 -pt None -u 0.041374507847112135 > ./result_4chains/node383_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_2 -p 991 -st topic383_3_1 -pt None -u 0.06955448362532514 > ./result_4chains/node383_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_0 -p 269 -st none -pt topic383_0_0 -u 0.024178440010959257 > ./result_4chains/node383_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_0 -p 322 -st none -pt topic383_1_0 -u 0.05728657954627531 > ./result_4chains/node383_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_0 -p 871 -st none -pt topic383_2_0 -u 0.014993935016531013 > ./result_4chains/node383_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_0 -p 991 -st none -pt topic383_3_0 -u 0.015943302204933354 > ./result_4chains/node383_3_0.txt &
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
    "./result_4chains/node383_0_0.txt 90"
    "./result_4chains/node383_0_2.txt 90"
    "./result_4chains/node383_1_0.txt 89"
    "./result_4chains/node383_1_2.txt 89"
    "./result_4chains/node383_2_0.txt 88"
    "./result_4chains/node383_2_2.txt 88"
    "./result_4chains/node383_3_0.txt 87"
    "./result_4chains/node383_3_2.txt 87"
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
