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
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_2 -p 83 -st topic334_0_1 -pt None -u 0.0045639821221559185 > ./result_10chains/node334_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_2 -p 140 -st topic334_1_1 -pt None -u 0.051582063648669296 > ./result_10chains/node334_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_2 -p 312 -st topic334_2_1 -pt None -u 0.002568065591313895 > ./result_10chains/node334_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_2 -p 511 -st topic334_3_1 -pt None -u 0.012488853581188786 > ./result_10chains/node334_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_2 -p 564 -st topic334_4_1 -pt None -u 0.02568025979530769 > ./result_10chains/node334_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_2 -p 722 -st topic334_5_1 -pt None -u 0.018919998704832297 > ./result_10chains/node334_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_2 -p 773 -st topic334_6_1 -pt None -u 0.0028409049394399477 > ./result_10chains/node334_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_2 -p 797 -st topic334_7_1 -pt None -u 0.021105217301769646 > ./result_10chains/node334_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_8_2 -p 923 -st topic334_8_1 -pt None -u 0.04618433090634587 > ./result_10chains/node334_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_9_2 -p 980 -st topic334_9_1 -pt None -u 0.002902255382514502 > ./result_10chains/node334_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_0 -p 83 -st none -pt topic334_0_0 -u 0.005841445961459857 > ./result_10chains/node334_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_0 -p 140 -st none -pt topic334_1_0 -u 0.017964576577843783 > ./result_10chains/node334_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_0 -p 312 -st none -pt topic334_2_0 -u 0.020154064262094595 > ./result_10chains/node334_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_0 -p 511 -st none -pt topic334_3_0 -u 0.021589360735238983 > ./result_10chains/node334_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_0 -p 564 -st none -pt topic334_4_0 -u 0.03873571958291325 > ./result_10chains/node334_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_0 -p 722 -st none -pt topic334_5_0 -u 0.005264662991673108 > ./result_10chains/node334_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_0 -p 773 -st none -pt topic334_6_0 -u 0.0001424513709040176 > ./result_10chains/node334_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_0 -p 797 -st none -pt topic334_7_0 -u 0.0038447200557684413 > ./result_10chains/node334_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_8_0 -p 923 -st none -pt topic334_8_0 -u 0.029655455222182367 > ./result_10chains/node334_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_9_0 -p 980 -st none -pt topic334_9_0 -u 0.0048041076790962065 > ./result_10chains/node334_9_0.txt &
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
    "./result_10chains/node334_0_0.txt 90"
    "./result_10chains/node334_0_2.txt 90"
    "./result_10chains/node334_1_0.txt 89"
    "./result_10chains/node334_1_2.txt 89"
    "./result_10chains/node334_2_0.txt 88"
    "./result_10chains/node334_2_2.txt 88"
    "./result_10chains/node334_3_0.txt 87"
    "./result_10chains/node334_3_2.txt 87"
    "./result_10chains/node334_4_0.txt 86"
    "./result_10chains/node334_4_2.txt 86"
    "./result_10chains/node334_5_0.txt 85"
    "./result_10chains/node334_5_2.txt 85"
    "./result_10chains/node334_6_0.txt 84"
    "./result_10chains/node334_6_2.txt 84"
    "./result_10chains/node334_7_0.txt 83"
    "./result_10chains/node334_7_2.txt 83"
    "./result_10chains/node334_8_0.txt 82"
    "./result_10chains/node334_8_2.txt 82"
    "./result_10chains/node334_9_0.txt 81"
    "./result_10chains/node334_9_2.txt 81"
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
