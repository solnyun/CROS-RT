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
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_2 -p 160 -st topic373_0_1 -pt None -u 0.03782178955098148 > ./result_8chains/node373_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_2 -p 291 -st topic373_1_1 -pt None -u 0.014660983452881582 > ./result_8chains/node373_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_2 -p 318 -st topic373_2_1 -pt None -u 0.0029650104891953966 > ./result_8chains/node373_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_2 -p 485 -st topic373_3_1 -pt None -u 0.03718541474929715 > ./result_8chains/node373_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_2 -p 696 -st topic373_4_1 -pt None -u 0.0017810483100893226 > ./result_8chains/node373_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_2 -p 869 -st topic373_5_1 -pt None -u 0.02717452626022851 > ./result_8chains/node373_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_2 -p 928 -st topic373_6_1 -pt None -u 0.04780557979000035 > ./result_8chains/node373_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_2 -p 983 -st topic373_7_1 -pt None -u 0.008639143233180635 > ./result_8chains/node373_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_0 -p 160 -st none -pt topic373_0_0 -u 0.003044643175395989 > ./result_8chains/node373_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_0 -p 291 -st none -pt topic373_1_0 -u 0.01105201817063367 > ./result_8chains/node373_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_0 -p 318 -st none -pt topic373_2_0 -u 0.0018824411097601579 > ./result_8chains/node373_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_0 -p 485 -st none -pt topic373_3_0 -u 0.012095599739560203 > ./result_8chains/node373_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_0 -p 696 -st none -pt topic373_4_0 -u 0.029353613506226894 > ./result_8chains/node373_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_0 -p 869 -st none -pt topic373_5_0 -u 0.016958220242193733 > ./result_8chains/node373_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_0 -p 928 -st none -pt topic373_6_0 -u 0.04794201442305569 > ./result_8chains/node373_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_0 -p 983 -st none -pt topic373_7_0 -u 0.02214041891830395 > ./result_8chains/node373_7_0.txt &
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
    "./result_8chains/node373_0_0.txt 90"
    "./result_8chains/node373_0_2.txt 90"
    "./result_8chains/node373_1_0.txt 89"
    "./result_8chains/node373_1_2.txt 89"
    "./result_8chains/node373_2_0.txt 88"
    "./result_8chains/node373_2_2.txt 88"
    "./result_8chains/node373_3_0.txt 87"
    "./result_8chains/node373_3_2.txt 87"
    "./result_8chains/node373_4_0.txt 86"
    "./result_8chains/node373_4_2.txt 86"
    "./result_8chains/node373_5_0.txt 85"
    "./result_8chains/node373_5_2.txt 85"
    "./result_8chains/node373_6_0.txt 84"
    "./result_8chains/node373_6_2.txt 84"
    "./result_8chains/node373_7_0.txt 83"
    "./result_8chains/node373_7_2.txt 83"
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
