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
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_2 -p 307 -st topic83_0_1 -pt None -u 0.034039317541062764 > ./result_6chains/node83_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_2 -p 544 -st topic83_1_1 -pt None -u 0.006582560329503995 > ./result_6chains/node83_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_2 -p 574 -st topic83_2_1 -pt None -u 0.0018918059269470988 > ./result_6chains/node83_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_2 -p 771 -st topic83_3_1 -pt None -u 0.038597690925035594 > ./result_6chains/node83_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_2 -p 972 -st topic83_4_1 -pt None -u 0.0694948141965642 > ./result_6chains/node83_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_2 -p 995 -st topic83_5_1 -pt None -u 0.007214909461833976 > ./result_6chains/node83_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_0 -p 307 -st none -pt topic83_0_0 -u 0.005719056225340413 > ./result_6chains/node83_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_0 -p 544 -st none -pt topic83_1_0 -u 0.020161169180529515 > ./result_6chains/node83_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_0 -p 574 -st none -pt topic83_2_0 -u 0.01865096948492656 > ./result_6chains/node83_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_0 -p 771 -st none -pt topic83_3_0 -u 0.06191101030547852 > ./result_6chains/node83_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_0 -p 972 -st none -pt topic83_4_0 -u 0.001893899215227396 > ./result_6chains/node83_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_0 -p 995 -st none -pt topic83_5_0 -u 0.04098153331374625 > ./result_6chains/node83_5_0.txt &
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
    "./result_6chains/node83_0_0.txt 90"
    "./result_6chains/node83_0_2.txt 90"
    "./result_6chains/node83_1_0.txt 89"
    "./result_6chains/node83_1_2.txt 89"
    "./result_6chains/node83_2_0.txt 88"
    "./result_6chains/node83_2_2.txt 88"
    "./result_6chains/node83_3_0.txt 87"
    "./result_6chains/node83_3_2.txt 87"
    "./result_6chains/node83_4_0.txt 86"
    "./result_6chains/node83_4_2.txt 86"
    "./result_6chains/node83_5_0.txt 85"
    "./result_6chains/node83_5_2.txt 85"
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
