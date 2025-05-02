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
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_2 -p 75 -st topic272_0_1 -pt None -u 0.002138924513920726 > ./result_10chains/node272_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_2 -p 80 -st topic272_1_1 -pt None -u 0.0016287289926361637 > ./result_10chains/node272_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_2 -p 151 -st topic272_2_1 -pt None -u 0.022606642711512914 > ./result_10chains/node272_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_2 -p 217 -st topic272_3_1 -pt None -u 0.059066600009693104 > ./result_10chains/node272_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_2 -p 227 -st topic272_4_1 -pt None -u 0.016568348959968227 > ./result_10chains/node272_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_2 -p 253 -st topic272_5_1 -pt None -u 0.016830385765811973 > ./result_10chains/node272_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_2 -p 473 -st topic272_6_1 -pt None -u 0.002514855828426199 > ./result_10chains/node272_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_2 -p 523 -st topic272_7_1 -pt None -u 0.027175968468675704 > ./result_10chains/node272_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_8_2 -p 749 -st topic272_8_1 -pt None -u 0.019363033813364676 > ./result_10chains/node272_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_9_2 -p 871 -st topic272_9_1 -pt None -u 0.0038282594556975254 > ./result_10chains/node272_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_0 -p 75 -st none -pt topic272_0_0 -u 0.024475334779723468 > ./result_10chains/node272_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_0 -p 80 -st none -pt topic272_1_0 -u 0.002368185091781827 > ./result_10chains/node272_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_0 -p 151 -st none -pt topic272_2_0 -u 0.0016560251238995627 > ./result_10chains/node272_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_0 -p 217 -st none -pt topic272_3_0 -u 0.05097630509223189 > ./result_10chains/node272_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_0 -p 227 -st none -pt topic272_4_0 -u 0.059778139488854076 > ./result_10chains/node272_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_0 -p 253 -st none -pt topic272_5_0 -u 0.0016501653670642213 > ./result_10chains/node272_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_0 -p 473 -st none -pt topic272_6_0 -u 0.0028375410692773606 > ./result_10chains/node272_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_0 -p 523 -st none -pt topic272_7_0 -u 0.0029894092241812414 > ./result_10chains/node272_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_8_0 -p 749 -st none -pt topic272_8_0 -u 0.0119212568944903 > ./result_10chains/node272_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_9_0 -p 871 -st none -pt topic272_9_0 -u 0.00196546097463696 > ./result_10chains/node272_9_0.txt &
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
    "./result_10chains/node272_0_0.txt 90"
    "./result_10chains/node272_0_2.txt 90"
    "./result_10chains/node272_1_0.txt 89"
    "./result_10chains/node272_1_2.txt 89"
    "./result_10chains/node272_2_0.txt 88"
    "./result_10chains/node272_2_2.txt 88"
    "./result_10chains/node272_3_0.txt 87"
    "./result_10chains/node272_3_2.txt 87"
    "./result_10chains/node272_4_0.txt 86"
    "./result_10chains/node272_4_2.txt 86"
    "./result_10chains/node272_5_0.txt 85"
    "./result_10chains/node272_5_2.txt 85"
    "./result_10chains/node272_6_0.txt 84"
    "./result_10chains/node272_6_2.txt 84"
    "./result_10chains/node272_7_0.txt 83"
    "./result_10chains/node272_7_2.txt 83"
    "./result_10chains/node272_8_0.txt 82"
    "./result_10chains/node272_8_2.txt 82"
    "./result_10chains/node272_9_0.txt 81"
    "./result_10chains/node272_9_2.txt 81"
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
