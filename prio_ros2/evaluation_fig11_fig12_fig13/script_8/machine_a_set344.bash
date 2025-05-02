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
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_2 -p 27 -st topic344_0_1 -pt None -u 0.019779567081535943 > ./result_8chains/node344_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_2 -p 266 -st topic344_1_1 -pt None -u 0.0007820424477328336 > ./result_8chains/node344_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_2 -p 515 -st topic344_2_1 -pt None -u 0.0454240625101352 > ./result_8chains/node344_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_2 -p 626 -st topic344_3_1 -pt None -u 0.017943375653478977 > ./result_8chains/node344_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_2 -p 716 -st topic344_4_1 -pt None -u 0.00890811481987211 > ./result_8chains/node344_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_2 -p 761 -st topic344_5_1 -pt None -u 0.04648999051685006 > ./result_8chains/node344_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_2 -p 787 -st topic344_6_1 -pt None -u 0.0052818780063891915 > ./result_8chains/node344_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_2 -p 936 -st topic344_7_1 -pt None -u 0.007068651282084701 > ./result_8chains/node344_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_0 -p 27 -st none -pt topic344_0_0 -u 0.044306679766272616 > ./result_8chains/node344_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_0 -p 266 -st none -pt topic344_1_0 -u 0.020629522389046973 > ./result_8chains/node344_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_0 -p 515 -st none -pt topic344_2_0 -u 0.02611151971489767 > ./result_8chains/node344_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_0 -p 626 -st none -pt topic344_3_0 -u 0.041354585650499875 > ./result_8chains/node344_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_0 -p 716 -st none -pt topic344_4_0 -u 0.024342307528036344 > ./result_8chains/node344_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_0 -p 761 -st none -pt topic344_5_0 -u 0.01824909849960832 > ./result_8chains/node344_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_0 -p 787 -st none -pt topic344_6_0 -u 0.009194703642632099 > ./result_8chains/node344_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_0 -p 936 -st none -pt topic344_7_0 -u 0.026204293344243016 > ./result_8chains/node344_7_0.txt &
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
    "./result_8chains/node344_0_0.txt 90"
    "./result_8chains/node344_0_2.txt 90"
    "./result_8chains/node344_1_0.txt 89"
    "./result_8chains/node344_1_2.txt 89"
    "./result_8chains/node344_2_0.txt 88"
    "./result_8chains/node344_2_2.txt 88"
    "./result_8chains/node344_3_0.txt 87"
    "./result_8chains/node344_3_2.txt 87"
    "./result_8chains/node344_4_0.txt 86"
    "./result_8chains/node344_4_2.txt 86"
    "./result_8chains/node344_5_0.txt 85"
    "./result_8chains/node344_5_2.txt 85"
    "./result_8chains/node344_6_0.txt 84"
    "./result_8chains/node344_6_2.txt 84"
    "./result_8chains/node344_7_0.txt 83"
    "./result_8chains/node344_7_2.txt 83"
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
