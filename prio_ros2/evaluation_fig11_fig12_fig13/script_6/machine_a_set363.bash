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
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_2 -p 41 -st topic363_0_1 -pt None -u 0.015754775375975694 > ./result_6chains/node363_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_2 -p 243 -st topic363_1_1 -pt None -u 0.052921593168966774 > ./result_6chains/node363_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_2 -p 390 -st topic363_2_1 -pt None -u 0.026588776791949653 > ./result_6chains/node363_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_2 -p 588 -st topic363_3_1 -pt None -u 0.035024593835767365 > ./result_6chains/node363_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_2 -p 630 -st topic363_4_1 -pt None -u 0.005409791793054987 > ./result_6chains/node363_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_2 -p 645 -st topic363_5_1 -pt None -u 0.005621619206898165 > ./result_6chains/node363_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_0 -p 41 -st none -pt topic363_0_0 -u 0.020482538168717868 > ./result_6chains/node363_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_0 -p 243 -st none -pt topic363_1_0 -u 0.027925841170244714 > ./result_6chains/node363_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_0 -p 390 -st none -pt topic363_2_0 -u 0.0468363375644566 > ./result_6chains/node363_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_0 -p 588 -st none -pt topic363_3_0 -u 0.003981863694969806 > ./result_6chains/node363_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_0 -p 630 -st none -pt topic363_4_0 -u 0.0499944189871607 > ./result_6chains/node363_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_0 -p 645 -st none -pt topic363_5_0 -u 0.023338005813735577 > ./result_6chains/node363_5_0.txt &
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
    "./result_6chains/node363_0_0.txt 90"
    "./result_6chains/node363_0_2.txt 90"
    "./result_6chains/node363_1_0.txt 89"
    "./result_6chains/node363_1_2.txt 89"
    "./result_6chains/node363_2_0.txt 88"
    "./result_6chains/node363_2_2.txt 88"
    "./result_6chains/node363_3_0.txt 87"
    "./result_6chains/node363_3_2.txt 87"
    "./result_6chains/node363_4_0.txt 86"
    "./result_6chains/node363_4_2.txt 86"
    "./result_6chains/node363_5_0.txt 85"
    "./result_6chains/node363_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
