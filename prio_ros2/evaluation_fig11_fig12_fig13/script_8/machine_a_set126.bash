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
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_2 -p 24 -st topic126_0_1 -pt None -u 0.008574921756947185 > ./result_8chains/node126_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_2 -p 154 -st topic126_1_1 -pt None -u 0.002110751720580284 > ./result_8chains/node126_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_2 -p 167 -st topic126_2_1 -pt None -u 0.01688272679688957 > ./result_8chains/node126_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_2 -p 220 -st topic126_3_1 -pt None -u 0.00386066908410182 > ./result_8chains/node126_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_2 -p 362 -st topic126_4_1 -pt None -u 0.012460628548337238 > ./result_8chains/node126_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_2 -p 479 -st topic126_5_1 -pt None -u 0.014163601214631838 > ./result_8chains/node126_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_2 -p 883 -st topic126_6_1 -pt None -u 0.0520361249927984 > ./result_8chains/node126_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_2 -p 921 -st topic126_7_1 -pt None -u 0.028702464184764378 > ./result_8chains/node126_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_0 -p 24 -st none -pt topic126_0_0 -u 0.017519391755665137 > ./result_8chains/node126_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_0 -p 154 -st none -pt topic126_1_0 -u 0.01369099364378934 > ./result_8chains/node126_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_0 -p 167 -st none -pt topic126_2_0 -u 0.019319280484842938 > ./result_8chains/node126_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_0 -p 220 -st none -pt topic126_3_0 -u 0.03004816124582682 > ./result_8chains/node126_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_0 -p 362 -st none -pt topic126_4_0 -u 0.0563875109176776 > ./result_8chains/node126_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_0 -p 479 -st none -pt topic126_5_0 -u 0.01356010142446501 > ./result_8chains/node126_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_0 -p 883 -st none -pt topic126_6_0 -u 0.0037321029663043015 > ./result_8chains/node126_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_0 -p 921 -st none -pt topic126_7_0 -u 0.04358967117247433 > ./result_8chains/node126_7_0.txt &
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
    "./result_8chains/node126_0_0.txt 90"
    "./result_8chains/node126_0_2.txt 90"
    "./result_8chains/node126_1_0.txt 89"
    "./result_8chains/node126_1_2.txt 89"
    "./result_8chains/node126_2_0.txt 88"
    "./result_8chains/node126_2_2.txt 88"
    "./result_8chains/node126_3_0.txt 87"
    "./result_8chains/node126_3_2.txt 87"
    "./result_8chains/node126_4_0.txt 86"
    "./result_8chains/node126_4_2.txt 86"
    "./result_8chains/node126_5_0.txt 85"
    "./result_8chains/node126_5_2.txt 85"
    "./result_8chains/node126_6_0.txt 84"
    "./result_8chains/node126_6_2.txt 84"
    "./result_8chains/node126_7_0.txt 83"
    "./result_8chains/node126_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
