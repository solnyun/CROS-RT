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
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_2 -p 73 -st topic147_0_1 -pt None -u 0.06318395125604098 > ./result_10chains/node147_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_2 -p 125 -st topic147_1_1 -pt None -u 0.07432505930406935 > ./result_10chains/node147_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_2 -p 156 -st topic147_2_1 -pt None -u 0.0137560254001442 > ./result_10chains/node147_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_2 -p 283 -st topic147_3_1 -pt None -u 0.004005190551833182 > ./result_10chains/node147_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_2 -p 394 -st topic147_4_1 -pt None -u 0.008575855875721378 > ./result_10chains/node147_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_2 -p 598 -st topic147_5_1 -pt None -u 0.011884407983993928 > ./result_10chains/node147_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_2 -p 606 -st topic147_6_1 -pt None -u 0.0036889913181286926 > ./result_10chains/node147_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_2 -p 648 -st topic147_7_1 -pt None -u 0.003424349923270162 > ./result_10chains/node147_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_8_2 -p 866 -st topic147_8_1 -pt None -u 0.0065865386453094164 > ./result_10chains/node147_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_9_2 -p 917 -st topic147_9_1 -pt None -u 0.006649115229720911 > ./result_10chains/node147_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_0 -p 73 -st none -pt topic147_0_0 -u 0.010053748483754399 > ./result_10chains/node147_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_0 -p 125 -st none -pt topic147_1_0 -u 0.035949120666951995 > ./result_10chains/node147_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_0 -p 156 -st none -pt topic147_2_0 -u 0.00492524419227619 > ./result_10chains/node147_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_0 -p 283 -st none -pt topic147_3_0 -u 0.037818062290872034 > ./result_10chains/node147_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_0 -p 394 -st none -pt topic147_4_0 -u 0.011194927925523929 > ./result_10chains/node147_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_0 -p 598 -st none -pt topic147_5_0 -u 0.009004100727604436 > ./result_10chains/node147_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_0 -p 606 -st none -pt topic147_6_0 -u 0.008223254594181217 > ./result_10chains/node147_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_0 -p 648 -st none -pt topic147_7_0 -u 0.02297104552052083 > ./result_10chains/node147_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_8_0 -p 866 -st none -pt topic147_8_0 -u 0.0007349042041384229 > ./result_10chains/node147_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_9_0 -p 917 -st none -pt topic147_9_0 -u 0.0028517846813067814 > ./result_10chains/node147_9_0.txt &
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
    "./result_10chains/node147_0_0.txt 90"
    "./result_10chains/node147_0_2.txt 90"
    "./result_10chains/node147_1_0.txt 89"
    "./result_10chains/node147_1_2.txt 89"
    "./result_10chains/node147_2_0.txt 88"
    "./result_10chains/node147_2_2.txt 88"
    "./result_10chains/node147_3_0.txt 87"
    "./result_10chains/node147_3_2.txt 87"
    "./result_10chains/node147_4_0.txt 86"
    "./result_10chains/node147_4_2.txt 86"
    "./result_10chains/node147_5_0.txt 85"
    "./result_10chains/node147_5_2.txt 85"
    "./result_10chains/node147_6_0.txt 84"
    "./result_10chains/node147_6_2.txt 84"
    "./result_10chains/node147_7_0.txt 83"
    "./result_10chains/node147_7_2.txt 83"
    "./result_10chains/node147_8_0.txt 82"
    "./result_10chains/node147_8_2.txt 82"
    "./result_10chains/node147_9_0.txt 81"
    "./result_10chains/node147_9_2.txt 81"
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
