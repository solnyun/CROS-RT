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
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_2 -p 35 -st topic36_0_1 -pt None -u 0.04054480827813939 > ./result_8chains/node36_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_2 -p 125 -st topic36_1_1 -pt None -u 0.09681274617066227 > ./result_8chains/node36_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_2 -p 177 -st topic36_2_1 -pt None -u 0.003904836215462615 > ./result_8chains/node36_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_2 -p 233 -st topic36_3_1 -pt None -u 0.008807753954591768 > ./result_8chains/node36_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_2 -p 460 -st topic36_4_1 -pt None -u 0.014363330868542079 > ./result_8chains/node36_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_2 -p 798 -st topic36_5_1 -pt None -u 0.06811828831856304 > ./result_8chains/node36_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_2 -p 902 -st topic36_6_1 -pt None -u 0.002159807296793107 > ./result_8chains/node36_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_2 -p 908 -st topic36_7_1 -pt None -u 0.011882692633003905 > ./result_8chains/node36_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_0 -p 35 -st none -pt topic36_0_0 -u 0.02478944312711423 > ./result_8chains/node36_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_0 -p 125 -st none -pt topic36_1_0 -u 0.007402908963190791 > ./result_8chains/node36_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_0 -p 177 -st none -pt topic36_2_0 -u 0.03969285413819662 > ./result_8chains/node36_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_0 -p 233 -st none -pt topic36_3_0 -u 0.0019430473303410634 > ./result_8chains/node36_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_0 -p 460 -st none -pt topic36_4_0 -u 0.013505627225292915 > ./result_8chains/node36_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_0 -p 798 -st none -pt topic36_5_0 -u 0.04046648220233108 > ./result_8chains/node36_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_0 -p 902 -st none -pt topic36_6_0 -u 0.014458559148561412 > ./result_8chains/node36_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_0 -p 908 -st none -pt topic36_7_0 -u 0.001158952309468466 > ./result_8chains/node36_7_0.txt &
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
    "./result_8chains/node36_0_0.txt 90"
    "./result_8chains/node36_0_2.txt 90"
    "./result_8chains/node36_1_0.txt 89"
    "./result_8chains/node36_1_2.txt 89"
    "./result_8chains/node36_2_0.txt 88"
    "./result_8chains/node36_2_2.txt 88"
    "./result_8chains/node36_3_0.txt 87"
    "./result_8chains/node36_3_2.txt 87"
    "./result_8chains/node36_4_0.txt 86"
    "./result_8chains/node36_4_2.txt 86"
    "./result_8chains/node36_5_0.txt 85"
    "./result_8chains/node36_5_2.txt 85"
    "./result_8chains/node36_6_0.txt 84"
    "./result_8chains/node36_6_2.txt 84"
    "./result_8chains/node36_7_0.txt 83"
    "./result_8chains/node36_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
