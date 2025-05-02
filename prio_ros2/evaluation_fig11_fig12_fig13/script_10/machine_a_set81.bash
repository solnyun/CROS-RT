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
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_2 -p 65 -st topic81_0_1 -pt None -u 0.000566766144241837 > ./result_10chains/node81_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_2 -p 176 -st topic81_1_1 -pt None -u 0.005872586403172231 > ./result_10chains/node81_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_2 -p 320 -st topic81_2_1 -pt None -u 0.04087705691616966 > ./result_10chains/node81_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_2 -p 356 -st topic81_3_1 -pt None -u 0.008621346395318308 > ./result_10chains/node81_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_2 -p 702 -st topic81_4_1 -pt None -u 0.0008118336372385238 > ./result_10chains/node81_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_2 -p 746 -st topic81_5_1 -pt None -u 0.00011763310916726444 > ./result_10chains/node81_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_2 -p 813 -st topic81_6_1 -pt None -u 0.04097263447991639 > ./result_10chains/node81_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_2 -p 905 -st topic81_7_1 -pt None -u 9.432575404571403e-05 > ./result_10chains/node81_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_8_2 -p 956 -st topic81_8_1 -pt None -u 0.00417879545938598 > ./result_10chains/node81_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_9_2 -p 970 -st topic81_9_1 -pt None -u 0.0009623279998713061 > ./result_10chains/node81_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_0 -p 65 -st none -pt topic81_0_0 -u 0.008404754097643019 > ./result_10chains/node81_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_0 -p 176 -st none -pt topic81_1_0 -u 0.0008555410608792058 > ./result_10chains/node81_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_0 -p 320 -st none -pt topic81_2_0 -u 0.009814124258946788 > ./result_10chains/node81_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_0 -p 356 -st none -pt topic81_3_0 -u 0.02711727983490042 > ./result_10chains/node81_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_0 -p 702 -st none -pt topic81_4_0 -u 0.023199962138285568 > ./result_10chains/node81_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_0 -p 746 -st none -pt topic81_5_0 -u 0.011661474566060981 > ./result_10chains/node81_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_0 -p 813 -st none -pt topic81_6_0 -u 0.06883328405647098 > ./result_10chains/node81_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_0 -p 905 -st none -pt topic81_7_0 -u 0.009884084425622788 > ./result_10chains/node81_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_8_0 -p 956 -st none -pt topic81_8_0 -u 0.002136067313914157 > ./result_10chains/node81_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_9_0 -p 970 -st none -pt topic81_9_0 -u 0.029881653070949164 > ./result_10chains/node81_9_0.txt &
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
    "./result_10chains/node81_0_0.txt 90"
    "./result_10chains/node81_0_2.txt 90"
    "./result_10chains/node81_1_0.txt 89"
    "./result_10chains/node81_1_2.txt 89"
    "./result_10chains/node81_2_0.txt 88"
    "./result_10chains/node81_2_2.txt 88"
    "./result_10chains/node81_3_0.txt 87"
    "./result_10chains/node81_3_2.txt 87"
    "./result_10chains/node81_4_0.txt 86"
    "./result_10chains/node81_4_2.txt 86"
    "./result_10chains/node81_5_0.txt 85"
    "./result_10chains/node81_5_2.txt 85"
    "./result_10chains/node81_6_0.txt 84"
    "./result_10chains/node81_6_2.txt 84"
    "./result_10chains/node81_7_0.txt 83"
    "./result_10chains/node81_7_2.txt 83"
    "./result_10chains/node81_8_0.txt 82"
    "./result_10chains/node81_8_2.txt 82"
    "./result_10chains/node81_9_0.txt 81"
    "./result_10chains/node81_9_2.txt 81"
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
