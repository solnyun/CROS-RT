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
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_2 -p 163 -st topic457_0_1 -pt None -u 0.011479488783342096 > ./result_6chains/node457_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_2 -p 296 -st topic457_1_1 -pt None -u 0.012545300753337707 > ./result_6chains/node457_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_2 -p 337 -st topic457_2_1 -pt None -u 0.08500106970718946 > ./result_6chains/node457_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_2 -p 436 -st topic457_3_1 -pt None -u 0.041174066877536164 > ./result_6chains/node457_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_2 -p 514 -st topic457_4_1 -pt None -u 0.013817768430176597 > ./result_6chains/node457_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_2 -p 596 -st topic457_5_1 -pt None -u 0.039459729289675685 > ./result_6chains/node457_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_0 -p 163 -st none -pt topic457_0_0 -u 0.017981260600213156 > ./result_6chains/node457_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_0 -p 296 -st none -pt topic457_1_0 -u 0.022379835486205146 > ./result_6chains/node457_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_0 -p 337 -st none -pt topic457_2_0 -u 0.0378392908322448 > ./result_6chains/node457_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_0 -p 436 -st none -pt topic457_3_0 -u 0.02865487906521086 > ./result_6chains/node457_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_0 -p 514 -st none -pt topic457_4_0 -u 0.0003661309989043682 > ./result_6chains/node457_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_0 -p 596 -st none -pt topic457_5_0 -u 0.013571125088041341 > ./result_6chains/node457_5_0.txt &
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
    "./result_6chains/node457_0_0.txt 90"
    "./result_6chains/node457_0_2.txt 90"
    "./result_6chains/node457_1_0.txt 89"
    "./result_6chains/node457_1_2.txt 89"
    "./result_6chains/node457_2_0.txt 88"
    "./result_6chains/node457_2_2.txt 88"
    "./result_6chains/node457_3_0.txt 87"
    "./result_6chains/node457_3_2.txt 87"
    "./result_6chains/node457_4_0.txt 86"
    "./result_6chains/node457_4_2.txt 86"
    "./result_6chains/node457_5_0.txt 85"
    "./result_6chains/node457_5_2.txt 85"
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
