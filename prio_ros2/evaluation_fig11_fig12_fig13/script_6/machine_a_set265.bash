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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_2 -p 110 -st topic265_0_1 -pt None -u 0.03869083025876807 > ./result_6chains/node265_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_2 -p 123 -st topic265_1_1 -pt None -u 0.003825106500576936 > ./result_6chains/node265_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_2 -p 196 -st topic265_2_1 -pt None -u 0.0029401590245389797 > ./result_6chains/node265_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_2 -p 203 -st topic265_3_1 -pt None -u 0.0064338018423250876 > ./result_6chains/node265_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_2 -p 247 -st topic265_4_1 -pt None -u 0.010872068406456596 > ./result_6chains/node265_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_2 -p 977 -st topic265_5_1 -pt None -u 0.013667900690945763 > ./result_6chains/node265_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_0 -p 110 -st none -pt topic265_0_0 -u 0.015014251351077923 > ./result_6chains/node265_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_0 -p 123 -st none -pt topic265_1_0 -u 0.16506948499544793 > ./result_6chains/node265_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_0 -p 196 -st none -pt topic265_2_0 -u 0.011682667795138602 > ./result_6chains/node265_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_0 -p 203 -st none -pt topic265_3_0 -u 0.012813560078380998 > ./result_6chains/node265_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_0 -p 247 -st none -pt topic265_4_0 -u 0.0042271924883733325 > ./result_6chains/node265_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_0 -p 977 -st none -pt topic265_5_0 -u 0.005828982324569659 > ./result_6chains/node265_5_0.txt &
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
    "./result_6chains/node265_0_0.txt 90"
    "./result_6chains/node265_0_2.txt 90"
    "./result_6chains/node265_1_0.txt 89"
    "./result_6chains/node265_1_2.txt 89"
    "./result_6chains/node265_2_0.txt 88"
    "./result_6chains/node265_2_2.txt 88"
    "./result_6chains/node265_3_0.txt 87"
    "./result_6chains/node265_3_2.txt 87"
    "./result_6chains/node265_4_0.txt 86"
    "./result_6chains/node265_4_2.txt 86"
    "./result_6chains/node265_5_0.txt 85"
    "./result_6chains/node265_5_2.txt 85"
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
