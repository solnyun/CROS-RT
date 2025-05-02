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
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_2 -p 115 -st topic93_0_1 -pt None -u 0.017324076398985477 > ./result_6chains/node93_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_2 -p 130 -st topic93_1_1 -pt None -u 0.029339736832145663 > ./result_6chains/node93_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_2 -p 292 -st topic93_2_1 -pt None -u 0.017033780334672843 > ./result_6chains/node93_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_2 -p 322 -st topic93_3_1 -pt None -u 0.055535060766752145 > ./result_6chains/node93_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_2 -p 567 -st topic93_4_1 -pt None -u 0.012478263292665548 > ./result_6chains/node93_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_2 -p 588 -st topic93_5_1 -pt None -u 0.037213738763866896 > ./result_6chains/node93_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_0 -p 115 -st none -pt topic93_0_0 -u 0.1688005907136782 > ./result_6chains/node93_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_0 -p 130 -st none -pt topic93_1_0 -u 0.040173139672587954 > ./result_6chains/node93_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_0 -p 292 -st none -pt topic93_2_0 -u 0.016285718598341936 > ./result_6chains/node93_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_0 -p 322 -st none -pt topic93_3_0 -u 0.008151201117965468 > ./result_6chains/node93_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_0 -p 567 -st none -pt topic93_4_0 -u 0.008119088815170108 > ./result_6chains/node93_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_0 -p 588 -st none -pt topic93_5_0 -u 0.0013497171772001298 > ./result_6chains/node93_5_0.txt &
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
    "./result_6chains/node93_0_0.txt 90"
    "./result_6chains/node93_0_2.txt 90"
    "./result_6chains/node93_1_0.txt 89"
    "./result_6chains/node93_1_2.txt 89"
    "./result_6chains/node93_2_0.txt 88"
    "./result_6chains/node93_2_2.txt 88"
    "./result_6chains/node93_3_0.txt 87"
    "./result_6chains/node93_3_2.txt 87"
    "./result_6chains/node93_4_0.txt 86"
    "./result_6chains/node93_4_2.txt 86"
    "./result_6chains/node93_5_0.txt 85"
    "./result_6chains/node93_5_2.txt 85"
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
