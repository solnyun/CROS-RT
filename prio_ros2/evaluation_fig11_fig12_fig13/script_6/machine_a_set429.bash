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
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_2 -p 205 -st topic429_0_1 -pt None -u 0.024470937464738662 > ./result_6chains/node429_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_2 -p 228 -st topic429_1_1 -pt None -u 0.0003096209514095172 > ./result_6chains/node429_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_2 -p 280 -st topic429_2_1 -pt None -u 0.0748751909394697 > ./result_6chains/node429_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_2 -p 530 -st topic429_3_1 -pt None -u 0.017295397198809292 > ./result_6chains/node429_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_2 -p 566 -st topic429_4_1 -pt None -u 0.06404058414225748 > ./result_6chains/node429_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_2 -p 787 -st topic429_5_1 -pt None -u 0.021409548492975206 > ./result_6chains/node429_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_0 -p 205 -st none -pt topic429_0_0 -u 0.03943302667300824 > ./result_6chains/node429_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_0 -p 228 -st none -pt topic429_1_0 -u 0.0017309849418066237 > ./result_6chains/node429_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_0 -p 280 -st none -pt topic429_2_0 -u 0.0037145341538709076 > ./result_6chains/node429_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_0 -p 530 -st none -pt topic429_3_0 -u 0.005708643013756398 > ./result_6chains/node429_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_0 -p 566 -st none -pt topic429_4_0 -u 0.010437041603805292 > ./result_6chains/node429_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_0 -p 787 -st none -pt topic429_5_0 -u 0.032974229203357255 > ./result_6chains/node429_5_0.txt &
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
    "./result_6chains/node429_0_0.txt 90"
    "./result_6chains/node429_0_2.txt 90"
    "./result_6chains/node429_1_0.txt 89"
    "./result_6chains/node429_1_2.txt 89"
    "./result_6chains/node429_2_0.txt 88"
    "./result_6chains/node429_2_2.txt 88"
    "./result_6chains/node429_3_0.txt 87"
    "./result_6chains/node429_3_2.txt 87"
    "./result_6chains/node429_4_0.txt 86"
    "./result_6chains/node429_4_2.txt 86"
    "./result_6chains/node429_5_0.txt 85"
    "./result_6chains/node429_5_2.txt 85"
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
