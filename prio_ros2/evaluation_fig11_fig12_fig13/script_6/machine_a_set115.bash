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
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_2 -p 52 -st topic115_0_1 -pt None -u 0.0028729424570221873 > ./result_6chains/node115_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_2 -p 230 -st topic115_1_1 -pt None -u 0.013047734849079173 > ./result_6chains/node115_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_2 -p 495 -st topic115_2_1 -pt None -u 0.0001787347756838087 > ./result_6chains/node115_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_2 -p 545 -st topic115_3_1 -pt None -u 0.05627055901070513 > ./result_6chains/node115_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_2 -p 763 -st topic115_4_1 -pt None -u 0.011143322650890429 > ./result_6chains/node115_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_2 -p 883 -st topic115_5_1 -pt None -u 0.006727042055912832 > ./result_6chains/node115_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_0 -p 52 -st none -pt topic115_0_0 -u 0.029229401027882074 > ./result_6chains/node115_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_0 -p 230 -st none -pt topic115_1_0 -u 0.08337489135769532 > ./result_6chains/node115_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_0 -p 495 -st none -pt topic115_2_0 -u 0.0104178360887891 > ./result_6chains/node115_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_0 -p 545 -st none -pt topic115_3_0 -u 0.03182818155909706 > ./result_6chains/node115_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_0 -p 763 -st none -pt topic115_4_0 -u 0.07626389142465667 > ./result_6chains/node115_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_0 -p 883 -st none -pt topic115_5_0 -u 0.01583865047058009 > ./result_6chains/node115_5_0.txt &
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
    "./result_6chains/node115_0_0.txt 90"
    "./result_6chains/node115_0_2.txt 90"
    "./result_6chains/node115_1_0.txt 89"
    "./result_6chains/node115_1_2.txt 89"
    "./result_6chains/node115_2_0.txt 88"
    "./result_6chains/node115_2_2.txt 88"
    "./result_6chains/node115_3_0.txt 87"
    "./result_6chains/node115_3_2.txt 87"
    "./result_6chains/node115_4_0.txt 86"
    "./result_6chains/node115_4_2.txt 86"
    "./result_6chains/node115_5_0.txt 85"
    "./result_6chains/node115_5_2.txt 85"
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
