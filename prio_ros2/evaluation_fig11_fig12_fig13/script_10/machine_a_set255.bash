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
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_2 -p 92 -st topic255_0_1 -pt None -u 0.01953069751411235 > ./result_10chains/node255_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_2 -p 344 -st topic255_1_1 -pt None -u 0.010387913628140455 > ./result_10chains/node255_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_2 -p 477 -st topic255_2_1 -pt None -u 0.0010156006140429885 > ./result_10chains/node255_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_2 -p 488 -st topic255_3_1 -pt None -u 0.035472378086199574 > ./result_10chains/node255_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_2 -p 499 -st topic255_4_1 -pt None -u 4.3694234316993263e-05 > ./result_10chains/node255_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_2 -p 720 -st topic255_5_1 -pt None -u 0.013912077315854143 > ./result_10chains/node255_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_6_2 -p 862 -st topic255_6_1 -pt None -u 0.005766092527766581 > ./result_10chains/node255_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_7_2 -p 943 -st topic255_7_1 -pt None -u 0.00828844876061767 > ./result_10chains/node255_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_8_2 -p 974 -st topic255_8_1 -pt None -u 0.024498931770349786 > ./result_10chains/node255_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_9_2 -p 991 -st topic255_9_1 -pt None -u 0.02960449413569407 > ./result_10chains/node255_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_0 -p 92 -st none -pt topic255_0_0 -u 0.013272917043424426 > ./result_10chains/node255_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_0 -p 344 -st none -pt topic255_1_0 -u 0.013637515700600678 > ./result_10chains/node255_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_0 -p 477 -st none -pt topic255_2_0 -u 0.006536129004476199 > ./result_10chains/node255_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_0 -p 488 -st none -pt topic255_3_0 -u 0.008922625611088808 > ./result_10chains/node255_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_0 -p 499 -st none -pt topic255_4_0 -u 0.009088413808595597 > ./result_10chains/node255_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_0 -p 720 -st none -pt topic255_5_0 -u 0.007606474370429939 > ./result_10chains/node255_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_6_0 -p 862 -st none -pt topic255_6_0 -u 0.0015288383796507043 > ./result_10chains/node255_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_7_0 -p 943 -st none -pt topic255_7_0 -u 0.01714782873298973 > ./result_10chains/node255_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_8_0 -p 974 -st none -pt topic255_8_0 -u 0.006737309600695268 > ./result_10chains/node255_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_9_0 -p 991 -st none -pt topic255_9_0 -u 0.01940339427415027 > ./result_10chains/node255_9_0.txt &
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
    "./result_10chains/node255_0_0.txt 90"
    "./result_10chains/node255_0_2.txt 90"
    "./result_10chains/node255_1_0.txt 89"
    "./result_10chains/node255_1_2.txt 89"
    "./result_10chains/node255_2_0.txt 88"
    "./result_10chains/node255_2_2.txt 88"
    "./result_10chains/node255_3_0.txt 87"
    "./result_10chains/node255_3_2.txt 87"
    "./result_10chains/node255_4_0.txt 86"
    "./result_10chains/node255_4_2.txt 86"
    "./result_10chains/node255_5_0.txt 85"
    "./result_10chains/node255_5_2.txt 85"
    "./result_10chains/node255_6_0.txt 84"
    "./result_10chains/node255_6_2.txt 84"
    "./result_10chains/node255_7_0.txt 83"
    "./result_10chains/node255_7_2.txt 83"
    "./result_10chains/node255_8_0.txt 82"
    "./result_10chains/node255_8_2.txt 82"
    "./result_10chains/node255_9_0.txt 81"
    "./result_10chains/node255_9_2.txt 81"
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
