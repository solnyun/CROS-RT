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
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_2 -p 211 -st topic474_0_1 -pt None -u 0.0021082832487863135 > ./result_10chains/node474_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_2 -p 274 -st topic474_1_1 -pt None -u 0.009194882438102736 > ./result_10chains/node474_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_2 -p 277 -st topic474_2_1 -pt None -u 0.004188308786203743 > ./result_10chains/node474_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_2 -p 299 -st topic474_3_1 -pt None -u 0.002293734620003318 > ./result_10chains/node474_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_2 -p 347 -st topic474_4_1 -pt None -u 0.030559839085121776 > ./result_10chains/node474_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_2 -p 439 -st topic474_5_1 -pt None -u 0.04577359359058247 > ./result_10chains/node474_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_6_2 -p 450 -st topic474_6_1 -pt None -u 0.0035668556881399416 > ./result_10chains/node474_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_7_2 -p 487 -st topic474_7_1 -pt None -u 0.044806652008389763 > ./result_10chains/node474_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_8_2 -p 621 -st topic474_8_1 -pt None -u 0.012918036782918953 > ./result_10chains/node474_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_9_2 -p 913 -st topic474_9_1 -pt None -u 0.0036124514479524837 > ./result_10chains/node474_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_0 -p 211 -st none -pt topic474_0_0 -u 0.0438394356312522 > ./result_10chains/node474_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_0 -p 274 -st none -pt topic474_1_0 -u 0.04071659053127458 > ./result_10chains/node474_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_0 -p 277 -st none -pt topic474_2_0 -u 0.0070989247976944725 > ./result_10chains/node474_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_0 -p 299 -st none -pt topic474_3_0 -u 0.030133097910275686 > ./result_10chains/node474_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_0 -p 347 -st none -pt topic474_4_0 -u 0.004749191026832911 > ./result_10chains/node474_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_0 -p 439 -st none -pt topic474_5_0 -u 0.0021520340599201493 > ./result_10chains/node474_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_6_0 -p 450 -st none -pt topic474_6_0 -u 0.012233095131891691 > ./result_10chains/node474_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_7_0 -p 487 -st none -pt topic474_7_0 -u 0.002241629656778571 > ./result_10chains/node474_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_8_0 -p 621 -st none -pt topic474_8_0 -u 0.048820484870858626 > ./result_10chains/node474_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_9_0 -p 913 -st none -pt topic474_9_0 -u 0.01417206934575977 > ./result_10chains/node474_9_0.txt &
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
    "./result_10chains/node474_0_0.txt 90"
    "./result_10chains/node474_0_2.txt 90"
    "./result_10chains/node474_1_0.txt 89"
    "./result_10chains/node474_1_2.txt 89"
    "./result_10chains/node474_2_0.txt 88"
    "./result_10chains/node474_2_2.txt 88"
    "./result_10chains/node474_3_0.txt 87"
    "./result_10chains/node474_3_2.txt 87"
    "./result_10chains/node474_4_0.txt 86"
    "./result_10chains/node474_4_2.txt 86"
    "./result_10chains/node474_5_0.txt 85"
    "./result_10chains/node474_5_2.txt 85"
    "./result_10chains/node474_6_0.txt 84"
    "./result_10chains/node474_6_2.txt 84"
    "./result_10chains/node474_7_0.txt 83"
    "./result_10chains/node474_7_2.txt 83"
    "./result_10chains/node474_8_0.txt 82"
    "./result_10chains/node474_8_2.txt 82"
    "./result_10chains/node474_9_0.txt 81"
    "./result_10chains/node474_9_2.txt 81"
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
