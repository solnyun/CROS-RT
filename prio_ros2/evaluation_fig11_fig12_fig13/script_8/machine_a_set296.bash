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
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_2 -p 94 -st topic296_0_1 -pt None -u 0.03707616964858812 > ./result_8chains/node296_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_2 -p 129 -st topic296_1_1 -pt None -u 0.03188246516703297 > ./result_8chains/node296_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_2 -p 218 -st topic296_2_1 -pt None -u 0.03749726687624322 > ./result_8chains/node296_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_2 -p 264 -st topic296_3_1 -pt None -u 0.06910390914699652 > ./result_8chains/node296_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_2 -p 265 -st topic296_4_1 -pt None -u 0.005562450484344145 > ./result_8chains/node296_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_2 -p 369 -st topic296_5_1 -pt None -u 0.03181688840999289 > ./result_8chains/node296_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_2 -p 598 -st topic296_6_1 -pt None -u 0.025555577408274938 > ./result_8chains/node296_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_2 -p 839 -st topic296_7_1 -pt None -u 0.002184312965185177 > ./result_8chains/node296_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_0 -p 94 -st none -pt topic296_0_0 -u 0.03242220717496014 > ./result_8chains/node296_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_0 -p 129 -st none -pt topic296_1_0 -u 0.023216370599079217 > ./result_8chains/node296_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_0 -p 218 -st none -pt topic296_2_0 -u 0.0022164529519754783 > ./result_8chains/node296_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_0 -p 264 -st none -pt topic296_3_0 -u 0.0042436628788266595 > ./result_8chains/node296_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_0 -p 265 -st none -pt topic296_4_0 -u 0.014338433773932402 > ./result_8chains/node296_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_0 -p 369 -st none -pt topic296_5_0 -u 0.0020667831734887676 > ./result_8chains/node296_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_0 -p 598 -st none -pt topic296_6_0 -u 0.015471521041843267 > ./result_8chains/node296_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_0 -p 839 -st none -pt topic296_7_0 -u 0.020655997448679166 > ./result_8chains/node296_7_0.txt &
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
    "./result_8chains/node296_0_0.txt 90"
    "./result_8chains/node296_0_2.txt 90"
    "./result_8chains/node296_1_0.txt 89"
    "./result_8chains/node296_1_2.txt 89"
    "./result_8chains/node296_2_0.txt 88"
    "./result_8chains/node296_2_2.txt 88"
    "./result_8chains/node296_3_0.txt 87"
    "./result_8chains/node296_3_2.txt 87"
    "./result_8chains/node296_4_0.txt 86"
    "./result_8chains/node296_4_2.txt 86"
    "./result_8chains/node296_5_0.txt 85"
    "./result_8chains/node296_5_2.txt 85"
    "./result_8chains/node296_6_0.txt 84"
    "./result_8chains/node296_6_2.txt 84"
    "./result_8chains/node296_7_0.txt 83"
    "./result_8chains/node296_7_2.txt 83"
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
