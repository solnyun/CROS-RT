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
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_2 -p 127 -st topic142_0_1 -pt None -u 0.07266056425295375 > ./result_6chains/node142_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_2 -p 513 -st topic142_1_1 -pt None -u 0.010732708770292532 > ./result_6chains/node142_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_2 -p 638 -st topic142_2_1 -pt None -u 0.0785536560729857 > ./result_6chains/node142_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_2 -p 777 -st topic142_3_1 -pt None -u 0.023991514297266064 > ./result_6chains/node142_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_2 -p 795 -st topic142_4_1 -pt None -u 0.007647291687903207 > ./result_6chains/node142_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_2 -p 955 -st topic142_5_1 -pt None -u 0.007548644714317748 > ./result_6chains/node142_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_0 -p 127 -st none -pt topic142_0_0 -u 0.03322999519514508 > ./result_6chains/node142_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_0 -p 513 -st none -pt topic142_1_0 -u 0.044827235422775114 > ./result_6chains/node142_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_0 -p 638 -st none -pt topic142_2_0 -u 0.0045956118422930126 > ./result_6chains/node142_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_0 -p 777 -st none -pt topic142_3_0 -u 0.03291054299151561 > ./result_6chains/node142_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_0 -p 795 -st none -pt topic142_4_0 -u 0.0031155182940132073 > ./result_6chains/node142_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_0 -p 955 -st none -pt topic142_5_0 -u 0.01647331875829551 > ./result_6chains/node142_5_0.txt &
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
    "./result_6chains/node142_0_0.txt 90"
    "./result_6chains/node142_0_2.txt 90"
    "./result_6chains/node142_1_0.txt 89"
    "./result_6chains/node142_1_2.txt 89"
    "./result_6chains/node142_2_0.txt 88"
    "./result_6chains/node142_2_2.txt 88"
    "./result_6chains/node142_3_0.txt 87"
    "./result_6chains/node142_3_2.txt 87"
    "./result_6chains/node142_4_0.txt 86"
    "./result_6chains/node142_4_2.txt 86"
    "./result_6chains/node142_5_0.txt 85"
    "./result_6chains/node142_5_2.txt 85"
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
