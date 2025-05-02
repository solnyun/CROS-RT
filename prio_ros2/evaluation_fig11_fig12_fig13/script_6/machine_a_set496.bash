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
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_2 -p 12 -st topic496_0_1 -pt None -u 0.04708885518899436 > ./result_6chains/node496_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_2 -p 95 -st topic496_1_1 -pt None -u 0.10808211471243942 > ./result_6chains/node496_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_2 -p 206 -st topic496_2_1 -pt None -u 0.023785640628856436 > ./result_6chains/node496_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_2 -p 303 -st topic496_3_1 -pt None -u 0.00777915411236399 > ./result_6chains/node496_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_2 -p 369 -st topic496_4_1 -pt None -u 0.003925488709218286 > ./result_6chains/node496_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_2 -p 674 -st topic496_5_1 -pt None -u 0.014551909188033387 > ./result_6chains/node496_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_0 -p 12 -st none -pt topic496_0_0 -u 0.006248584202008689 > ./result_6chains/node496_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_0 -p 95 -st none -pt topic496_1_0 -u 0.019922835237105085 > ./result_6chains/node496_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_0 -p 206 -st none -pt topic496_2_0 -u 0.02156209536030171 > ./result_6chains/node496_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_0 -p 303 -st none -pt topic496_3_0 -u 0.012829880994317339 > ./result_6chains/node496_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_0 -p 369 -st none -pt topic496_4_0 -u 0.0202107319320617 > ./result_6chains/node496_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_0 -p 674 -st none -pt topic496_5_0 -u 0.031254153214016714 > ./result_6chains/node496_5_0.txt &
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
    "./result_6chains/node496_0_0.txt 90"
    "./result_6chains/node496_0_2.txt 90"
    "./result_6chains/node496_1_0.txt 89"
    "./result_6chains/node496_1_2.txt 89"
    "./result_6chains/node496_2_0.txt 88"
    "./result_6chains/node496_2_2.txt 88"
    "./result_6chains/node496_3_0.txt 87"
    "./result_6chains/node496_3_2.txt 87"
    "./result_6chains/node496_4_0.txt 86"
    "./result_6chains/node496_4_2.txt 86"
    "./result_6chains/node496_5_0.txt 85"
    "./result_6chains/node496_5_2.txt 85"
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
