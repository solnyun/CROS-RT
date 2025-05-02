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
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_2 -p 188 -st topic429_0_1 -pt None -u 0.01195402683944885 > ./result_8chains/node429_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_2 -p 372 -st topic429_1_1 -pt None -u 0.032073612865788526 > ./result_8chains/node429_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_2 -p 620 -st topic429_2_1 -pt None -u 0.03889063899012879 > ./result_8chains/node429_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_2 -p 803 -st topic429_3_1 -pt None -u 0.0025061634266348165 > ./result_8chains/node429_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_2 -p 853 -st topic429_4_1 -pt None -u 0.014118165859082127 > ./result_8chains/node429_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_2 -p 888 -st topic429_5_1 -pt None -u 0.058092210260938054 > ./result_8chains/node429_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_2 -p 897 -st topic429_6_1 -pt None -u 0.05233793585281829 > ./result_8chains/node429_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_2 -p 985 -st topic429_7_1 -pt None -u 0.021069079974055955 > ./result_8chains/node429_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_0 -p 188 -st none -pt topic429_0_0 -u 0.03195365339148726 > ./result_8chains/node429_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_0 -p 372 -st none -pt topic429_1_0 -u 0.013679799441020435 > ./result_8chains/node429_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_0 -p 620 -st none -pt topic429_2_0 -u 0.04041579454554456 > ./result_8chains/node429_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_0 -p 803 -st none -pt topic429_3_0 -u 0.021196511493977416 > ./result_8chains/node429_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_0 -p 853 -st none -pt topic429_4_0 -u 0.005117411246086889 > ./result_8chains/node429_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_0 -p 888 -st none -pt topic429_5_0 -u 0.0004029483152639679 > ./result_8chains/node429_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_0 -p 897 -st none -pt topic429_6_0 -u 0.05256780463582679 > ./result_8chains/node429_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_0 -p 985 -st none -pt topic429_7_0 -u 0.006555675338441886 > ./result_8chains/node429_7_0.txt &
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
    "./result_8chains/node429_0_0.txt 90"
    "./result_8chains/node429_0_2.txt 90"
    "./result_8chains/node429_1_0.txt 89"
    "./result_8chains/node429_1_2.txt 89"
    "./result_8chains/node429_2_0.txt 88"
    "./result_8chains/node429_2_2.txt 88"
    "./result_8chains/node429_3_0.txt 87"
    "./result_8chains/node429_3_2.txt 87"
    "./result_8chains/node429_4_0.txt 86"
    "./result_8chains/node429_4_2.txt 86"
    "./result_8chains/node429_5_0.txt 85"
    "./result_8chains/node429_5_2.txt 85"
    "./result_8chains/node429_6_0.txt 84"
    "./result_8chains/node429_6_2.txt 84"
    "./result_8chains/node429_7_0.txt 83"
    "./result_8chains/node429_7_2.txt 83"
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
