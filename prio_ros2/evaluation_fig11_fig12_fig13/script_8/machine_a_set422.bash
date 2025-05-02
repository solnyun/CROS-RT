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
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_2 -p 123 -st topic422_0_1 -pt None -u 0.0054187111022513945 > ./result_8chains/node422_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_2 -p 312 -st topic422_1_1 -pt None -u 0.01534865772512306 > ./result_8chains/node422_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_2 -p 438 -st topic422_2_1 -pt None -u 0.01803290086842313 > ./result_8chains/node422_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_2 -p 503 -st topic422_3_1 -pt None -u 0.05815192194598001 > ./result_8chains/node422_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_2 -p 737 -st topic422_4_1 -pt None -u 0.020802662345642958 > ./result_8chains/node422_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_2 -p 801 -st topic422_5_1 -pt None -u 0.03547413366665314 > ./result_8chains/node422_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_6_2 -p 927 -st topic422_6_1 -pt None -u 0.04098900002626023 > ./result_8chains/node422_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_7_2 -p 991 -st topic422_7_1 -pt None -u 0.007136565875311474 > ./result_8chains/node422_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_0 -p 123 -st none -pt topic422_0_0 -u 0.0061281600454091145 > ./result_8chains/node422_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_0 -p 312 -st none -pt topic422_1_0 -u 0.03243226982265057 > ./result_8chains/node422_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_0 -p 438 -st none -pt topic422_2_0 -u 0.003826114138326231 > ./result_8chains/node422_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_0 -p 503 -st none -pt topic422_3_0 -u 0.006686504939874771 > ./result_8chains/node422_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_0 -p 737 -st none -pt topic422_4_0 -u 0.018528354613393305 > ./result_8chains/node422_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_0 -p 801 -st none -pt topic422_5_0 -u 0.042051605871650743 > ./result_8chains/node422_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_6_0 -p 927 -st none -pt topic422_6_0 -u 0.020835892907955136 > ./result_8chains/node422_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_7_0 -p 991 -st none -pt topic422_7_0 -u 0.007518790409162965 > ./result_8chains/node422_7_0.txt &
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
    "./result_8chains/node422_0_0.txt 90"
    "./result_8chains/node422_0_2.txt 90"
    "./result_8chains/node422_1_0.txt 89"
    "./result_8chains/node422_1_2.txt 89"
    "./result_8chains/node422_2_0.txt 88"
    "./result_8chains/node422_2_2.txt 88"
    "./result_8chains/node422_3_0.txt 87"
    "./result_8chains/node422_3_2.txt 87"
    "./result_8chains/node422_4_0.txt 86"
    "./result_8chains/node422_4_2.txt 86"
    "./result_8chains/node422_5_0.txt 85"
    "./result_8chains/node422_5_2.txt 85"
    "./result_8chains/node422_6_0.txt 84"
    "./result_8chains/node422_6_2.txt 84"
    "./result_8chains/node422_7_0.txt 83"
    "./result_8chains/node422_7_2.txt 83"
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
