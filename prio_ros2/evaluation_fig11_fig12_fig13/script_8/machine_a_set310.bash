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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_2 -p 82 -st topic310_0_1 -pt None -u 0.012848395703377313 > ./result_8chains/node310_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_2 -p 137 -st topic310_1_1 -pt None -u 0.010114002640852826 > ./result_8chains/node310_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_2 -p 183 -st topic310_2_1 -pt None -u 0.008868445178139117 > ./result_8chains/node310_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_2 -p 275 -st topic310_3_1 -pt None -u 0.001678802990492806 > ./result_8chains/node310_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_2 -p 344 -st topic310_4_1 -pt None -u 0.02772510391847463 > ./result_8chains/node310_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_2 -p 364 -st topic310_5_1 -pt None -u 0.025091953354974744 > ./result_8chains/node310_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_2 -p 527 -st topic310_6_1 -pt None -u 0.0038401725669835046 > ./result_8chains/node310_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_2 -p 556 -st topic310_7_1 -pt None -u 0.0591989581640591 > ./result_8chains/node310_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_0 -p 82 -st none -pt topic310_0_0 -u 0.003317449144384532 > ./result_8chains/node310_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_0 -p 137 -st none -pt topic310_1_0 -u 0.04936765258214276 > ./result_8chains/node310_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_0 -p 183 -st none -pt topic310_2_0 -u 0.017643381652391266 > ./result_8chains/node310_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_0 -p 275 -st none -pt topic310_3_0 -u 0.001299787018587517 > ./result_8chains/node310_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_0 -p 344 -st none -pt topic310_4_0 -u 0.0075148527486154915 > ./result_8chains/node310_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_0 -p 364 -st none -pt topic310_5_0 -u 0.010528141528596019 > ./result_8chains/node310_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_0 -p 527 -st none -pt topic310_6_0 -u 0.04376438441306087 > ./result_8chains/node310_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_0 -p 556 -st none -pt topic310_7_0 -u 0.010086610186946426 > ./result_8chains/node310_7_0.txt &
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
    "./result_8chains/node310_0_0.txt 90"
    "./result_8chains/node310_0_2.txt 90"
    "./result_8chains/node310_1_0.txt 89"
    "./result_8chains/node310_1_2.txt 89"
    "./result_8chains/node310_2_0.txt 88"
    "./result_8chains/node310_2_2.txt 88"
    "./result_8chains/node310_3_0.txt 87"
    "./result_8chains/node310_3_2.txt 87"
    "./result_8chains/node310_4_0.txt 86"
    "./result_8chains/node310_4_2.txt 86"
    "./result_8chains/node310_5_0.txt 85"
    "./result_8chains/node310_5_2.txt 85"
    "./result_8chains/node310_6_0.txt 84"
    "./result_8chains/node310_6_2.txt 84"
    "./result_8chains/node310_7_0.txt 83"
    "./result_8chains/node310_7_2.txt 83"
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
