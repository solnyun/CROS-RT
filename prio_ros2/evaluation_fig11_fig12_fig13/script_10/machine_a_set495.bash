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
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_2 -p 13 -st topic495_0_1 -pt None -u 0.01863515091273088 > ./result_10chains/node495_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_2 -p 54 -st topic495_1_1 -pt None -u 0.018192468048776278 > ./result_10chains/node495_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_2 -p 77 -st topic495_2_1 -pt None -u 0.009641961117357156 > ./result_10chains/node495_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_2 -p 105 -st topic495_3_1 -pt None -u 0.0045458091096743924 > ./result_10chains/node495_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_2 -p 176 -st topic495_4_1 -pt None -u 0.011044987540321183 > ./result_10chains/node495_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_2 -p 266 -st topic495_5_1 -pt None -u 0.00011807334864508134 > ./result_10chains/node495_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_2 -p 335 -st topic495_6_1 -pt None -u 0.05028168862903401 > ./result_10chains/node495_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_2 -p 541 -st topic495_7_1 -pt None -u 0.02662841079657452 > ./result_10chains/node495_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_8_2 -p 799 -st topic495_8_1 -pt None -u 0.03128755569594226 > ./result_10chains/node495_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_9_2 -p 947 -st topic495_9_1 -pt None -u 0.009803499484909823 > ./result_10chains/node495_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_0 -p 13 -st none -pt topic495_0_0 -u 0.027977063185359807 > ./result_10chains/node495_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_0 -p 54 -st none -pt topic495_1_0 -u 0.0012798036956278014 > ./result_10chains/node495_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_0 -p 77 -st none -pt topic495_2_0 -u 0.0017935699394233118 > ./result_10chains/node495_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_0 -p 105 -st none -pt topic495_3_0 -u 0.017356476359693507 > ./result_10chains/node495_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_0 -p 176 -st none -pt topic495_4_0 -u 0.018989565551052356 > ./result_10chains/node495_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_0 -p 266 -st none -pt topic495_5_0 -u 0.01743576403871122 > ./result_10chains/node495_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_0 -p 335 -st none -pt topic495_6_0 -u 0.010130745068308328 > ./result_10chains/node495_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_0 -p 541 -st none -pt topic495_7_0 -u 0.039811891807007116 > ./result_10chains/node495_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_8_0 -p 799 -st none -pt topic495_8_0 -u 0.026784109781695903 > ./result_10chains/node495_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_9_0 -p 947 -st none -pt topic495_9_0 -u 0.004511095295229951 > ./result_10chains/node495_9_0.txt &
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
    "./result_10chains/node495_0_0.txt 90"
    "./result_10chains/node495_0_2.txt 90"
    "./result_10chains/node495_1_0.txt 89"
    "./result_10chains/node495_1_2.txt 89"
    "./result_10chains/node495_2_0.txt 88"
    "./result_10chains/node495_2_2.txt 88"
    "./result_10chains/node495_3_0.txt 87"
    "./result_10chains/node495_3_2.txt 87"
    "./result_10chains/node495_4_0.txt 86"
    "./result_10chains/node495_4_2.txt 86"
    "./result_10chains/node495_5_0.txt 85"
    "./result_10chains/node495_5_2.txt 85"
    "./result_10chains/node495_6_0.txt 84"
    "./result_10chains/node495_6_2.txt 84"
    "./result_10chains/node495_7_0.txt 83"
    "./result_10chains/node495_7_2.txt 83"
    "./result_10chains/node495_8_0.txt 82"
    "./result_10chains/node495_8_2.txt 82"
    "./result_10chains/node495_9_0.txt 81"
    "./result_10chains/node495_9_2.txt 81"
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
