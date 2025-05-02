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
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_2 -p 29 -st topic448_0_1 -pt None -u 0.02002643897589662 > ./result_8chains/node448_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_2 -p 107 -st topic448_1_1 -pt None -u 0.020070157616892015 > ./result_8chains/node448_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_2 -p 125 -st topic448_2_1 -pt None -u 0.015669370022422968 > ./result_8chains/node448_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_2 -p 306 -st topic448_3_1 -pt None -u 0.025734120519805226 > ./result_8chains/node448_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_2 -p 693 -st topic448_4_1 -pt None -u 0.030239745672206553 > ./result_8chains/node448_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_2 -p 785 -st topic448_5_1 -pt None -u 0.006062569709108484 > ./result_8chains/node448_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_2 -p 885 -st topic448_6_1 -pt None -u 0.028862275203167947 > ./result_8chains/node448_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_2 -p 935 -st topic448_7_1 -pt None -u 0.001005816136389279 > ./result_8chains/node448_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_0 -p 29 -st none -pt topic448_0_0 -u 0.027780760722107445 > ./result_8chains/node448_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_0 -p 107 -st none -pt topic448_1_0 -u 0.022969517700677622 > ./result_8chains/node448_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_0 -p 125 -st none -pt topic448_2_0 -u 0.00989867382828108 > ./result_8chains/node448_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_0 -p 306 -st none -pt topic448_3_0 -u 0.04978515166198244 > ./result_8chains/node448_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_0 -p 693 -st none -pt topic448_4_0 -u 0.021765931435017483 > ./result_8chains/node448_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_0 -p 785 -st none -pt topic448_5_0 -u 0.0032644494894468745 > ./result_8chains/node448_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_0 -p 885 -st none -pt topic448_6_0 -u 0.02615421178080489 > ./result_8chains/node448_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_0 -p 935 -st none -pt topic448_7_0 -u 0.0024329434201719805 > ./result_8chains/node448_7_0.txt &
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
    "./result_8chains/node448_0_0.txt 90"
    "./result_8chains/node448_0_2.txt 90"
    "./result_8chains/node448_1_0.txt 89"
    "./result_8chains/node448_1_2.txt 89"
    "./result_8chains/node448_2_0.txt 88"
    "./result_8chains/node448_2_2.txt 88"
    "./result_8chains/node448_3_0.txt 87"
    "./result_8chains/node448_3_2.txt 87"
    "./result_8chains/node448_4_0.txt 86"
    "./result_8chains/node448_4_2.txt 86"
    "./result_8chains/node448_5_0.txt 85"
    "./result_8chains/node448_5_2.txt 85"
    "./result_8chains/node448_6_0.txt 84"
    "./result_8chains/node448_6_2.txt 84"
    "./result_8chains/node448_7_0.txt 83"
    "./result_8chains/node448_7_2.txt 83"
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
