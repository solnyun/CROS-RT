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
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_2 -p 64 -st topic187_0_1 -pt None -u 0.00622173079767635 > ./result_8chains/node187_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_2 -p 130 -st topic187_1_1 -pt None -u 0.014788094565060972 > ./result_8chains/node187_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_2 -p 170 -st topic187_2_1 -pt None -u 0.011976920529246982 > ./result_8chains/node187_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_2 -p 414 -st topic187_3_1 -pt None -u 0.01340806292668767 > ./result_8chains/node187_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_2 -p 579 -st topic187_4_1 -pt None -u 0.005159676159867815 > ./result_8chains/node187_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_2 -p 718 -st topic187_5_1 -pt None -u 0.006317321655676236 > ./result_8chains/node187_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_2 -p 740 -st topic187_6_1 -pt None -u 0.014469130066938798 > ./result_8chains/node187_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_2 -p 975 -st topic187_7_1 -pt None -u 0.014464599434191306 > ./result_8chains/node187_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_0 -p 64 -st none -pt topic187_0_0 -u 0.0005111110257172147 > ./result_8chains/node187_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_0 -p 130 -st none -pt topic187_1_0 -u 0.0727184237109681 > ./result_8chains/node187_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_0 -p 170 -st none -pt topic187_2_0 -u 0.020615993949203826 > ./result_8chains/node187_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_0 -p 414 -st none -pt topic187_3_0 -u 0.014662991119881175 > ./result_8chains/node187_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_0 -p 579 -st none -pt topic187_4_0 -u 0.021911838143906404 > ./result_8chains/node187_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_0 -p 718 -st none -pt topic187_5_0 -u 0.0002001046410586571 > ./result_8chains/node187_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_0 -p 740 -st none -pt topic187_6_0 -u 0.014703843736152078 > ./result_8chains/node187_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_0 -p 975 -st none -pt topic187_7_0 -u 0.01995762301946776 > ./result_8chains/node187_7_0.txt &
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
    "./result_8chains/node187_0_0.txt 90"
    "./result_8chains/node187_0_2.txt 90"
    "./result_8chains/node187_1_0.txt 89"
    "./result_8chains/node187_1_2.txt 89"
    "./result_8chains/node187_2_0.txt 88"
    "./result_8chains/node187_2_2.txt 88"
    "./result_8chains/node187_3_0.txt 87"
    "./result_8chains/node187_3_2.txt 87"
    "./result_8chains/node187_4_0.txt 86"
    "./result_8chains/node187_4_2.txt 86"
    "./result_8chains/node187_5_0.txt 85"
    "./result_8chains/node187_5_2.txt 85"
    "./result_8chains/node187_6_0.txt 84"
    "./result_8chains/node187_6_2.txt 84"
    "./result_8chains/node187_7_0.txt 83"
    "./result_8chains/node187_7_2.txt 83"
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
