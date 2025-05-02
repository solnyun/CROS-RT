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
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_2 -p 76 -st topic52_0_1 -pt None -u 0.020099901550037602 > ./result_8chains/node52_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_2 -p 243 -st topic52_1_1 -pt None -u 0.004590848668309666 > ./result_8chains/node52_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_2 -p 367 -st topic52_2_1 -pt None -u 0.0030828499328809378 > ./result_8chains/node52_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_2 -p 496 -st topic52_3_1 -pt None -u 0.0001615062851715865 > ./result_8chains/node52_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_2 -p 545 -st topic52_4_1 -pt None -u 0.052508916615899764 > ./result_8chains/node52_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_2 -p 732 -st topic52_5_1 -pt None -u 0.007994483691394688 > ./result_8chains/node52_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_2 -p 751 -st topic52_6_1 -pt None -u 0.036384871595009166 > ./result_8chains/node52_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_2 -p 892 -st topic52_7_1 -pt None -u 0.0007145156960689339 > ./result_8chains/node52_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_0 -p 76 -st none -pt topic52_0_0 -u 0.023884812853919635 > ./result_8chains/node52_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_0 -p 243 -st none -pt topic52_1_0 -u 0.04187712269592614 > ./result_8chains/node52_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_0 -p 367 -st none -pt topic52_2_0 -u 0.003624952436785067 > ./result_8chains/node52_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_0 -p 496 -st none -pt topic52_3_0 -u 0.0027164806553303666 > ./result_8chains/node52_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_0 -p 545 -st none -pt topic52_4_0 -u 0.023034249520769906 > ./result_8chains/node52_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_0 -p 732 -st none -pt topic52_5_0 -u 0.03130336780892484 > ./result_8chains/node52_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_0 -p 751 -st none -pt topic52_6_0 -u 0.043946959888885306 > ./result_8chains/node52_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_0 -p 892 -st none -pt topic52_7_0 -u 0.0225605391564942 > ./result_8chains/node52_7_0.txt &
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
    "./result_8chains/node52_0_0.txt 90"
    "./result_8chains/node52_0_2.txt 90"
    "./result_8chains/node52_1_0.txt 89"
    "./result_8chains/node52_1_2.txt 89"
    "./result_8chains/node52_2_0.txt 88"
    "./result_8chains/node52_2_2.txt 88"
    "./result_8chains/node52_3_0.txt 87"
    "./result_8chains/node52_3_2.txt 87"
    "./result_8chains/node52_4_0.txt 86"
    "./result_8chains/node52_4_2.txt 86"
    "./result_8chains/node52_5_0.txt 85"
    "./result_8chains/node52_5_2.txt 85"
    "./result_8chains/node52_6_0.txt 84"
    "./result_8chains/node52_6_2.txt 84"
    "./result_8chains/node52_7_0.txt 83"
    "./result_8chains/node52_7_2.txt 83"
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
