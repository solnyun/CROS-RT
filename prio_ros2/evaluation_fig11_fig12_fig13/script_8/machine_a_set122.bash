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
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_2 -p 267 -st topic122_0_1 -pt None -u 0.0010006210896091883 > ./result_8chains/node122_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_2 -p 337 -st topic122_1_1 -pt None -u 0.015698755421864163 > ./result_8chains/node122_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_2 -p 352 -st topic122_2_1 -pt None -u 0.012393932328171597 > ./result_8chains/node122_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_2 -p 375 -st topic122_3_1 -pt None -u 0.008230638227843423 > ./result_8chains/node122_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_2 -p 412 -st topic122_4_1 -pt None -u 0.0051448085200835325 > ./result_8chains/node122_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_2 -p 571 -st topic122_5_1 -pt None -u 0.003938795092946368 > ./result_8chains/node122_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_2 -p 602 -st topic122_6_1 -pt None -u 0.0018667177952829683 > ./result_8chains/node122_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_2 -p 849 -st topic122_7_1 -pt None -u 0.051871399732397225 > ./result_8chains/node122_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_0 -p 267 -st none -pt topic122_0_0 -u 0.03739583424302073 > ./result_8chains/node122_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_0 -p 337 -st none -pt topic122_1_0 -u 0.05063026517046659 > ./result_8chains/node122_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_0 -p 352 -st none -pt topic122_2_0 -u 0.08149623121779243 > ./result_8chains/node122_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_0 -p 375 -st none -pt topic122_3_0 -u 0.014764789308805648 > ./result_8chains/node122_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_0 -p 412 -st none -pt topic122_4_0 -u 0.0036180861434553235 > ./result_8chains/node122_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_0 -p 571 -st none -pt topic122_5_0 -u 0.018745837663382864 > ./result_8chains/node122_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_0 -p 602 -st none -pt topic122_6_0 -u 0.001204641429764744 > ./result_8chains/node122_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_0 -p 849 -st none -pt topic122_7_0 -u 0.017551303505546845 > ./result_8chains/node122_7_0.txt &
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
    "./result_8chains/node122_0_0.txt 90"
    "./result_8chains/node122_0_2.txt 90"
    "./result_8chains/node122_1_0.txt 89"
    "./result_8chains/node122_1_2.txt 89"
    "./result_8chains/node122_2_0.txt 88"
    "./result_8chains/node122_2_2.txt 88"
    "./result_8chains/node122_3_0.txt 87"
    "./result_8chains/node122_3_2.txt 87"
    "./result_8chains/node122_4_0.txt 86"
    "./result_8chains/node122_4_2.txt 86"
    "./result_8chains/node122_5_0.txt 85"
    "./result_8chains/node122_5_2.txt 85"
    "./result_8chains/node122_6_0.txt 84"
    "./result_8chains/node122_6_2.txt 84"
    "./result_8chains/node122_7_0.txt 83"
    "./result_8chains/node122_7_2.txt 83"
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
