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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_2 -p 176 -st topic409_0_1 -pt None -u 0.051997648197164736 > ./result_4chains/node409_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_2 -p 360 -st topic409_1_1 -pt None -u 0.06352565435666893 > ./result_4chains/node409_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_2 -p 563 -st topic409_2_1 -pt None -u 0.028759141798648746 > ./result_4chains/node409_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_2 -p 610 -st topic409_3_1 -pt None -u 0.043279635418761266 > ./result_4chains/node409_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_0 -p 176 -st none -pt topic409_0_0 -u 0.1484460912760573 > ./result_4chains/node409_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_0 -p 360 -st none -pt topic409_1_0 -u 0.03811474573306739 > ./result_4chains/node409_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_0 -p 563 -st none -pt topic409_2_0 -u 0.004161988882835116 > ./result_4chains/node409_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_0 -p 610 -st none -pt topic409_3_0 -u 0.006641187926904671 > ./result_4chains/node409_3_0.txt &
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
    "./result_4chains/node409_0_0.txt 90"
    "./result_4chains/node409_0_2.txt 90"
    "./result_4chains/node409_1_0.txt 89"
    "./result_4chains/node409_1_2.txt 89"
    "./result_4chains/node409_2_0.txt 88"
    "./result_4chains/node409_2_2.txt 88"
    "./result_4chains/node409_3_0.txt 87"
    "./result_4chains/node409_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
