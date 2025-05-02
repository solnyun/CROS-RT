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
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_2 -p 171 -st topic257_0_1 -pt None -u 0.06007438572598245 > ./result_8chains/node257_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_2 -p 297 -st topic257_1_1 -pt None -u 0.0797287659384695 > ./result_8chains/node257_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_2 -p 471 -st topic257_2_1 -pt None -u 0.0014773954106188092 > ./result_8chains/node257_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_2 -p 529 -st topic257_3_1 -pt None -u 0.006298245602869179 > ./result_8chains/node257_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_2 -p 551 -st topic257_4_1 -pt None -u 0.0015100808393290754 > ./result_8chains/node257_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_2 -p 775 -st topic257_5_1 -pt None -u 0.004975204382335119 > ./result_8chains/node257_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_6_2 -p 884 -st topic257_6_1 -pt None -u 0.04204528135506941 > ./result_8chains/node257_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_7_2 -p 956 -st topic257_7_1 -pt None -u 0.031840255488908405 > ./result_8chains/node257_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_0 -p 171 -st none -pt topic257_0_0 -u 0.0016260733375205172 > ./result_8chains/node257_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_0 -p 297 -st none -pt topic257_1_0 -u 0.06318209381854101 > ./result_8chains/node257_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_0 -p 471 -st none -pt topic257_2_0 -u 0.00918966626755019 > ./result_8chains/node257_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_0 -p 529 -st none -pt topic257_3_0 -u 0.03061149785331685 > ./result_8chains/node257_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_0 -p 551 -st none -pt topic257_4_0 -u 0.0026611136272845226 > ./result_8chains/node257_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_0 -p 775 -st none -pt topic257_5_0 -u 0.028871961431623572 > ./result_8chains/node257_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_6_0 -p 884 -st none -pt topic257_6_0 -u 0.010482400676680617 > ./result_8chains/node257_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_7_0 -p 956 -st none -pt topic257_7_0 -u 0.0052037188039043974 > ./result_8chains/node257_7_0.txt &
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
    "./result_8chains/node257_0_0.txt 90"
    "./result_8chains/node257_0_2.txt 90"
    "./result_8chains/node257_1_0.txt 89"
    "./result_8chains/node257_1_2.txt 89"
    "./result_8chains/node257_2_0.txt 88"
    "./result_8chains/node257_2_2.txt 88"
    "./result_8chains/node257_3_0.txt 87"
    "./result_8chains/node257_3_2.txt 87"
    "./result_8chains/node257_4_0.txt 86"
    "./result_8chains/node257_4_2.txt 86"
    "./result_8chains/node257_5_0.txt 85"
    "./result_8chains/node257_5_2.txt 85"
    "./result_8chains/node257_6_0.txt 84"
    "./result_8chains/node257_6_2.txt 84"
    "./result_8chains/node257_7_0.txt 83"
    "./result_8chains/node257_7_2.txt 83"
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
