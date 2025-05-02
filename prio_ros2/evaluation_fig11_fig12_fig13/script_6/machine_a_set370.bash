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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_2 -p 167 -st topic370_0_1 -pt None -u 0.0033288315799471224 > ./result_6chains/node370_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_2 -p 254 -st topic370_1_1 -pt None -u 0.12259407484196783 > ./result_6chains/node370_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_2 -p 353 -st topic370_2_1 -pt None -u 0.01913322895976799 > ./result_6chains/node370_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_2 -p 482 -st topic370_3_1 -pt None -u 0.008591674488522508 > ./result_6chains/node370_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_2 -p 704 -st topic370_4_1 -pt None -u 0.008227748160555562 > ./result_6chains/node370_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_2 -p 930 -st topic370_5_1 -pt None -u 0.019400180404876947 > ./result_6chains/node370_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_0 -p 167 -st none -pt topic370_0_0 -u 0.030672515982117232 > ./result_6chains/node370_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_0 -p 254 -st none -pt topic370_1_0 -u 0.014606066946012852 > ./result_6chains/node370_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_0 -p 353 -st none -pt topic370_2_0 -u 0.04364516560837689 > ./result_6chains/node370_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_0 -p 482 -st none -pt topic370_3_0 -u 0.049810747612296424 > ./result_6chains/node370_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_0 -p 704 -st none -pt topic370_4_0 -u 0.008476312081550419 > ./result_6chains/node370_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_0 -p 930 -st none -pt topic370_5_0 -u 0.039611644107654075 > ./result_6chains/node370_5_0.txt &
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
    "./result_6chains/node370_0_0.txt 90"
    "./result_6chains/node370_0_2.txt 90"
    "./result_6chains/node370_1_0.txt 89"
    "./result_6chains/node370_1_2.txt 89"
    "./result_6chains/node370_2_0.txt 88"
    "./result_6chains/node370_2_2.txt 88"
    "./result_6chains/node370_3_0.txt 87"
    "./result_6chains/node370_3_2.txt 87"
    "./result_6chains/node370_4_0.txt 86"
    "./result_6chains/node370_4_2.txt 86"
    "./result_6chains/node370_5_0.txt 85"
    "./result_6chains/node370_5_2.txt 85"
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
