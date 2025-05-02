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
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_2 -p 97 -st topic221_0_1 -pt None -u 0.017323304318116683 > ./result_6chains/node221_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_2 -p 117 -st topic221_1_1 -pt None -u 0.023577734627213076 > ./result_6chains/node221_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_2 -p 285 -st topic221_2_1 -pt None -u 0.0028737887147894936 > ./result_6chains/node221_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_2 -p 556 -st topic221_3_1 -pt None -u 0.08329172686783926 > ./result_6chains/node221_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_2 -p 826 -st topic221_4_1 -pt None -u 0.011279865446911785 > ./result_6chains/node221_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_2 -p 931 -st topic221_5_1 -pt None -u 0.016058450249634933 > ./result_6chains/node221_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_0 -p 97 -st none -pt topic221_0_0 -u 0.03730484213828833 > ./result_6chains/node221_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_0 -p 117 -st none -pt topic221_1_0 -u 0.0031542823668109787 > ./result_6chains/node221_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_0 -p 285 -st none -pt topic221_2_0 -u 0.011620993522732548 > ./result_6chains/node221_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_0 -p 556 -st none -pt topic221_3_0 -u 0.035113211685687484 > ./result_6chains/node221_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_0 -p 826 -st none -pt topic221_4_0 -u 0.029004378856108237 > ./result_6chains/node221_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_0 -p 931 -st none -pt topic221_5_0 -u 0.04178711619268087 > ./result_6chains/node221_5_0.txt &
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
    "./result_6chains/node221_0_0.txt 90"
    "./result_6chains/node221_0_2.txt 90"
    "./result_6chains/node221_1_0.txt 89"
    "./result_6chains/node221_1_2.txt 89"
    "./result_6chains/node221_2_0.txt 88"
    "./result_6chains/node221_2_2.txt 88"
    "./result_6chains/node221_3_0.txt 87"
    "./result_6chains/node221_3_2.txt 87"
    "./result_6chains/node221_4_0.txt 86"
    "./result_6chains/node221_4_2.txt 86"
    "./result_6chains/node221_5_0.txt 85"
    "./result_6chains/node221_5_2.txt 85"
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
