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
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_2 -p 47 -st topic23_0_1 -pt None -u 0.007969889423968535 > ./result_8chains/node23_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_2 -p 53 -st topic23_1_1 -pt None -u 0.0014877248003675736 > ./result_8chains/node23_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_2 -p 69 -st topic23_2_1 -pt None -u 0.005287979907716789 > ./result_8chains/node23_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_2 -p 140 -st topic23_3_1 -pt None -u 0.021291567620727536 > ./result_8chains/node23_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_2 -p 238 -st topic23_4_1 -pt None -u 0.015538192225274028 > ./result_8chains/node23_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_2 -p 255 -st topic23_5_1 -pt None -u 0.00019312573368300556 > ./result_8chains/node23_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_2 -p 541 -st topic23_6_1 -pt None -u 0.007063658515093163 > ./result_8chains/node23_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_2 -p 568 -st topic23_7_1 -pt None -u 0.04323611234151395 > ./result_8chains/node23_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_0 -p 47 -st none -pt topic23_0_0 -u 0.04888136106788127 > ./result_8chains/node23_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_0 -p 53 -st none -pt topic23_1_0 -u 0.01576378757231328 > ./result_8chains/node23_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_0 -p 69 -st none -pt topic23_2_0 -u 0.012489600121721955 > ./result_8chains/node23_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_0 -p 140 -st none -pt topic23_3_0 -u 0.09277546285224647 > ./result_8chains/node23_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_0 -p 238 -st none -pt topic23_4_0 -u 0.028104608912520535 > ./result_8chains/node23_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_0 -p 255 -st none -pt topic23_5_0 -u 0.005756660898072918 > ./result_8chains/node23_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_0 -p 541 -st none -pt topic23_6_0 -u 0.01217592010830583 > ./result_8chains/node23_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_0 -p 568 -st none -pt topic23_7_0 -u 0.03561924895321206 > ./result_8chains/node23_7_0.txt &
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
    "./result_8chains/node23_0_0.txt 90"
    "./result_8chains/node23_0_2.txt 90"
    "./result_8chains/node23_1_0.txt 89"
    "./result_8chains/node23_1_2.txt 89"
    "./result_8chains/node23_2_0.txt 88"
    "./result_8chains/node23_2_2.txt 88"
    "./result_8chains/node23_3_0.txt 87"
    "./result_8chains/node23_3_2.txt 87"
    "./result_8chains/node23_4_0.txt 86"
    "./result_8chains/node23_4_2.txt 86"
    "./result_8chains/node23_5_0.txt 85"
    "./result_8chains/node23_5_2.txt 85"
    "./result_8chains/node23_6_0.txt 84"
    "./result_8chains/node23_6_2.txt 84"
    "./result_8chains/node23_7_0.txt 83"
    "./result_8chains/node23_7_2.txt 83"
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
