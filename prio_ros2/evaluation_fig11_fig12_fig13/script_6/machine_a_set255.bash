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
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_2 -p 10 -st topic255_0_1 -pt None -u 0.017182769595962377 > ./result_6chains/node255_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_2 -p 51 -st topic255_1_1 -pt None -u 0.005117657815020771 > ./result_6chains/node255_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_2 -p 307 -st topic255_2_1 -pt None -u 0.014055247709490848 > ./result_6chains/node255_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_2 -p 370 -st topic255_3_1 -pt None -u 0.09647632767403183 > ./result_6chains/node255_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_2 -p 545 -st topic255_4_1 -pt None -u 0.021130135209361564 > ./result_6chains/node255_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_2 -p 965 -st topic255_5_1 -pt None -u 0.02031181958071217 > ./result_6chains/node255_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_0 -p 10 -st none -pt topic255_0_0 -u 0.046832443027071624 > ./result_6chains/node255_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_0 -p 51 -st none -pt topic255_1_0 -u 0.020371819432504268 > ./result_6chains/node255_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_0 -p 307 -st none -pt topic255_2_0 -u 0.008731802760396978 > ./result_6chains/node255_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_0 -p 370 -st none -pt topic255_3_0 -u 0.006903109253776629 > ./result_6chains/node255_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_0 -p 545 -st none -pt topic255_4_0 -u 0.010382540162772735 > ./result_6chains/node255_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_0 -p 965 -st none -pt topic255_5_0 -u 0.011334730629061873 > ./result_6chains/node255_5_0.txt &
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
    "./result_6chains/node255_0_0.txt 90"
    "./result_6chains/node255_0_2.txt 90"
    "./result_6chains/node255_1_0.txt 89"
    "./result_6chains/node255_1_2.txt 89"
    "./result_6chains/node255_2_0.txt 88"
    "./result_6chains/node255_2_2.txt 88"
    "./result_6chains/node255_3_0.txt 87"
    "./result_6chains/node255_3_2.txt 87"
    "./result_6chains/node255_4_0.txt 86"
    "./result_6chains/node255_4_2.txt 86"
    "./result_6chains/node255_5_0.txt 85"
    "./result_6chains/node255_5_2.txt 85"
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
