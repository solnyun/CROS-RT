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
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_2 -p 94 -st topic145_0_1 -pt None -u 0.017185341847780256 > ./result_8chains/node145_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_2 -p 173 -st topic145_1_1 -pt None -u 0.03664407199317693 > ./result_8chains/node145_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_2 -p 307 -st topic145_2_1 -pt None -u 0.025982368018756363 > ./result_8chains/node145_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_2 -p 318 -st topic145_3_1 -pt None -u 0.06171440542576084 > ./result_8chains/node145_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_2 -p 440 -st topic145_4_1 -pt None -u 0.011497739037624355 > ./result_8chains/node145_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_2 -p 513 -st topic145_5_1 -pt None -u 0.019370055587654283 > ./result_8chains/node145_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_2 -p 609 -st topic145_6_1 -pt None -u 0.027722966051266007 > ./result_8chains/node145_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_2 -p 790 -st topic145_7_1 -pt None -u 0.006806841064192419 > ./result_8chains/node145_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_0 -p 94 -st none -pt topic145_0_0 -u 0.018836894187713504 > ./result_8chains/node145_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_0 -p 173 -st none -pt topic145_1_0 -u 0.01110123028904103 > ./result_8chains/node145_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_0 -p 307 -st none -pt topic145_2_0 -u 0.009395114877122857 > ./result_8chains/node145_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_0 -p 318 -st none -pt topic145_3_0 -u 0.007977566617376641 > ./result_8chains/node145_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_0 -p 440 -st none -pt topic145_4_0 -u 0.030539458381102225 > ./result_8chains/node145_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_0 -p 513 -st none -pt topic145_5_0 -u 0.0036897052769161998 > ./result_8chains/node145_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_0 -p 609 -st none -pt topic145_6_0 -u 0.00042248112917556147 > ./result_8chains/node145_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_0 -p 790 -st none -pt topic145_7_0 -u 0.002723593050665149 > ./result_8chains/node145_7_0.txt &
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
    "./result_8chains/node145_0_0.txt 90"
    "./result_8chains/node145_0_2.txt 90"
    "./result_8chains/node145_1_0.txt 89"
    "./result_8chains/node145_1_2.txt 89"
    "./result_8chains/node145_2_0.txt 88"
    "./result_8chains/node145_2_2.txt 88"
    "./result_8chains/node145_3_0.txt 87"
    "./result_8chains/node145_3_2.txt 87"
    "./result_8chains/node145_4_0.txt 86"
    "./result_8chains/node145_4_2.txt 86"
    "./result_8chains/node145_5_0.txt 85"
    "./result_8chains/node145_5_2.txt 85"
    "./result_8chains/node145_6_0.txt 84"
    "./result_8chains/node145_6_2.txt 84"
    "./result_8chains/node145_7_0.txt 83"
    "./result_8chains/node145_7_2.txt 83"
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
