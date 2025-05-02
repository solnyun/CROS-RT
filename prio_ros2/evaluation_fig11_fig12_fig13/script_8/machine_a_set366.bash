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
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_2 -p 45 -st topic366_0_1 -pt None -u 0.01308381920812135 > ./result_8chains/node366_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_2 -p 300 -st topic366_1_1 -pt None -u 0.08003402822177003 > ./result_8chains/node366_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_2 -p 377 -st topic366_2_1 -pt None -u 0.05677041969440155 > ./result_8chains/node366_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_2 -p 403 -st topic366_3_1 -pt None -u 0.045159854053876236 > ./result_8chains/node366_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_2 -p 617 -st topic366_4_1 -pt None -u 0.00783500399680745 > ./result_8chains/node366_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_2 -p 648 -st topic366_5_1 -pt None -u 0.023313805192004294 > ./result_8chains/node366_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_6_2 -p 895 -st topic366_6_1 -pt None -u 0.01451705182401769 > ./result_8chains/node366_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_7_2 -p 995 -st topic366_7_1 -pt None -u 0.020104117339102993 > ./result_8chains/node366_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_0 -p 45 -st none -pt topic366_0_0 -u 0.016736923813731208 > ./result_8chains/node366_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_0 -p 300 -st none -pt topic366_1_0 -u 0.005925360198050067 > ./result_8chains/node366_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_0 -p 377 -st none -pt topic366_2_0 -u 0.008412855417319565 > ./result_8chains/node366_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_0 -p 403 -st none -pt topic366_3_0 -u 0.020338501111360235 > ./result_8chains/node366_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_0 -p 617 -st none -pt topic366_4_0 -u 0.001398848331039232 > ./result_8chains/node366_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_0 -p 648 -st none -pt topic366_5_0 -u 0.012889217318123813 > ./result_8chains/node366_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_6_0 -p 895 -st none -pt topic366_6_0 -u 0.001277694366939905 > ./result_8chains/node366_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_7_0 -p 995 -st none -pt topic366_7_0 -u 0.026226372325305072 > ./result_8chains/node366_7_0.txt &
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
    "./result_8chains/node366_0_0.txt 90"
    "./result_8chains/node366_0_2.txt 90"
    "./result_8chains/node366_1_0.txt 89"
    "./result_8chains/node366_1_2.txt 89"
    "./result_8chains/node366_2_0.txt 88"
    "./result_8chains/node366_2_2.txt 88"
    "./result_8chains/node366_3_0.txt 87"
    "./result_8chains/node366_3_2.txt 87"
    "./result_8chains/node366_4_0.txt 86"
    "./result_8chains/node366_4_2.txt 86"
    "./result_8chains/node366_5_0.txt 85"
    "./result_8chains/node366_5_2.txt 85"
    "./result_8chains/node366_6_0.txt 84"
    "./result_8chains/node366_6_2.txt 84"
    "./result_8chains/node366_7_0.txt 83"
    "./result_8chains/node366_7_2.txt 83"
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
