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
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_2 -p 66 -st topic233_0_1 -pt None -u 0.008162985296551739 > ./result_8chains/node233_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_2 -p 227 -st topic233_1_1 -pt None -u 0.0004478680390840317 > ./result_8chains/node233_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_2 -p 296 -st topic233_2_1 -pt None -u 0.008986834312582181 > ./result_8chains/node233_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_2 -p 710 -st topic233_3_1 -pt None -u 0.028492554908568668 > ./result_8chains/node233_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_2 -p 760 -st topic233_4_1 -pt None -u 0.016478804188557045 > ./result_8chains/node233_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_2 -p 799 -st topic233_5_1 -pt None -u 0.05663435523635052 > ./result_8chains/node233_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_6_2 -p 801 -st topic233_6_1 -pt None -u 0.004176121799406591 > ./result_8chains/node233_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_7_2 -p 906 -st topic233_7_1 -pt None -u 0.001312281887219136 > ./result_8chains/node233_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_0 -p 66 -st none -pt topic233_0_0 -u 0.013623071440544088 > ./result_8chains/node233_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_0 -p 227 -st none -pt topic233_1_0 -u 0.00322760948008749 > ./result_8chains/node233_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_0 -p 296 -st none -pt topic233_2_0 -u 0.031925709421595894 > ./result_8chains/node233_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_0 -p 710 -st none -pt topic233_3_0 -u 0.0013749911052419184 > ./result_8chains/node233_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_0 -p 760 -st none -pt topic233_4_0 -u 0.04416454741468262 > ./result_8chains/node233_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_0 -p 799 -st none -pt topic233_5_0 -u 0.004753617650920222 > ./result_8chains/node233_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_6_0 -p 801 -st none -pt topic233_6_0 -u 0.0490655812463668 > ./result_8chains/node233_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_7_0 -p 906 -st none -pt topic233_7_0 -u 0.0024326101308074135 > ./result_8chains/node233_7_0.txt &
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
    "./result_8chains/node233_0_0.txt 90"
    "./result_8chains/node233_0_2.txt 90"
    "./result_8chains/node233_1_0.txt 89"
    "./result_8chains/node233_1_2.txt 89"
    "./result_8chains/node233_2_0.txt 88"
    "./result_8chains/node233_2_2.txt 88"
    "./result_8chains/node233_3_0.txt 87"
    "./result_8chains/node233_3_2.txt 87"
    "./result_8chains/node233_4_0.txt 86"
    "./result_8chains/node233_4_2.txt 86"
    "./result_8chains/node233_5_0.txt 85"
    "./result_8chains/node233_5_2.txt 85"
    "./result_8chains/node233_6_0.txt 84"
    "./result_8chains/node233_6_2.txt 84"
    "./result_8chains/node233_7_0.txt 83"
    "./result_8chains/node233_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
