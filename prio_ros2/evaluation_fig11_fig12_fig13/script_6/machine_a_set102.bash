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
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_2 -p 25 -st topic102_0_1 -pt None -u 0.009332128380145632 > ./result_6chains/node102_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_2 -p 29 -st topic102_1_1 -pt None -u 0.05113970529361628 > ./result_6chains/node102_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_2 -p 92 -st topic102_2_1 -pt None -u 0.01899804310183001 > ./result_6chains/node102_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_2 -p 97 -st topic102_3_1 -pt None -u 0.08191005071799853 > ./result_6chains/node102_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_2 -p 361 -st topic102_4_1 -pt None -u 0.00018952596336785366 > ./result_6chains/node102_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_2 -p 449 -st topic102_5_1 -pt None -u 0.007221720741672494 > ./result_6chains/node102_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_0 -p 25 -st none -pt topic102_0_0 -u 0.018218617203960952 > ./result_6chains/node102_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_0 -p 29 -st none -pt topic102_1_0 -u 0.05641405504879621 > ./result_6chains/node102_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_0 -p 92 -st none -pt topic102_2_0 -u 0.007549144895849069 > ./result_6chains/node102_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_0 -p 97 -st none -pt topic102_3_0 -u 0.03068110324571488 > ./result_6chains/node102_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_0 -p 361 -st none -pt topic102_4_0 -u 0.022996934425817406 > ./result_6chains/node102_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_0 -p 449 -st none -pt topic102_5_0 -u 0.007813081657278176 > ./result_6chains/node102_5_0.txt &
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
    "./result_6chains/node102_0_0.txt 90"
    "./result_6chains/node102_0_2.txt 90"
    "./result_6chains/node102_1_0.txt 89"
    "./result_6chains/node102_1_2.txt 89"
    "./result_6chains/node102_2_0.txt 88"
    "./result_6chains/node102_2_2.txt 88"
    "./result_6chains/node102_3_0.txt 87"
    "./result_6chains/node102_3_2.txt 87"
    "./result_6chains/node102_4_0.txt 86"
    "./result_6chains/node102_4_2.txt 86"
    "./result_6chains/node102_5_0.txt 85"
    "./result_6chains/node102_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
