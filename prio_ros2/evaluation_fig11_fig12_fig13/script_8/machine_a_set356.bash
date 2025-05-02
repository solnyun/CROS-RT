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
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_2 -p 201 -st topic356_0_1 -pt None -u 0.03951782786680452 > ./result_8chains/node356_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_2 -p 467 -st topic356_1_1 -pt None -u 0.02202596430784165 > ./result_8chains/node356_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_2 -p 485 -st topic356_2_1 -pt None -u 0.04211871318297994 > ./result_8chains/node356_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_2 -p 615 -st topic356_3_1 -pt None -u 0.0011425874064991959 > ./result_8chains/node356_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_2 -p 703 -st topic356_4_1 -pt None -u 0.07267771564272388 > ./result_8chains/node356_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_2 -p 721 -st topic356_5_1 -pt None -u 0.013638782372022873 > ./result_8chains/node356_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_2 -p 766 -st topic356_6_1 -pt None -u 0.001977145162251913 > ./result_8chains/node356_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_2 -p 837 -st topic356_7_1 -pt None -u 0.03617399917344548 > ./result_8chains/node356_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_0 -p 201 -st none -pt topic356_0_0 -u 0.018566452473144646 > ./result_8chains/node356_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_0 -p 467 -st none -pt topic356_1_0 -u 0.03316630421847755 > ./result_8chains/node356_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_0 -p 485 -st none -pt topic356_2_0 -u 0.0054954979808043425 > ./result_8chains/node356_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_0 -p 615 -st none -pt topic356_3_0 -u 0.01112129929448652 > ./result_8chains/node356_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_0 -p 703 -st none -pt topic356_4_0 -u 0.009296297865646064 > ./result_8chains/node356_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_0 -p 721 -st none -pt topic356_5_0 -u 0.03732472035674339 > ./result_8chains/node356_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_0 -p 766 -st none -pt topic356_6_0 -u 0.011861745824732144 > ./result_8chains/node356_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_0 -p 837 -st none -pt topic356_7_0 -u 0.00855596891593894 > ./result_8chains/node356_7_0.txt &
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
    "./result_8chains/node356_0_0.txt 90"
    "./result_8chains/node356_0_2.txt 90"
    "./result_8chains/node356_1_0.txt 89"
    "./result_8chains/node356_1_2.txt 89"
    "./result_8chains/node356_2_0.txt 88"
    "./result_8chains/node356_2_2.txt 88"
    "./result_8chains/node356_3_0.txt 87"
    "./result_8chains/node356_3_2.txt 87"
    "./result_8chains/node356_4_0.txt 86"
    "./result_8chains/node356_4_2.txt 86"
    "./result_8chains/node356_5_0.txt 85"
    "./result_8chains/node356_5_2.txt 85"
    "./result_8chains/node356_6_0.txt 84"
    "./result_8chains/node356_6_2.txt 84"
    "./result_8chains/node356_7_0.txt 83"
    "./result_8chains/node356_7_2.txt 83"
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
