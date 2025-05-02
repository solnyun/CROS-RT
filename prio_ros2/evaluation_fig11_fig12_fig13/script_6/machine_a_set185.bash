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
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_2 -p 222 -st topic185_0_1 -pt None -u 0.05596134787003926 > ./result_6chains/node185_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_2 -p 327 -st topic185_1_1 -pt None -u 0.06309766864372118 > ./result_6chains/node185_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_2 -p 370 -st topic185_2_1 -pt None -u 0.0335654615586293 > ./result_6chains/node185_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_2 -p 515 -st topic185_3_1 -pt None -u 0.01129476697868563 > ./result_6chains/node185_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_2 -p 700 -st topic185_4_1 -pt None -u 0.0004885678240090507 > ./result_6chains/node185_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_2 -p 955 -st topic185_5_1 -pt None -u 0.034629458879982124 > ./result_6chains/node185_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_0 -p 222 -st none -pt topic185_0_0 -u 0.08780957270782153 > ./result_6chains/node185_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_0 -p 327 -st none -pt topic185_1_0 -u 0.004373371638845935 > ./result_6chains/node185_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_0 -p 370 -st none -pt topic185_2_0 -u 0.01475760886420846 > ./result_6chains/node185_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_0 -p 515 -st none -pt topic185_3_0 -u 0.06002047431124355 > ./result_6chains/node185_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_0 -p 700 -st none -pt topic185_4_0 -u 0.012275884403892295 > ./result_6chains/node185_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_0 -p 955 -st none -pt topic185_5_0 -u 0.008271329759514334 > ./result_6chains/node185_5_0.txt &
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
    "./result_6chains/node185_0_0.txt 90"
    "./result_6chains/node185_0_2.txt 90"
    "./result_6chains/node185_1_0.txt 89"
    "./result_6chains/node185_1_2.txt 89"
    "./result_6chains/node185_2_0.txt 88"
    "./result_6chains/node185_2_2.txt 88"
    "./result_6chains/node185_3_0.txt 87"
    "./result_6chains/node185_3_2.txt 87"
    "./result_6chains/node185_4_0.txt 86"
    "./result_6chains/node185_4_2.txt 86"
    "./result_6chains/node185_5_0.txt 85"
    "./result_6chains/node185_5_2.txt 85"
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
