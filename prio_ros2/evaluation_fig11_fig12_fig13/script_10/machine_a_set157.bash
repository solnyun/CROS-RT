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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_2 -p 239 -st topic157_0_1 -pt None -u 0.00911098245905817 > ./result_10chains/node157_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_2 -p 469 -st topic157_1_1 -pt None -u 0.016046742407937187 > ./result_10chains/node157_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_2 -p 537 -st topic157_2_1 -pt None -u 0.026856536983274892 > ./result_10chains/node157_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_2 -p 696 -st topic157_3_1 -pt None -u 0.0009129783715649542 > ./result_10chains/node157_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_2 -p 699 -st topic157_4_1 -pt None -u 0.0010454842391268149 > ./result_10chains/node157_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_2 -p 700 -st topic157_5_1 -pt None -u 0.0006787001057488584 > ./result_10chains/node157_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_2 -p 832 -st topic157_6_1 -pt None -u 0.004693101988275883 > ./result_10chains/node157_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_2 -p 863 -st topic157_7_1 -pt None -u 0.02795042870209652 > ./result_10chains/node157_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_8_2 -p 875 -st topic157_8_1 -pt None -u 0.0012718332807964972 > ./result_10chains/node157_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_9_2 -p 883 -st topic157_9_1 -pt None -u 0.00252687410616769 > ./result_10chains/node157_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_0 -p 239 -st none -pt topic157_0_0 -u 0.003388990547477988 > ./result_10chains/node157_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_0 -p 469 -st none -pt topic157_1_0 -u 0.06362093489800547 > ./result_10chains/node157_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_0 -p 537 -st none -pt topic157_2_0 -u 0.02601516219256167 > ./result_10chains/node157_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_0 -p 696 -st none -pt topic157_3_0 -u 0.0016839856002010545 > ./result_10chains/node157_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_0 -p 699 -st none -pt topic157_4_0 -u 0.01869923115834382 > ./result_10chains/node157_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_0 -p 700 -st none -pt topic157_5_0 -u 0.011558654443418526 > ./result_10chains/node157_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_0 -p 832 -st none -pt topic157_6_0 -u 0.027768313557058777 > ./result_10chains/node157_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_0 -p 863 -st none -pt topic157_7_0 -u 0.013403180063938175 > ./result_10chains/node157_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_8_0 -p 875 -st none -pt topic157_8_0 -u 0.038307632150578336 > ./result_10chains/node157_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_9_0 -p 883 -st none -pt topic157_9_0 -u 0.0034325894688320285 > ./result_10chains/node157_9_0.txt &
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
    "./result_10chains/node157_0_0.txt 90"
    "./result_10chains/node157_0_2.txt 90"
    "./result_10chains/node157_1_0.txt 89"
    "./result_10chains/node157_1_2.txt 89"
    "./result_10chains/node157_2_0.txt 88"
    "./result_10chains/node157_2_2.txt 88"
    "./result_10chains/node157_3_0.txt 87"
    "./result_10chains/node157_3_2.txt 87"
    "./result_10chains/node157_4_0.txt 86"
    "./result_10chains/node157_4_2.txt 86"
    "./result_10chains/node157_5_0.txt 85"
    "./result_10chains/node157_5_2.txt 85"
    "./result_10chains/node157_6_0.txt 84"
    "./result_10chains/node157_6_2.txt 84"
    "./result_10chains/node157_7_0.txt 83"
    "./result_10chains/node157_7_2.txt 83"
    "./result_10chains/node157_8_0.txt 82"
    "./result_10chains/node157_8_2.txt 82"
    "./result_10chains/node157_9_0.txt 81"
    "./result_10chains/node157_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
