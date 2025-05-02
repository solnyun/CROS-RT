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
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_2 -p 21 -st topic43_0_1 -pt None -u 3.957380017799439e-05 > ./result_10chains/node43_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_2 -p 54 -st topic43_1_1 -pt None -u 0.0013654285455859116 > ./result_10chains/node43_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_2 -p 302 -st topic43_2_1 -pt None -u 0.011742767736167337 > ./result_10chains/node43_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_2 -p 338 -st topic43_3_1 -pt None -u 0.007732940028161828 > ./result_10chains/node43_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_2 -p 381 -st topic43_4_1 -pt None -u 0.06009263429462949 > ./result_10chains/node43_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_2 -p 726 -st topic43_5_1 -pt None -u 0.021281310328957664 > ./result_10chains/node43_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_2 -p 732 -st topic43_6_1 -pt None -u 0.04501004666400797 > ./result_10chains/node43_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_2 -p 763 -st topic43_7_1 -pt None -u 0.0056006624895917345 > ./result_10chains/node43_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_8_2 -p 838 -st topic43_8_1 -pt None -u 0.0014771625251273207 > ./result_10chains/node43_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_9_2 -p 885 -st topic43_9_1 -pt None -u 0.007870508957900525 > ./result_10chains/node43_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_0 -p 21 -st none -pt topic43_0_0 -u 0.0009884678931958435 > ./result_10chains/node43_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_0 -p 54 -st none -pt topic43_1_0 -u 0.0010691326856523409 > ./result_10chains/node43_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_0 -p 302 -st none -pt topic43_2_0 -u 0.029989826013271825 > ./result_10chains/node43_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_0 -p 338 -st none -pt topic43_3_0 -u 0.020285690676539514 > ./result_10chains/node43_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_0 -p 381 -st none -pt topic43_4_0 -u 0.0041580581840999775 > ./result_10chains/node43_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_0 -p 726 -st none -pt topic43_5_0 -u 0.012129179409521601 > ./result_10chains/node43_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_0 -p 732 -st none -pt topic43_6_0 -u 0.0016857395097646666 > ./result_10chains/node43_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_0 -p 763 -st none -pt topic43_7_0 -u 0.010538185649445114 > ./result_10chains/node43_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_8_0 -p 838 -st none -pt topic43_8_0 -u 0.007177564798187874 > ./result_10chains/node43_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_9_0 -p 885 -st none -pt topic43_9_0 -u 0.03037496022692741 > ./result_10chains/node43_9_0.txt &
sleep 10
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
    "./result_10chains/node43_0_0.txt 90"
    "./result_10chains/node43_0_2.txt 90"
    "./result_10chains/node43_1_0.txt 89"
    "./result_10chains/node43_1_2.txt 89"
    "./result_10chains/node43_2_0.txt 88"
    "./result_10chains/node43_2_2.txt 88"
    "./result_10chains/node43_3_0.txt 87"
    "./result_10chains/node43_3_2.txt 87"
    "./result_10chains/node43_4_0.txt 86"
    "./result_10chains/node43_4_2.txt 86"
    "./result_10chains/node43_5_0.txt 85"
    "./result_10chains/node43_5_2.txt 85"
    "./result_10chains/node43_6_0.txt 84"
    "./result_10chains/node43_6_2.txt 84"
    "./result_10chains/node43_7_0.txt 83"
    "./result_10chains/node43_7_2.txt 83"
    "./result_10chains/node43_8_0.txt 82"
    "./result_10chains/node43_8_2.txt 82"
    "./result_10chains/node43_9_0.txt 81"
    "./result_10chains/node43_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
