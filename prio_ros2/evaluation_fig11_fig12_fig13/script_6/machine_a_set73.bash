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
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_2 -p 174 -st topic73_0_1 -pt None -u 0.005663694937411756 > ./result_6chains/node73_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_2 -p 207 -st topic73_1_1 -pt None -u 0.012645059984944751 > ./result_6chains/node73_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_2 -p 335 -st topic73_2_1 -pt None -u 0.07852330070856225 > ./result_6chains/node73_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_2 -p 787 -st topic73_3_1 -pt None -u 0.03234437243814138 > ./result_6chains/node73_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_2 -p 856 -st topic73_4_1 -pt None -u 0.013604877884685819 > ./result_6chains/node73_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_2 -p 909 -st topic73_5_1 -pt None -u 0.0396303406444906 > ./result_6chains/node73_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_0 -p 174 -st none -pt topic73_0_0 -u 0.07090434081738817 > ./result_6chains/node73_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_0 -p 207 -st none -pt topic73_1_0 -u 0.0661991671390435 > ./result_6chains/node73_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_0 -p 335 -st none -pt topic73_2_0 -u 0.029475076765936636 > ./result_6chains/node73_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_0 -p 787 -st none -pt topic73_3_0 -u 0.006745689074573069 > ./result_6chains/node73_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_0 -p 856 -st none -pt topic73_4_0 -u 0.012177872099786463 > ./result_6chains/node73_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_0 -p 909 -st none -pt topic73_5_0 -u 0.009589865102263166 > ./result_6chains/node73_5_0.txt &
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
    "./result_6chains/node73_0_0.txt 90"
    "./result_6chains/node73_0_2.txt 90"
    "./result_6chains/node73_1_0.txt 89"
    "./result_6chains/node73_1_2.txt 89"
    "./result_6chains/node73_2_0.txt 88"
    "./result_6chains/node73_2_2.txt 88"
    "./result_6chains/node73_3_0.txt 87"
    "./result_6chains/node73_3_2.txt 87"
    "./result_6chains/node73_4_0.txt 86"
    "./result_6chains/node73_4_2.txt 86"
    "./result_6chains/node73_5_0.txt 85"
    "./result_6chains/node73_5_2.txt 85"
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
