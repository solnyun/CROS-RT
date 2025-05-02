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
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_2 -p 296 -st topic377_0_1 -pt None -u 0.08565820395254986 > ./result_6chains/node377_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_2 -p 388 -st topic377_1_1 -pt None -u 0.0017065829947594535 > ./result_6chains/node377_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_2 -p 455 -st topic377_2_1 -pt None -u 0.0501663307984522 > ./result_6chains/node377_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_2 -p 696 -st topic377_3_1 -pt None -u 0.031032494848163533 > ./result_6chains/node377_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_2 -p 890 -st topic377_4_1 -pt None -u 0.028754802635530794 > ./result_6chains/node377_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_2 -p 991 -st topic377_5_1 -pt None -u 0.0008508386718645198 > ./result_6chains/node377_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_0 -p 296 -st none -pt topic377_0_0 -u 0.0016370061035959615 > ./result_6chains/node377_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_0 -p 388 -st none -pt topic377_1_0 -u 0.006619501871393596 > ./result_6chains/node377_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_0 -p 455 -st none -pt topic377_2_0 -u 0.04142268244734515 > ./result_6chains/node377_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_0 -p 696 -st none -pt topic377_3_0 -u 0.01036934337083062 > ./result_6chains/node377_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_0 -p 890 -st none -pt topic377_4_0 -u 0.01933346358311372 > ./result_6chains/node377_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_0 -p 991 -st none -pt topic377_5_0 -u 0.013733786088242406 > ./result_6chains/node377_5_0.txt &
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
    "./result_6chains/node377_0_0.txt 90"
    "./result_6chains/node377_0_2.txt 90"
    "./result_6chains/node377_1_0.txt 89"
    "./result_6chains/node377_1_2.txt 89"
    "./result_6chains/node377_2_0.txt 88"
    "./result_6chains/node377_2_2.txt 88"
    "./result_6chains/node377_3_0.txt 87"
    "./result_6chains/node377_3_2.txt 87"
    "./result_6chains/node377_4_0.txt 86"
    "./result_6chains/node377_4_2.txt 86"
    "./result_6chains/node377_5_0.txt 85"
    "./result_6chains/node377_5_2.txt 85"
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
