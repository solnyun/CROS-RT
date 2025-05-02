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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_2 -p 22 -st topic20_0_1 -pt None -u 0.01454747619097424 > ./result_10chains/node20_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_2 -p 55 -st topic20_1_1 -pt None -u 0.04360476928662199 > ./result_10chains/node20_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_2 -p 284 -st topic20_2_1 -pt None -u 0.0132683815545791 > ./result_10chains/node20_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_2 -p 591 -st topic20_3_1 -pt None -u 0.054762987222786164 > ./result_10chains/node20_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_2 -p 684 -st topic20_4_1 -pt None -u 0.01581939391483092 > ./result_10chains/node20_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_2 -p 730 -st topic20_5_1 -pt None -u 0.026544563399560378 > ./result_10chains/node20_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_2 -p 789 -st topic20_6_1 -pt None -u 0.05402278714751732 > ./result_10chains/node20_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_2 -p 851 -st topic20_7_1 -pt None -u 0.0031290171190828664 > ./result_10chains/node20_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_8_2 -p 872 -st topic20_8_1 -pt None -u 0.018447034757880322 > ./result_10chains/node20_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_9_2 -p 901 -st topic20_9_1 -pt None -u 0.008448563914866989 > ./result_10chains/node20_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_0 -p 22 -st none -pt topic20_0_0 -u 0.011144029103121345 > ./result_10chains/node20_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_0 -p 55 -st none -pt topic20_1_0 -u 0.003990444170263618 > ./result_10chains/node20_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_0 -p 284 -st none -pt topic20_2_0 -u 0.0035133542498468895 > ./result_10chains/node20_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_0 -p 591 -st none -pt topic20_3_0 -u 0.0203329938079293 > ./result_10chains/node20_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_0 -p 684 -st none -pt topic20_4_0 -u 0.0004052733118008467 > ./result_10chains/node20_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_0 -p 730 -st none -pt topic20_5_0 -u 0.011107763096034035 > ./result_10chains/node20_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_0 -p 789 -st none -pt topic20_6_0 -u 0.008249118372156722 > ./result_10chains/node20_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_0 -p 851 -st none -pt topic20_7_0 -u 0.02245589403406291 > ./result_10chains/node20_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_8_0 -p 872 -st none -pt topic20_8_0 -u 0.034246917148658046 > ./result_10chains/node20_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_9_0 -p 901 -st none -pt topic20_9_0 -u 0.011224357226325695 > ./result_10chains/node20_9_0.txt &
sleep 10
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
    "./result_10chains/node20_0_0.txt 90"
    "./result_10chains/node20_0_2.txt 90"
    "./result_10chains/node20_1_0.txt 89"
    "./result_10chains/node20_1_2.txt 89"
    "./result_10chains/node20_2_0.txt 88"
    "./result_10chains/node20_2_2.txt 88"
    "./result_10chains/node20_3_0.txt 87"
    "./result_10chains/node20_3_2.txt 87"
    "./result_10chains/node20_4_0.txt 86"
    "./result_10chains/node20_4_2.txt 86"
    "./result_10chains/node20_5_0.txt 85"
    "./result_10chains/node20_5_2.txt 85"
    "./result_10chains/node20_6_0.txt 84"
    "./result_10chains/node20_6_2.txt 84"
    "./result_10chains/node20_7_0.txt 83"
    "./result_10chains/node20_7_2.txt 83"
    "./result_10chains/node20_8_0.txt 82"
    "./result_10chains/node20_8_2.txt 82"
    "./result_10chains/node20_9_0.txt 81"
    "./result_10chains/node20_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
