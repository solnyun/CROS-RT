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
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_2 -p 119 -st topic274_0_1 -pt None -u 0.015300573067003387 > ./result_8chains/node274_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_2 -p 392 -st topic274_1_1 -pt None -u 0.0199508494092 > ./result_8chains/node274_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_2 -p 433 -st topic274_2_1 -pt None -u 0.00981918284742328 > ./result_8chains/node274_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_2 -p 450 -st topic274_3_1 -pt None -u 0.07250831018096468 > ./result_8chains/node274_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_2 -p 612 -st topic274_4_1 -pt None -u 0.03077659910734426 > ./result_8chains/node274_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_2 -p 829 -st topic274_5_1 -pt None -u 0.020431105351780277 > ./result_8chains/node274_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_6_2 -p 843 -st topic274_6_1 -pt None -u 0.03946205189140038 > ./result_8chains/node274_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_7_2 -p 902 -st topic274_7_1 -pt None -u 0.0013036433479248991 > ./result_8chains/node274_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_0 -p 119 -st none -pt topic274_0_0 -u 0.0638404973342277 > ./result_8chains/node274_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_0 -p 392 -st none -pt topic274_1_0 -u 0.045581478019100174 > ./result_8chains/node274_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_0 -p 433 -st none -pt topic274_2_0 -u 0.0038396177146151067 > ./result_8chains/node274_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_0 -p 450 -st none -pt topic274_3_0 -u 0.023553537302957617 > ./result_8chains/node274_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_0 -p 612 -st none -pt topic274_4_0 -u 0.0044749526507590065 > ./result_8chains/node274_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_0 -p 829 -st none -pt topic274_5_0 -u 0.0030603962837525422 > ./result_8chains/node274_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_6_0 -p 843 -st none -pt topic274_6_0 -u 0.0181684289342042 > ./result_8chains/node274_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_7_0 -p 902 -st none -pt topic274_7_0 -u 0.017057442812125716 > ./result_8chains/node274_7_0.txt &
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
    "./result_8chains/node274_0_0.txt 90"
    "./result_8chains/node274_0_2.txt 90"
    "./result_8chains/node274_1_0.txt 89"
    "./result_8chains/node274_1_2.txt 89"
    "./result_8chains/node274_2_0.txt 88"
    "./result_8chains/node274_2_2.txt 88"
    "./result_8chains/node274_3_0.txt 87"
    "./result_8chains/node274_3_2.txt 87"
    "./result_8chains/node274_4_0.txt 86"
    "./result_8chains/node274_4_2.txt 86"
    "./result_8chains/node274_5_0.txt 85"
    "./result_8chains/node274_5_2.txt 85"
    "./result_8chains/node274_6_0.txt 84"
    "./result_8chains/node274_6_2.txt 84"
    "./result_8chains/node274_7_0.txt 83"
    "./result_8chains/node274_7_2.txt 83"
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
