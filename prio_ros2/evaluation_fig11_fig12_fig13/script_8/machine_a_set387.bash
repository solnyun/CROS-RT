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
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_2 -p 86 -st topic387_0_1 -pt None -u 0.004407983283704953 > ./result_8chains/node387_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_2 -p 113 -st topic387_1_1 -pt None -u 0.005387447789163002 > ./result_8chains/node387_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_2 -p 293 -st topic387_2_1 -pt None -u 0.02630442425877194 > ./result_8chains/node387_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_2 -p 470 -st topic387_3_1 -pt None -u 0.07836525214489154 > ./result_8chains/node387_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_2 -p 488 -st topic387_4_1 -pt None -u 0.010247766332169866 > ./result_8chains/node387_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_2 -p 521 -st topic387_5_1 -pt None -u 0.0056592488528866836 > ./result_8chains/node387_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_6_2 -p 713 -st topic387_6_1 -pt None -u 0.11945520067409973 > ./result_8chains/node387_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_7_2 -p 784 -st topic387_7_1 -pt None -u 0.02531464994540578 > ./result_8chains/node387_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_0 -p 86 -st none -pt topic387_0_0 -u 0.03583303743134014 > ./result_8chains/node387_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_0 -p 113 -st none -pt topic387_1_0 -u 0.00892890376338834 > ./result_8chains/node387_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_0 -p 293 -st none -pt topic387_2_0 -u 0.0015602154448629002 > ./result_8chains/node387_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_0 -p 470 -st none -pt topic387_3_0 -u 0.011895689156551037 > ./result_8chains/node387_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_0 -p 488 -st none -pt topic387_4_0 -u 0.00776768296973307 > ./result_8chains/node387_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_0 -p 521 -st none -pt topic387_5_0 -u 0.021283207700737883 > ./result_8chains/node387_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_6_0 -p 713 -st none -pt topic387_6_0 -u 0.022537489836326974 > ./result_8chains/node387_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_7_0 -p 784 -st none -pt topic387_7_0 -u 0.007940795050622063 > ./result_8chains/node387_7_0.txt &
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
    "./result_8chains/node387_0_0.txt 90"
    "./result_8chains/node387_0_2.txt 90"
    "./result_8chains/node387_1_0.txt 89"
    "./result_8chains/node387_1_2.txt 89"
    "./result_8chains/node387_2_0.txt 88"
    "./result_8chains/node387_2_2.txt 88"
    "./result_8chains/node387_3_0.txt 87"
    "./result_8chains/node387_3_2.txt 87"
    "./result_8chains/node387_4_0.txt 86"
    "./result_8chains/node387_4_2.txt 86"
    "./result_8chains/node387_5_0.txt 85"
    "./result_8chains/node387_5_2.txt 85"
    "./result_8chains/node387_6_0.txt 84"
    "./result_8chains/node387_6_2.txt 84"
    "./result_8chains/node387_7_0.txt 83"
    "./result_8chains/node387_7_2.txt 83"
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
