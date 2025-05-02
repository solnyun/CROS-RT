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
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_2 -p 274 -st topic60_0_1 -pt None -u 0.003896793438372792 > ./result_8chains/node60_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_2 -p 583 -st topic60_1_1 -pt None -u 0.0034282981172147897 > ./result_8chains/node60_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_2 -p 702 -st topic60_2_1 -pt None -u 0.020857867147063447 > ./result_8chains/node60_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_2 -p 735 -st topic60_3_1 -pt None -u 0.04101609015550628 > ./result_8chains/node60_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_2 -p 809 -st topic60_4_1 -pt None -u 0.005951904052647061 > ./result_8chains/node60_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_2 -p 883 -st topic60_5_1 -pt None -u 0.023174027773068692 > ./result_8chains/node60_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_2 -p 908 -st topic60_6_1 -pt None -u 0.000831005744126978 > ./result_8chains/node60_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_2 -p 945 -st topic60_7_1 -pt None -u 0.0008342192222630011 > ./result_8chains/node60_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_0 -p 274 -st none -pt topic60_0_0 -u 0.031877873666758816 > ./result_8chains/node60_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_0 -p 583 -st none -pt topic60_1_0 -u 0.0025898236308198874 > ./result_8chains/node60_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_0 -p 702 -st none -pt topic60_2_0 -u 0.03216234049939254 > ./result_8chains/node60_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_0 -p 735 -st none -pt topic60_3_0 -u 0.04006689772775862 > ./result_8chains/node60_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_0 -p 809 -st none -pt topic60_4_0 -u 0.001478168878971231 > ./result_8chains/node60_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_0 -p 883 -st none -pt topic60_5_0 -u 0.13405691079519297 > ./result_8chains/node60_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_0 -p 908 -st none -pt topic60_6_0 -u 0.03589857868689341 > ./result_8chains/node60_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_0 -p 945 -st none -pt topic60_7_0 -u 0.005438009928106537 > ./result_8chains/node60_7_0.txt &
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
    "./result_8chains/node60_0_0.txt 90"
    "./result_8chains/node60_0_2.txt 90"
    "./result_8chains/node60_1_0.txt 89"
    "./result_8chains/node60_1_2.txt 89"
    "./result_8chains/node60_2_0.txt 88"
    "./result_8chains/node60_2_2.txt 88"
    "./result_8chains/node60_3_0.txt 87"
    "./result_8chains/node60_3_2.txt 87"
    "./result_8chains/node60_4_0.txt 86"
    "./result_8chains/node60_4_2.txt 86"
    "./result_8chains/node60_5_0.txt 85"
    "./result_8chains/node60_5_2.txt 85"
    "./result_8chains/node60_6_0.txt 84"
    "./result_8chains/node60_6_2.txt 84"
    "./result_8chains/node60_7_0.txt 83"
    "./result_8chains/node60_7_2.txt 83"
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
