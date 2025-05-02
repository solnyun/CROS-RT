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
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_2 -p 78 -st topic352_0_1 -pt None -u 0.027431585734697783 > ./result_8chains/node352_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_2 -p 232 -st topic352_1_1 -pt None -u 0.001568037845186332 > ./result_8chains/node352_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_2 -p 300 -st topic352_2_1 -pt None -u 0.01834359771581967 > ./result_8chains/node352_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_2 -p 338 -st topic352_3_1 -pt None -u 0.001834863656094754 > ./result_8chains/node352_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_2 -p 669 -st topic352_4_1 -pt None -u 0.00338803673279775 > ./result_8chains/node352_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_2 -p 681 -st topic352_5_1 -pt None -u 0.0011994969994154059 > ./result_8chains/node352_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_6_2 -p 761 -st topic352_6_1 -pt None -u 0.010158680543594048 > ./result_8chains/node352_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_7_2 -p 871 -st topic352_7_1 -pt None -u 0.088239025782932 > ./result_8chains/node352_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_0 -p 78 -st none -pt topic352_0_0 -u 0.02605032485414599 > ./result_8chains/node352_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_0 -p 232 -st none -pt topic352_1_0 -u 0.007156390186918438 > ./result_8chains/node352_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_0 -p 300 -st none -pt topic352_2_0 -u 0.02663723618632774 > ./result_8chains/node352_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_0 -p 338 -st none -pt topic352_3_0 -u 0.008754882459702573 > ./result_8chains/node352_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_0 -p 669 -st none -pt topic352_4_0 -u 0.008056594940804018 > ./result_8chains/node352_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_0 -p 681 -st none -pt topic352_5_0 -u 0.10614874271234492 > ./result_8chains/node352_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_6_0 -p 761 -st none -pt topic352_6_0 -u 0.001789336762266197 > ./result_8chains/node352_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_7_0 -p 871 -st none -pt topic352_7_0 -u 0.013664078450107711 > ./result_8chains/node352_7_0.txt &
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
    "./result_8chains/node352_0_0.txt 90"
    "./result_8chains/node352_0_2.txt 90"
    "./result_8chains/node352_1_0.txt 89"
    "./result_8chains/node352_1_2.txt 89"
    "./result_8chains/node352_2_0.txt 88"
    "./result_8chains/node352_2_2.txt 88"
    "./result_8chains/node352_3_0.txt 87"
    "./result_8chains/node352_3_2.txt 87"
    "./result_8chains/node352_4_0.txt 86"
    "./result_8chains/node352_4_2.txt 86"
    "./result_8chains/node352_5_0.txt 85"
    "./result_8chains/node352_5_2.txt 85"
    "./result_8chains/node352_6_0.txt 84"
    "./result_8chains/node352_6_2.txt 84"
    "./result_8chains/node352_7_0.txt 83"
    "./result_8chains/node352_7_2.txt 83"
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
