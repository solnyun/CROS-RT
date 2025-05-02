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
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_2 -p 25 -st topic466_0_1 -pt None -u 0.009399292739471266 > ./result_8chains/node466_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_2 -p 466 -st topic466_1_1 -pt None -u 0.0037113398329838843 > ./result_8chains/node466_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_2 -p 513 -st topic466_2_1 -pt None -u 0.015369263148001022 > ./result_8chains/node466_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_2 -p 589 -st topic466_3_1 -pt None -u 0.08175755997707759 > ./result_8chains/node466_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_2 -p 610 -st topic466_4_1 -pt None -u 0.0069240371305963055 > ./result_8chains/node466_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_2 -p 759 -st topic466_5_1 -pt None -u 0.01691148828768098 > ./result_8chains/node466_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_6_2 -p 829 -st topic466_6_1 -pt None -u 0.03809301560127305 > ./result_8chains/node466_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_7_2 -p 946 -st topic466_7_1 -pt None -u 0.006656410588494987 > ./result_8chains/node466_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_0 -p 25 -st none -pt topic466_0_0 -u 0.010906570875819976 > ./result_8chains/node466_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_0 -p 466 -st none -pt topic466_1_0 -u 0.008964281261880258 > ./result_8chains/node466_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_0 -p 513 -st none -pt topic466_2_0 -u 0.04993141247353311 > ./result_8chains/node466_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_0 -p 589 -st none -pt topic466_3_0 -u 0.014546557120123649 > ./result_8chains/node466_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_0 -p 610 -st none -pt topic466_4_0 -u 0.04683455860264135 > ./result_8chains/node466_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_0 -p 759 -st none -pt topic466_5_0 -u 0.01563301794799747 > ./result_8chains/node466_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_6_0 -p 829 -st none -pt topic466_6_0 -u 0.00906471228991973 > ./result_8chains/node466_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_7_0 -p 946 -st none -pt topic466_7_0 -u 0.005180759242370048 > ./result_8chains/node466_7_0.txt &
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
    "./result_8chains/node466_0_0.txt 90"
    "./result_8chains/node466_0_2.txt 90"
    "./result_8chains/node466_1_0.txt 89"
    "./result_8chains/node466_1_2.txt 89"
    "./result_8chains/node466_2_0.txt 88"
    "./result_8chains/node466_2_2.txt 88"
    "./result_8chains/node466_3_0.txt 87"
    "./result_8chains/node466_3_2.txt 87"
    "./result_8chains/node466_4_0.txt 86"
    "./result_8chains/node466_4_2.txt 86"
    "./result_8chains/node466_5_0.txt 85"
    "./result_8chains/node466_5_2.txt 85"
    "./result_8chains/node466_6_0.txt 84"
    "./result_8chains/node466_6_2.txt 84"
    "./result_8chains/node466_7_0.txt 83"
    "./result_8chains/node466_7_2.txt 83"
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
