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
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_2 -p 23 -st topic347_0_1 -pt None -u 0.010697783373842085 > ./result_8chains/node347_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_2 -p 43 -st topic347_1_1 -pt None -u 0.0019045697271870554 > ./result_8chains/node347_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_2 -p 324 -st topic347_2_1 -pt None -u 0.09641102465613982 > ./result_8chains/node347_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_2 -p 361 -st topic347_3_1 -pt None -u 0.005543710099978422 > ./result_8chains/node347_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_2 -p 468 -st topic347_4_1 -pt None -u 0.014101747519709995 > ./result_8chains/node347_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_2 -p 564 -st topic347_5_1 -pt None -u 0.004599919125963137 > ./result_8chains/node347_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_2 -p 748 -st topic347_6_1 -pt None -u 0.012808287119210532 > ./result_8chains/node347_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_2 -p 861 -st topic347_7_1 -pt None -u 0.0012620586709806922 > ./result_8chains/node347_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_0 -p 23 -st none -pt topic347_0_0 -u 0.005245404018546673 > ./result_8chains/node347_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_0 -p 43 -st none -pt topic347_1_0 -u 0.007239911334816995 > ./result_8chains/node347_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_0 -p 324 -st none -pt topic347_2_0 -u 0.03486171095520291 > ./result_8chains/node347_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_0 -p 361 -st none -pt topic347_3_0 -u 0.03416813246178782 > ./result_8chains/node347_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_0 -p 468 -st none -pt topic347_4_0 -u 0.016640801251030818 > ./result_8chains/node347_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_0 -p 564 -st none -pt topic347_5_0 -u 0.03171730554173724 > ./result_8chains/node347_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_0 -p 748 -st none -pt topic347_6_0 -u 0.029419205459641135 > ./result_8chains/node347_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_0 -p 861 -st none -pt topic347_7_0 -u 0.0040448770372453445 > ./result_8chains/node347_7_0.txt &
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
    "./result_8chains/node347_0_0.txt 90"
    "./result_8chains/node347_0_2.txt 90"
    "./result_8chains/node347_1_0.txt 89"
    "./result_8chains/node347_1_2.txt 89"
    "./result_8chains/node347_2_0.txt 88"
    "./result_8chains/node347_2_2.txt 88"
    "./result_8chains/node347_3_0.txt 87"
    "./result_8chains/node347_3_2.txt 87"
    "./result_8chains/node347_4_0.txt 86"
    "./result_8chains/node347_4_2.txt 86"
    "./result_8chains/node347_5_0.txt 85"
    "./result_8chains/node347_5_2.txt 85"
    "./result_8chains/node347_6_0.txt 84"
    "./result_8chains/node347_6_2.txt 84"
    "./result_8chains/node347_7_0.txt 83"
    "./result_8chains/node347_7_2.txt 83"
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
