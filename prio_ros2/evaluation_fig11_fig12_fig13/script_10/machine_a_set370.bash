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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_2 -p 54 -st topic370_0_1 -pt None -u 0.026158821138090205 > ./result_10chains/node370_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_2 -p 223 -st topic370_1_1 -pt None -u 0.06658535953297723 > ./result_10chains/node370_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_2 -p 345 -st topic370_2_1 -pt None -u 0.0024798242149208227 > ./result_10chains/node370_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_2 -p 351 -st topic370_3_1 -pt None -u 0.018659464344428334 > ./result_10chains/node370_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_2 -p 458 -st topic370_4_1 -pt None -u 0.03764948344583069 > ./result_10chains/node370_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_2 -p 482 -st topic370_5_1 -pt None -u 0.00037041939155826875 > ./result_10chains/node370_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_2 -p 543 -st topic370_6_1 -pt None -u 0.025816759623825306 > ./result_10chains/node370_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_2 -p 616 -st topic370_7_1 -pt None -u 0.008849641898271698 > ./result_10chains/node370_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_8_2 -p 629 -st topic370_8_1 -pt None -u 0.003144481728576981 > ./result_10chains/node370_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_9_2 -p 742 -st topic370_9_1 -pt None -u 0.018271045447994506 > ./result_10chains/node370_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_0 -p 54 -st none -pt topic370_0_0 -u 0.004343851368376339 > ./result_10chains/node370_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_0 -p 223 -st none -pt topic370_1_0 -u 0.01427929259565841 > ./result_10chains/node370_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_0 -p 345 -st none -pt topic370_2_0 -u 0.01414077688547205 > ./result_10chains/node370_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_0 -p 351 -st none -pt topic370_3_0 -u 0.007992114652631888 > ./result_10chains/node370_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_0 -p 458 -st none -pt topic370_4_0 -u 0.008219079019232967 > ./result_10chains/node370_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_0 -p 482 -st none -pt topic370_5_0 -u 0.0006889202552644025 > ./result_10chains/node370_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_0 -p 543 -st none -pt topic370_6_0 -u 0.0037339441829739306 > ./result_10chains/node370_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_0 -p 616 -st none -pt topic370_7_0 -u 0.023531144224025982 > ./result_10chains/node370_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_8_0 -p 629 -st none -pt topic370_8_0 -u 0.013891797985102143 > ./result_10chains/node370_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_9_0 -p 742 -st none -pt topic370_9_0 -u 0.00882929640639285 > ./result_10chains/node370_9_0.txt &
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
    "./result_10chains/node370_0_0.txt 90"
    "./result_10chains/node370_0_2.txt 90"
    "./result_10chains/node370_1_0.txt 89"
    "./result_10chains/node370_1_2.txt 89"
    "./result_10chains/node370_2_0.txt 88"
    "./result_10chains/node370_2_2.txt 88"
    "./result_10chains/node370_3_0.txt 87"
    "./result_10chains/node370_3_2.txt 87"
    "./result_10chains/node370_4_0.txt 86"
    "./result_10chains/node370_4_2.txt 86"
    "./result_10chains/node370_5_0.txt 85"
    "./result_10chains/node370_5_2.txt 85"
    "./result_10chains/node370_6_0.txt 84"
    "./result_10chains/node370_6_2.txt 84"
    "./result_10chains/node370_7_0.txt 83"
    "./result_10chains/node370_7_2.txt 83"
    "./result_10chains/node370_8_0.txt 82"
    "./result_10chains/node370_8_2.txt 82"
    "./result_10chains/node370_9_0.txt 81"
    "./result_10chains/node370_9_2.txt 81"
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
