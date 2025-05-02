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
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_2 -p 25 -st topic89_0_1 -pt None -u 0.002549673386745499 > ./result_10chains/node89_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_2 -p 27 -st topic89_1_1 -pt None -u 0.019018812204781577 > ./result_10chains/node89_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_2 -p 50 -st topic89_2_1 -pt None -u 0.012682379398218924 > ./result_10chains/node89_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_2 -p 135 -st topic89_3_1 -pt None -u 0.020243971837050678 > ./result_10chains/node89_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_2 -p 473 -st topic89_4_1 -pt None -u 0.027105162219409035 > ./result_10chains/node89_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_2 -p 509 -st topic89_5_1 -pt None -u 0.020776653623194224 > ./result_10chains/node89_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_6_2 -p 521 -st topic89_6_1 -pt None -u 0.013840718080603512 > ./result_10chains/node89_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_7_2 -p 523 -st topic89_7_1 -pt None -u 0.005778397362998691 > ./result_10chains/node89_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_8_2 -p 695 -st topic89_8_1 -pt None -u 0.01768324145337239 > ./result_10chains/node89_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_9_2 -p 974 -st topic89_9_1 -pt None -u 0.002248236713932331 > ./result_10chains/node89_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_0 -p 25 -st none -pt topic89_0_0 -u 0.043891083490273375 > ./result_10chains/node89_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_0 -p 27 -st none -pt topic89_1_0 -u 0.03940060277712332 > ./result_10chains/node89_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_0 -p 50 -st none -pt topic89_2_0 -u 0.005349895465887655 > ./result_10chains/node89_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_0 -p 135 -st none -pt topic89_3_0 -u 0.010720846181345667 > ./result_10chains/node89_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_0 -p 473 -st none -pt topic89_4_0 -u 0.03978255861128349 > ./result_10chains/node89_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_0 -p 509 -st none -pt topic89_5_0 -u 0.012106331020351191 > ./result_10chains/node89_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_6_0 -p 521 -st none -pt topic89_6_0 -u 0.0031829741817371027 > ./result_10chains/node89_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_7_0 -p 523 -st none -pt topic89_7_0 -u 0.022927336709999163 > ./result_10chains/node89_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_8_0 -p 695 -st none -pt topic89_8_0 -u 0.05668828512766147 > ./result_10chains/node89_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_9_0 -p 974 -st none -pt topic89_9_0 -u 0.001350347464619879 > ./result_10chains/node89_9_0.txt &
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
    "./result_10chains/node89_0_0.txt 90"
    "./result_10chains/node89_0_2.txt 90"
    "./result_10chains/node89_1_0.txt 89"
    "./result_10chains/node89_1_2.txt 89"
    "./result_10chains/node89_2_0.txt 88"
    "./result_10chains/node89_2_2.txt 88"
    "./result_10chains/node89_3_0.txt 87"
    "./result_10chains/node89_3_2.txt 87"
    "./result_10chains/node89_4_0.txt 86"
    "./result_10chains/node89_4_2.txt 86"
    "./result_10chains/node89_5_0.txt 85"
    "./result_10chains/node89_5_2.txt 85"
    "./result_10chains/node89_6_0.txt 84"
    "./result_10chains/node89_6_2.txt 84"
    "./result_10chains/node89_7_0.txt 83"
    "./result_10chains/node89_7_2.txt 83"
    "./result_10chains/node89_8_0.txt 82"
    "./result_10chains/node89_8_2.txt 82"
    "./result_10chains/node89_9_0.txt 81"
    "./result_10chains/node89_9_2.txt 81"
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
