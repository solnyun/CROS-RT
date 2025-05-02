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
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_2 -p 273 -st topic179_0_1 -pt None -u 0.03635513084572661 > ./result_8chains/node179_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_2 -p 313 -st topic179_1_1 -pt None -u 0.031282201765841455 > ./result_8chains/node179_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_2 -p 479 -st topic179_2_1 -pt None -u 0.033002297547667814 > ./result_8chains/node179_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_2 -p 522 -st topic179_3_1 -pt None -u 0.00834168204883326 > ./result_8chains/node179_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_2 -p 530 -st topic179_4_1 -pt None -u 0.021752781815037397 > ./result_8chains/node179_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_2 -p 568 -st topic179_5_1 -pt None -u 0.04485233052786755 > ./result_8chains/node179_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_2 -p 586 -st topic179_6_1 -pt None -u 0.031254604095837545 > ./result_8chains/node179_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_2 -p 684 -st topic179_7_1 -pt None -u 0.0020075159594772863 > ./result_8chains/node179_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_0 -p 273 -st none -pt topic179_0_0 -u 0.000536883429424595 > ./result_8chains/node179_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_0 -p 313 -st none -pt topic179_1_0 -u 0.0015210393578850567 > ./result_8chains/node179_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_0 -p 479 -st none -pt topic179_2_0 -u 0.032596022815759795 > ./result_8chains/node179_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_0 -p 522 -st none -pt topic179_3_0 -u 0.06137609034476571 > ./result_8chains/node179_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_0 -p 530 -st none -pt topic179_4_0 -u 6.431219367075691e-05 > ./result_8chains/node179_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_0 -p 568 -st none -pt topic179_5_0 -u 0.05928254651179263 > ./result_8chains/node179_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_0 -p 586 -st none -pt topic179_6_0 -u 0.011763341877571984 > ./result_8chains/node179_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_0 -p 684 -st none -pt topic179_7_0 -u 0.005115846204874392 > ./result_8chains/node179_7_0.txt &
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
    "./result_8chains/node179_0_0.txt 90"
    "./result_8chains/node179_0_2.txt 90"
    "./result_8chains/node179_1_0.txt 89"
    "./result_8chains/node179_1_2.txt 89"
    "./result_8chains/node179_2_0.txt 88"
    "./result_8chains/node179_2_2.txt 88"
    "./result_8chains/node179_3_0.txt 87"
    "./result_8chains/node179_3_2.txt 87"
    "./result_8chains/node179_4_0.txt 86"
    "./result_8chains/node179_4_2.txt 86"
    "./result_8chains/node179_5_0.txt 85"
    "./result_8chains/node179_5_2.txt 85"
    "./result_8chains/node179_6_0.txt 84"
    "./result_8chains/node179_6_2.txt 84"
    "./result_8chains/node179_7_0.txt 83"
    "./result_8chains/node179_7_2.txt 83"
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
