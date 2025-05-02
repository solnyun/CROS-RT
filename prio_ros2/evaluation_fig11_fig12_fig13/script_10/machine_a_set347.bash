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
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_2 -p 40 -st topic347_0_1 -pt None -u 0.05974264960721021 > ./result_10chains/node347_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_2 -p 261 -st topic347_1_1 -pt None -u 0.03421563145643902 > ./result_10chains/node347_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_2 -p 326 -st topic347_2_1 -pt None -u 0.014678171255999684 > ./result_10chains/node347_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_2 -p 577 -st topic347_3_1 -pt None -u 0.0040165710277357825 > ./result_10chains/node347_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_2 -p 596 -st topic347_4_1 -pt None -u 0.014241079602922063 > ./result_10chains/node347_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_2 -p 690 -st topic347_5_1 -pt None -u 0.008899623749433871 > ./result_10chains/node347_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_2 -p 715 -st topic347_6_1 -pt None -u 0.051517975740203115 > ./result_10chains/node347_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_2 -p 737 -st topic347_7_1 -pt None -u 0.019369127144252193 > ./result_10chains/node347_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_8_2 -p 909 -st topic347_8_1 -pt None -u 0.03517352197565207 > ./result_10chains/node347_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_9_2 -p 926 -st topic347_9_1 -pt None -u 0.007920624221125279 > ./result_10chains/node347_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_0 -p 40 -st none -pt topic347_0_0 -u 0.012294811389343518 > ./result_10chains/node347_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_0 -p 261 -st none -pt topic347_1_0 -u 0.005042130259138244 > ./result_10chains/node347_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_0 -p 326 -st none -pt topic347_2_0 -u 0.0016728344927578465 > ./result_10chains/node347_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_0 -p 577 -st none -pt topic347_3_0 -u 0.01725348944359384 > ./result_10chains/node347_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_0 -p 596 -st none -pt topic347_4_0 -u 0.02025179237289515 > ./result_10chains/node347_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_0 -p 690 -st none -pt topic347_5_0 -u 0.013153807046050764 > ./result_10chains/node347_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_0 -p 715 -st none -pt topic347_6_0 -u 0.01129537573789513 > ./result_10chains/node347_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_0 -p 737 -st none -pt topic347_7_0 -u 0.011798191632449231 > ./result_10chains/node347_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_8_0 -p 909 -st none -pt topic347_8_0 -u 0.0034453867200983784 > ./result_10chains/node347_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node347_9_0 -p 926 -st none -pt topic347_9_0 -u 0.03247302900897722 > ./result_10chains/node347_9_0.txt &
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
    "./result_10chains/node347_0_0.txt 90"
    "./result_10chains/node347_0_2.txt 90"
    "./result_10chains/node347_1_0.txt 89"
    "./result_10chains/node347_1_2.txt 89"
    "./result_10chains/node347_2_0.txt 88"
    "./result_10chains/node347_2_2.txt 88"
    "./result_10chains/node347_3_0.txt 87"
    "./result_10chains/node347_3_2.txt 87"
    "./result_10chains/node347_4_0.txt 86"
    "./result_10chains/node347_4_2.txt 86"
    "./result_10chains/node347_5_0.txt 85"
    "./result_10chains/node347_5_2.txt 85"
    "./result_10chains/node347_6_0.txt 84"
    "./result_10chains/node347_6_2.txt 84"
    "./result_10chains/node347_7_0.txt 83"
    "./result_10chains/node347_7_2.txt 83"
    "./result_10chains/node347_8_0.txt 82"
    "./result_10chains/node347_8_2.txt 82"
    "./result_10chains/node347_9_0.txt 81"
    "./result_10chains/node347_9_2.txt 81"
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
