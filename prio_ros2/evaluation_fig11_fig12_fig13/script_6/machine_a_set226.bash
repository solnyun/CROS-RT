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
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_2 -p 16 -st topic226_0_1 -pt None -u 0.034198475028928144 > ./result_6chains/node226_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_2 -p 281 -st topic226_1_1 -pt None -u 0.0029239818969127307 > ./result_6chains/node226_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_2 -p 304 -st topic226_2_1 -pt None -u 0.021212193988445094 > ./result_6chains/node226_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_2 -p 420 -st topic226_3_1 -pt None -u 0.0018430940983005517 > ./result_6chains/node226_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_2 -p 499 -st topic226_4_1 -pt None -u 0.07125884486521698 > ./result_6chains/node226_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_2 -p 942 -st topic226_5_1 -pt None -u 0.02777934185479024 > ./result_6chains/node226_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_0 -p 16 -st none -pt topic226_0_0 -u 0.02837663470119961 > ./result_6chains/node226_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_0 -p 281 -st none -pt topic226_1_0 -u 0.05195709211938587 > ./result_6chains/node226_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_0 -p 304 -st none -pt topic226_2_0 -u 0.0030384186383871636 > ./result_6chains/node226_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_0 -p 420 -st none -pt topic226_3_0 -u 0.006829817815079964 > ./result_6chains/node226_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_0 -p 499 -st none -pt topic226_4_0 -u 0.030388348022798856 > ./result_6chains/node226_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_0 -p 942 -st none -pt topic226_5_0 -u 0.006591655750485648 > ./result_6chains/node226_5_0.txt &
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
    "./result_6chains/node226_0_0.txt 90"
    "./result_6chains/node226_0_2.txt 90"
    "./result_6chains/node226_1_0.txt 89"
    "./result_6chains/node226_1_2.txt 89"
    "./result_6chains/node226_2_0.txt 88"
    "./result_6chains/node226_2_2.txt 88"
    "./result_6chains/node226_3_0.txt 87"
    "./result_6chains/node226_3_2.txt 87"
    "./result_6chains/node226_4_0.txt 86"
    "./result_6chains/node226_4_2.txt 86"
    "./result_6chains/node226_5_0.txt 85"
    "./result_6chains/node226_5_2.txt 85"
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
