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
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_2 -p 89 -st topic285_0_1 -pt None -u 0.04373387022019348 > ./result_8chains/node285_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_2 -p 97 -st topic285_1_1 -pt None -u 0.03476871315542718 > ./result_8chains/node285_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_2 -p 102 -st topic285_2_1 -pt None -u 0.01834741538669471 > ./result_8chains/node285_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_2 -p 398 -st topic285_3_1 -pt None -u 0.006682680184210421 > ./result_8chains/node285_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_2 -p 438 -st topic285_4_1 -pt None -u 0.007854235192212844 > ./result_8chains/node285_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_2 -p 516 -st topic285_5_1 -pt None -u 0.0585490450297928 > ./result_8chains/node285_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_6_2 -p 620 -st topic285_6_1 -pt None -u 0.0033718036067926505 > ./result_8chains/node285_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_7_2 -p 825 -st topic285_7_1 -pt None -u 0.0008102663016383008 > ./result_8chains/node285_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_0 -p 89 -st none -pt topic285_0_0 -u 0.02646139871212605 > ./result_8chains/node285_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_0 -p 97 -st none -pt topic285_1_0 -u 0.005352392443983667 > ./result_8chains/node285_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_0 -p 102 -st none -pt topic285_2_0 -u 0.017320883435459178 > ./result_8chains/node285_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_0 -p 398 -st none -pt topic285_3_0 -u 0.007710223760264867 > ./result_8chains/node285_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_0 -p 438 -st none -pt topic285_4_0 -u 0.011344443344995875 > ./result_8chains/node285_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_0 -p 516 -st none -pt topic285_5_0 -u 0.024970707010611187 > ./result_8chains/node285_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_6_0 -p 620 -st none -pt topic285_6_0 -u 0.01699192846717376 > ./result_8chains/node285_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_7_0 -p 825 -st none -pt topic285_7_0 -u 0.002047863469572475 > ./result_8chains/node285_7_0.txt &
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
    "./result_8chains/node285_0_0.txt 90"
    "./result_8chains/node285_0_2.txt 90"
    "./result_8chains/node285_1_0.txt 89"
    "./result_8chains/node285_1_2.txt 89"
    "./result_8chains/node285_2_0.txt 88"
    "./result_8chains/node285_2_2.txt 88"
    "./result_8chains/node285_3_0.txt 87"
    "./result_8chains/node285_3_2.txt 87"
    "./result_8chains/node285_4_0.txt 86"
    "./result_8chains/node285_4_2.txt 86"
    "./result_8chains/node285_5_0.txt 85"
    "./result_8chains/node285_5_2.txt 85"
    "./result_8chains/node285_6_0.txt 84"
    "./result_8chains/node285_6_2.txt 84"
    "./result_8chains/node285_7_0.txt 83"
    "./result_8chains/node285_7_2.txt 83"
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
