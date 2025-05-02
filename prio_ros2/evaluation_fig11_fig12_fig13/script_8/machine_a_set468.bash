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
ros2 run evaluation_3_randomdag uunifast_node -n node468_0_2 -p 123 -st topic468_0_1 -pt None -u 0.10520906277821052 > ./result_8chains/node468_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_1_2 -p 175 -st topic468_1_1 -pt None -u 0.002886446187924774 > ./result_8chains/node468_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_2_2 -p 591 -st topic468_2_1 -pt None -u 0.028407126896422497 > ./result_8chains/node468_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_3_2 -p 782 -st topic468_3_1 -pt None -u 0.003051236624651288 > ./result_8chains/node468_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_4_2 -p 875 -st topic468_4_1 -pt None -u 0.021123061304922086 > ./result_8chains/node468_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_5_2 -p 899 -st topic468_5_1 -pt None -u 0.034409582478088827 > ./result_8chains/node468_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_6_2 -p 905 -st topic468_6_1 -pt None -u 0.06456832875554679 > ./result_8chains/node468_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_7_2 -p 940 -st topic468_7_1 -pt None -u 0.020208075003730414 > ./result_8chains/node468_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_0_0 -p 123 -st none -pt topic468_0_0 -u 0.00683814269468741 > ./result_8chains/node468_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_1_0 -p 175 -st none -pt topic468_1_0 -u 0.0022516551182558686 > ./result_8chains/node468_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_2_0 -p 591 -st none -pt topic468_2_0 -u 0.018675457550440255 > ./result_8chains/node468_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_3_0 -p 782 -st none -pt topic468_3_0 -u 0.008111125672152442 > ./result_8chains/node468_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_4_0 -p 875 -st none -pt topic468_4_0 -u 0.015211508088722958 > ./result_8chains/node468_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_5_0 -p 899 -st none -pt topic468_5_0 -u 0.03446692639180712 > ./result_8chains/node468_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_6_0 -p 905 -st none -pt topic468_6_0 -u 0.0005876906036206136 > ./result_8chains/node468_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_7_0 -p 940 -st none -pt topic468_7_0 -u 0.0007706006192330327 > ./result_8chains/node468_7_0.txt &
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
    "./result_8chains/node468_0_0.txt 90"
    "./result_8chains/node468_0_2.txt 90"
    "./result_8chains/node468_1_0.txt 89"
    "./result_8chains/node468_1_2.txt 89"
    "./result_8chains/node468_2_0.txt 88"
    "./result_8chains/node468_2_2.txt 88"
    "./result_8chains/node468_3_0.txt 87"
    "./result_8chains/node468_3_2.txt 87"
    "./result_8chains/node468_4_0.txt 86"
    "./result_8chains/node468_4_2.txt 86"
    "./result_8chains/node468_5_0.txt 85"
    "./result_8chains/node468_5_2.txt 85"
    "./result_8chains/node468_6_0.txt 84"
    "./result_8chains/node468_6_2.txt 84"
    "./result_8chains/node468_7_0.txt 83"
    "./result_8chains/node468_7_2.txt 83"
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
