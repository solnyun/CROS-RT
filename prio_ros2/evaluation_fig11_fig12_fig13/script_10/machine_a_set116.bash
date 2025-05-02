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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_2 -p 212 -st topic116_0_1 -pt None -u 0.028673320216011045 > ./result_10chains/node116_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_2 -p 248 -st topic116_1_1 -pt None -u 0.01394977828833277 > ./result_10chains/node116_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_2 -p 263 -st topic116_2_1 -pt None -u 0.0011105337907855728 > ./result_10chains/node116_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_2 -p 308 -st topic116_3_1 -pt None -u 0.030132162387158157 > ./result_10chains/node116_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_2 -p 380 -st topic116_4_1 -pt None -u 0.023108285744527557 > ./result_10chains/node116_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_2 -p 575 -st topic116_5_1 -pt None -u 0.028535175374292954 > ./result_10chains/node116_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_2 -p 748 -st topic116_6_1 -pt None -u 0.019482775090409105 > ./result_10chains/node116_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_2 -p 832 -st topic116_7_1 -pt None -u 0.007036685870151306 > ./result_10chains/node116_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_8_2 -p 836 -st topic116_8_1 -pt None -u 0.02377786836741478 > ./result_10chains/node116_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_9_2 -p 878 -st topic116_9_1 -pt None -u 0.006595607418423084 > ./result_10chains/node116_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_0 -p 212 -st none -pt topic116_0_0 -u 0.020844728537589507 > ./result_10chains/node116_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_0 -p 248 -st none -pt topic116_1_0 -u 0.010812872050692535 > ./result_10chains/node116_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_0 -p 263 -st none -pt topic116_2_0 -u 0.004841870980738294 > ./result_10chains/node116_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_0 -p 308 -st none -pt topic116_3_0 -u 0.07663179046786428 > ./result_10chains/node116_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_0 -p 380 -st none -pt topic116_4_0 -u 0.017488046629046405 > ./result_10chains/node116_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_0 -p 575 -st none -pt topic116_5_0 -u 0.0031930024614437724 > ./result_10chains/node116_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_0 -p 748 -st none -pt topic116_6_0 -u 0.010779910492960176 > ./result_10chains/node116_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_0 -p 832 -st none -pt topic116_7_0 -u 0.01662831265425327 > ./result_10chains/node116_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_8_0 -p 836 -st none -pt topic116_8_0 -u 0.015083563302707867 > ./result_10chains/node116_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_9_0 -p 878 -st none -pt topic116_9_0 -u 0.005070574719388569 > ./result_10chains/node116_9_0.txt &
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
    "./result_10chains/node116_0_0.txt 90"
    "./result_10chains/node116_0_2.txt 90"
    "./result_10chains/node116_1_0.txt 89"
    "./result_10chains/node116_1_2.txt 89"
    "./result_10chains/node116_2_0.txt 88"
    "./result_10chains/node116_2_2.txt 88"
    "./result_10chains/node116_3_0.txt 87"
    "./result_10chains/node116_3_2.txt 87"
    "./result_10chains/node116_4_0.txt 86"
    "./result_10chains/node116_4_2.txt 86"
    "./result_10chains/node116_5_0.txt 85"
    "./result_10chains/node116_5_2.txt 85"
    "./result_10chains/node116_6_0.txt 84"
    "./result_10chains/node116_6_2.txt 84"
    "./result_10chains/node116_7_0.txt 83"
    "./result_10chains/node116_7_2.txt 83"
    "./result_10chains/node116_8_0.txt 82"
    "./result_10chains/node116_8_2.txt 82"
    "./result_10chains/node116_9_0.txt 81"
    "./result_10chains/node116_9_2.txt 81"
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
