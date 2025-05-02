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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_2 -p 36 -st topic381_0_1 -pt None -u 0.04010197098492235 > ./result_10chains/node381_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_2 -p 51 -st topic381_1_1 -pt None -u 0.0010095659727520911 > ./result_10chains/node381_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_2 -p 132 -st topic381_2_1 -pt None -u 0.048038449513361114 > ./result_10chains/node381_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_2 -p 346 -st topic381_3_1 -pt None -u 0.010179287176439067 > ./result_10chains/node381_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_2 -p 401 -st topic381_4_1 -pt None -u 0.012856578912209843 > ./result_10chains/node381_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_2 -p 425 -st topic381_5_1 -pt None -u 0.014039971701106185 > ./result_10chains/node381_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_2 -p 506 -st topic381_6_1 -pt None -u 0.008139371049683541 > ./result_10chains/node381_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_2 -p 654 -st topic381_7_1 -pt None -u 0.02844039335918333 > ./result_10chains/node381_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_8_2 -p 825 -st topic381_8_1 -pt None -u 0.0022013098856025343 > ./result_10chains/node381_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_9_2 -p 881 -st topic381_9_1 -pt None -u 0.014567009692727322 > ./result_10chains/node381_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_0 -p 36 -st none -pt topic381_0_0 -u 0.01117869567957025 > ./result_10chains/node381_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_0 -p 51 -st none -pt topic381_1_0 -u 0.0006525982369033345 > ./result_10chains/node381_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_0 -p 132 -st none -pt topic381_2_0 -u 0.012468721399192084 > ./result_10chains/node381_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_0 -p 346 -st none -pt topic381_3_0 -u 0.0045117324237443635 > ./result_10chains/node381_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_0 -p 401 -st none -pt topic381_4_0 -u 0.010199457254103872 > ./result_10chains/node381_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_0 -p 425 -st none -pt topic381_5_0 -u 0.002497798537766077 > ./result_10chains/node381_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_0 -p 506 -st none -pt topic381_6_0 -u 0.002501354438304071 > ./result_10chains/node381_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_0 -p 654 -st none -pt topic381_7_0 -u 0.015984450143279164 > ./result_10chains/node381_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_8_0 -p 825 -st none -pt topic381_8_0 -u 0.0091498328083605 > ./result_10chains/node381_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_9_0 -p 881 -st none -pt topic381_9_0 -u 0.0050894997162332575 > ./result_10chains/node381_9_0.txt &
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
    "./result_10chains/node381_0_0.txt 90"
    "./result_10chains/node381_0_2.txt 90"
    "./result_10chains/node381_1_0.txt 89"
    "./result_10chains/node381_1_2.txt 89"
    "./result_10chains/node381_2_0.txt 88"
    "./result_10chains/node381_2_2.txt 88"
    "./result_10chains/node381_3_0.txt 87"
    "./result_10chains/node381_3_2.txt 87"
    "./result_10chains/node381_4_0.txt 86"
    "./result_10chains/node381_4_2.txt 86"
    "./result_10chains/node381_5_0.txt 85"
    "./result_10chains/node381_5_2.txt 85"
    "./result_10chains/node381_6_0.txt 84"
    "./result_10chains/node381_6_2.txt 84"
    "./result_10chains/node381_7_0.txt 83"
    "./result_10chains/node381_7_2.txt 83"
    "./result_10chains/node381_8_0.txt 82"
    "./result_10chains/node381_8_2.txt 82"
    "./result_10chains/node381_9_0.txt 81"
    "./result_10chains/node381_9_2.txt 81"
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
