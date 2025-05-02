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
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_2 -p 114 -st topic96_0_1 -pt None -u 0.02452994203727593 > ./result_6chains/node96_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_2 -p 128 -st topic96_1_1 -pt None -u 0.0010018475644152924 > ./result_6chains/node96_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_2 -p 244 -st topic96_2_1 -pt None -u 0.00034806926538544225 > ./result_6chains/node96_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_2 -p 697 -st topic96_3_1 -pt None -u 0.07003191612816145 > ./result_6chains/node96_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_2 -p 841 -st topic96_4_1 -pt None -u 0.008766813135367812 > ./result_6chains/node96_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_2 -p 932 -st topic96_5_1 -pt None -u 0.012598730981893269 > ./result_6chains/node96_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_0 -p 114 -st none -pt topic96_0_0 -u 0.03156382884099829 > ./result_6chains/node96_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_0 -p 128 -st none -pt topic96_1_0 -u 0.08073033128543078 > ./result_6chains/node96_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_0 -p 244 -st none -pt topic96_2_0 -u 0.018895062180210254 > ./result_6chains/node96_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_0 -p 697 -st none -pt topic96_3_0 -u 0.00014525465529602322 > ./result_6chains/node96_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_0 -p 841 -st none -pt topic96_4_0 -u 0.07112220364002197 > ./result_6chains/node96_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_0 -p 932 -st none -pt topic96_5_0 -u 0.1297286346537787 > ./result_6chains/node96_5_0.txt &
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
    "./result_6chains/node96_0_0.txt 90"
    "./result_6chains/node96_0_2.txt 90"
    "./result_6chains/node96_1_0.txt 89"
    "./result_6chains/node96_1_2.txt 89"
    "./result_6chains/node96_2_0.txt 88"
    "./result_6chains/node96_2_2.txt 88"
    "./result_6chains/node96_3_0.txt 87"
    "./result_6chains/node96_3_2.txt 87"
    "./result_6chains/node96_4_0.txt 86"
    "./result_6chains/node96_4_2.txt 86"
    "./result_6chains/node96_5_0.txt 85"
    "./result_6chains/node96_5_2.txt 85"
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
