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
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_2 -p 203 -st topic399_0_1 -pt None -u 0.006794406341370796 > ./result_6chains/node399_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_2 -p 205 -st topic399_1_1 -pt None -u 0.02949455427199249 > ./result_6chains/node399_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_2 -p 221 -st topic399_2_1 -pt None -u 0.009953237308862911 > ./result_6chains/node399_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_2 -p 372 -st topic399_3_1 -pt None -u 0.012090683092484455 > ./result_6chains/node399_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_2 -p 418 -st topic399_4_1 -pt None -u 0.016626323189143186 > ./result_6chains/node399_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_2 -p 661 -st topic399_5_1 -pt None -u 0.04850211933602271 > ./result_6chains/node399_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_0 -p 203 -st none -pt topic399_0_0 -u 0.023118436637203976 > ./result_6chains/node399_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_0 -p 205 -st none -pt topic399_1_0 -u 0.0578236731490423 > ./result_6chains/node399_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_0 -p 221 -st none -pt topic399_2_0 -u 0.028526592419421265 > ./result_6chains/node399_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_0 -p 372 -st none -pt topic399_3_0 -u 0.03383212817437209 > ./result_6chains/node399_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_0 -p 418 -st none -pt topic399_4_0 -u 0.001235633636514244 > ./result_6chains/node399_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_0 -p 661 -st none -pt topic399_5_0 -u 0.022279975736416213 > ./result_6chains/node399_5_0.txt &
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
    "./result_6chains/node399_0_0.txt 90"
    "./result_6chains/node399_0_2.txt 90"
    "./result_6chains/node399_1_0.txt 89"
    "./result_6chains/node399_1_2.txt 89"
    "./result_6chains/node399_2_0.txt 88"
    "./result_6chains/node399_2_2.txt 88"
    "./result_6chains/node399_3_0.txt 87"
    "./result_6chains/node399_3_2.txt 87"
    "./result_6chains/node399_4_0.txt 86"
    "./result_6chains/node399_4_2.txt 86"
    "./result_6chains/node399_5_0.txt 85"
    "./result_6chains/node399_5_2.txt 85"
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
