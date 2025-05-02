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
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_2 -p 119 -st topic337_0_1 -pt None -u 0.06282758238799507 > ./result_10chains/node337_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_2 -p 147 -st topic337_1_1 -pt None -u 0.01201575069094657 > ./result_10chains/node337_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_2 -p 171 -st topic337_2_1 -pt None -u 0.01103105719429942 > ./result_10chains/node337_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_2 -p 365 -st topic337_3_1 -pt None -u 0.03171650181803204 > ./result_10chains/node337_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_2 -p 664 -st topic337_4_1 -pt None -u 0.013115465430455442 > ./result_10chains/node337_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_2 -p 783 -st topic337_5_1 -pt None -u 0.028789961482185794 > ./result_10chains/node337_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_2 -p 838 -st topic337_6_1 -pt None -u 0.01708595614547312 > ./result_10chains/node337_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_2 -p 851 -st topic337_7_1 -pt None -u 0.02562283065464689 > ./result_10chains/node337_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_8_2 -p 904 -st topic337_8_1 -pt None -u 0.0010298405750981468 > ./result_10chains/node337_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_9_2 -p 915 -st topic337_9_1 -pt None -u 0.01405495916580361 > ./result_10chains/node337_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_0 -p 119 -st none -pt topic337_0_0 -u 0.006130213203834445 > ./result_10chains/node337_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_0 -p 147 -st none -pt topic337_1_0 -u 0.015893198149646515 > ./result_10chains/node337_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_0 -p 171 -st none -pt topic337_2_0 -u 0.020488936380735956 > ./result_10chains/node337_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_0 -p 365 -st none -pt topic337_3_0 -u 0.007258733098492454 > ./result_10chains/node337_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_0 -p 664 -st none -pt topic337_4_0 -u 0.027692727729069305 > ./result_10chains/node337_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_0 -p 783 -st none -pt topic337_5_0 -u 0.02167802653710388 > ./result_10chains/node337_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_0 -p 838 -st none -pt topic337_6_0 -u 0.006351262703377464 > ./result_10chains/node337_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_0 -p 851 -st none -pt topic337_7_0 -u 0.019211941383285275 > ./result_10chains/node337_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_8_0 -p 904 -st none -pt topic337_8_0 -u 0.05003620754390294 > ./result_10chains/node337_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_9_0 -p 915 -st none -pt topic337_9_0 -u 0.007975166142346734 > ./result_10chains/node337_9_0.txt &
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
    "./result_10chains/node337_0_0.txt 90"
    "./result_10chains/node337_0_2.txt 90"
    "./result_10chains/node337_1_0.txt 89"
    "./result_10chains/node337_1_2.txt 89"
    "./result_10chains/node337_2_0.txt 88"
    "./result_10chains/node337_2_2.txt 88"
    "./result_10chains/node337_3_0.txt 87"
    "./result_10chains/node337_3_2.txt 87"
    "./result_10chains/node337_4_0.txt 86"
    "./result_10chains/node337_4_2.txt 86"
    "./result_10chains/node337_5_0.txt 85"
    "./result_10chains/node337_5_2.txt 85"
    "./result_10chains/node337_6_0.txt 84"
    "./result_10chains/node337_6_2.txt 84"
    "./result_10chains/node337_7_0.txt 83"
    "./result_10chains/node337_7_2.txt 83"
    "./result_10chains/node337_8_0.txt 82"
    "./result_10chains/node337_8_2.txt 82"
    "./result_10chains/node337_9_0.txt 81"
    "./result_10chains/node337_9_2.txt 81"
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
