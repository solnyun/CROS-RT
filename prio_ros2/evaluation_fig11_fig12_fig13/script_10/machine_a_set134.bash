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
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_2 -p 143 -st topic134_0_1 -pt None -u 0.003956021266181997 > ./result_10chains/node134_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_2 -p 171 -st topic134_1_1 -pt None -u 0.0034200780963125066 > ./result_10chains/node134_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_2 -p 490 -st topic134_2_1 -pt None -u 0.005581537334262587 > ./result_10chains/node134_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_2 -p 530 -st topic134_3_1 -pt None -u 0.009565519476629702 > ./result_10chains/node134_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_2 -p 533 -st topic134_4_1 -pt None -u 0.021874995145321596 > ./result_10chains/node134_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_2 -p 779 -st topic134_5_1 -pt None -u 0.05307897565467365 > ./result_10chains/node134_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_2 -p 793 -st topic134_6_1 -pt None -u 0.009487691590353037 > ./result_10chains/node134_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_2 -p 838 -st topic134_7_1 -pt None -u 0.036892933449860055 > ./result_10chains/node134_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_8_2 -p 958 -st topic134_8_1 -pt None -u 0.0182416785750043 > ./result_10chains/node134_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_9_2 -p 985 -st topic134_9_1 -pt None -u 0.002674463042371646 > ./result_10chains/node134_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_0 -p 143 -st none -pt topic134_0_0 -u 0.012885971985161504 > ./result_10chains/node134_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_0 -p 171 -st none -pt topic134_1_0 -u 0.004737153187273302 > ./result_10chains/node134_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_0 -p 490 -st none -pt topic134_2_0 -u 0.007366389108783011 > ./result_10chains/node134_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_0 -p 530 -st none -pt topic134_3_0 -u 0.004915013830223358 > ./result_10chains/node134_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_0 -p 533 -st none -pt topic134_4_0 -u 0.0520261065915365 > ./result_10chains/node134_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_0 -p 779 -st none -pt topic134_5_0 -u 0.019141082063993065 > ./result_10chains/node134_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_0 -p 793 -st none -pt topic134_6_0 -u 0.005719033977263616 > ./result_10chains/node134_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_0 -p 838 -st none -pt topic134_7_0 -u 0.01665359603001798 > ./result_10chains/node134_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_8_0 -p 958 -st none -pt topic134_8_0 -u 0.014004949994988483 > ./result_10chains/node134_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_9_0 -p 985 -st none -pt topic134_9_0 -u 0.0549485763556045 > ./result_10chains/node134_9_0.txt &
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
    "./result_10chains/node134_0_0.txt 90"
    "./result_10chains/node134_0_2.txt 90"
    "./result_10chains/node134_1_0.txt 89"
    "./result_10chains/node134_1_2.txt 89"
    "./result_10chains/node134_2_0.txt 88"
    "./result_10chains/node134_2_2.txt 88"
    "./result_10chains/node134_3_0.txt 87"
    "./result_10chains/node134_3_2.txt 87"
    "./result_10chains/node134_4_0.txt 86"
    "./result_10chains/node134_4_2.txt 86"
    "./result_10chains/node134_5_0.txt 85"
    "./result_10chains/node134_5_2.txt 85"
    "./result_10chains/node134_6_0.txt 84"
    "./result_10chains/node134_6_2.txt 84"
    "./result_10chains/node134_7_0.txt 83"
    "./result_10chains/node134_7_2.txt 83"
    "./result_10chains/node134_8_0.txt 82"
    "./result_10chains/node134_8_2.txt 82"
    "./result_10chains/node134_9_0.txt 81"
    "./result_10chains/node134_9_2.txt 81"
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
