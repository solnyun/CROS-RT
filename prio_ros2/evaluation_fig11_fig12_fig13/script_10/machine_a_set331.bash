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
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_2 -p 208 -st topic331_0_1 -pt None -u 0.008331312489740672 > ./result_10chains/node331_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_2 -p 252 -st topic331_1_1 -pt None -u 0.004618815293949641 > ./result_10chains/node331_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_2 -p 399 -st topic331_2_1 -pt None -u 0.006420120978862465 > ./result_10chains/node331_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_2 -p 494 -st topic331_3_1 -pt None -u 0.0011693646686202208 > ./result_10chains/node331_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_2 -p 528 -st topic331_4_1 -pt None -u 0.020717605252248916 > ./result_10chains/node331_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_2 -p 682 -st topic331_5_1 -pt None -u 0.0293893655046219 > ./result_10chains/node331_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_2 -p 866 -st topic331_6_1 -pt None -u 0.02815318217209664 > ./result_10chains/node331_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_2 -p 902 -st topic331_7_1 -pt None -u 0.03631042718786498 > ./result_10chains/node331_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_8_2 -p 938 -st topic331_8_1 -pt None -u 0.045976686800057315 > ./result_10chains/node331_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_9_2 -p 948 -st topic331_9_1 -pt None -u 0.0028946319104091018 > ./result_10chains/node331_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_0 -p 208 -st none -pt topic331_0_0 -u 0.02631183024036715 > ./result_10chains/node331_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_0 -p 252 -st none -pt topic331_1_0 -u 0.02207416778291532 > ./result_10chains/node331_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_0 -p 399 -st none -pt topic331_2_0 -u 0.004121579580755652 > ./result_10chains/node331_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_0 -p 494 -st none -pt topic331_3_0 -u 0.006790026353086065 > ./result_10chains/node331_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_0 -p 528 -st none -pt topic331_4_0 -u 0.003929306394218568 > ./result_10chains/node331_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_0 -p 682 -st none -pt topic331_5_0 -u 0.00956573541934952 > ./result_10chains/node331_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_0 -p 866 -st none -pt topic331_6_0 -u 0.00027312123740941274 > ./result_10chains/node331_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_0 -p 902 -st none -pt topic331_7_0 -u 0.00550857685496306 > ./result_10chains/node331_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_8_0 -p 938 -st none -pt topic331_8_0 -u 0.005725819527229226 > ./result_10chains/node331_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_9_0 -p 948 -st none -pt topic331_9_0 -u 0.03595917745059518 > ./result_10chains/node331_9_0.txt &
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
    "./result_10chains/node331_0_0.txt 90"
    "./result_10chains/node331_0_2.txt 90"
    "./result_10chains/node331_1_0.txt 89"
    "./result_10chains/node331_1_2.txt 89"
    "./result_10chains/node331_2_0.txt 88"
    "./result_10chains/node331_2_2.txt 88"
    "./result_10chains/node331_3_0.txt 87"
    "./result_10chains/node331_3_2.txt 87"
    "./result_10chains/node331_4_0.txt 86"
    "./result_10chains/node331_4_2.txt 86"
    "./result_10chains/node331_5_0.txt 85"
    "./result_10chains/node331_5_2.txt 85"
    "./result_10chains/node331_6_0.txt 84"
    "./result_10chains/node331_6_2.txt 84"
    "./result_10chains/node331_7_0.txt 83"
    "./result_10chains/node331_7_2.txt 83"
    "./result_10chains/node331_8_0.txt 82"
    "./result_10chains/node331_8_2.txt 82"
    "./result_10chains/node331_9_0.txt 81"
    "./result_10chains/node331_9_2.txt 81"
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
