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
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_2 -p 61 -st topic158_0_1 -pt None -u 0.04591640465862351 > ./result_8chains/node158_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_2 -p 110 -st topic158_1_1 -pt None -u 0.01186651990377563 > ./result_8chains/node158_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_2 -p 225 -st topic158_2_1 -pt None -u 0.013241272101518597 > ./result_8chains/node158_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_2 -p 256 -st topic158_3_1 -pt None -u 0.019917985730928234 > ./result_8chains/node158_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_2 -p 610 -st topic158_4_1 -pt None -u 0.039077459603053394 > ./result_8chains/node158_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_2 -p 868 -st topic158_5_1 -pt None -u 0.01322356176920228 > ./result_8chains/node158_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_6_2 -p 944 -st topic158_6_1 -pt None -u 0.007800023964234473 > ./result_8chains/node158_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_7_2 -p 981 -st topic158_7_1 -pt None -u 0.012716626498993827 > ./result_8chains/node158_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_0 -p 61 -st none -pt topic158_0_0 -u 0.00511553360555439 > ./result_8chains/node158_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_0 -p 110 -st none -pt topic158_1_0 -u 0.02095669256638022 > ./result_8chains/node158_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_0 -p 225 -st none -pt topic158_2_0 -u 0.03257577002585893 > ./result_8chains/node158_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_0 -p 256 -st none -pt topic158_3_0 -u 0.007820669979418327 > ./result_8chains/node158_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_0 -p 610 -st none -pt topic158_4_0 -u 0.021819846485607364 > ./result_8chains/node158_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_0 -p 868 -st none -pt topic158_5_0 -u 0.001997013803505643 > ./result_8chains/node158_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_6_0 -p 944 -st none -pt topic158_6_0 -u 0.007914146649884518 > ./result_8chains/node158_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_7_0 -p 981 -st none -pt topic158_7_0 -u 0.020303675868905247 > ./result_8chains/node158_7_0.txt &
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
    "./result_8chains/node158_0_0.txt 90"
    "./result_8chains/node158_0_2.txt 90"
    "./result_8chains/node158_1_0.txt 89"
    "./result_8chains/node158_1_2.txt 89"
    "./result_8chains/node158_2_0.txt 88"
    "./result_8chains/node158_2_2.txt 88"
    "./result_8chains/node158_3_0.txt 87"
    "./result_8chains/node158_3_2.txt 87"
    "./result_8chains/node158_4_0.txt 86"
    "./result_8chains/node158_4_2.txt 86"
    "./result_8chains/node158_5_0.txt 85"
    "./result_8chains/node158_5_2.txt 85"
    "./result_8chains/node158_6_0.txt 84"
    "./result_8chains/node158_6_2.txt 84"
    "./result_8chains/node158_7_0.txt 83"
    "./result_8chains/node158_7_2.txt 83"
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
