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
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_2 -p 45 -st topic27_0_1 -pt None -u 0.0002512074150574084 > ./result_8chains/node27_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_2 -p 329 -st topic27_1_1 -pt None -u 0.020165391668947874 > ./result_8chains/node27_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_2 -p 437 -st topic27_2_1 -pt None -u 0.0017931770400741454 > ./result_8chains/node27_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_2 -p 518 -st topic27_3_1 -pt None -u 0.031006167264799323 > ./result_8chains/node27_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_2 -p 547 -st topic27_4_1 -pt None -u 0.002365180490305707 > ./result_8chains/node27_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_2 -p 778 -st topic27_5_1 -pt None -u 0.04091225855957556 > ./result_8chains/node27_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_2 -p 815 -st topic27_6_1 -pt None -u 0.0014349787463271563 > ./result_8chains/node27_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_2 -p 973 -st topic27_7_1 -pt None -u 0.03050104216398322 > ./result_8chains/node27_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_0 -p 45 -st none -pt topic27_0_0 -u 0.019104323104083887 > ./result_8chains/node27_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_0 -p 329 -st none -pt topic27_1_0 -u 0.006950084448989202 > ./result_8chains/node27_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_0 -p 437 -st none -pt topic27_2_0 -u 0.03659940915728016 > ./result_8chains/node27_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_0 -p 518 -st none -pt topic27_3_0 -u 0.0012850708512919806 > ./result_8chains/node27_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_0 -p 547 -st none -pt topic27_4_0 -u 0.0175938362950267 > ./result_8chains/node27_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_0 -p 778 -st none -pt topic27_5_0 -u 0.020828725367905615 > ./result_8chains/node27_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_0 -p 815 -st none -pt topic27_6_0 -u 0.0057607313049864994 > ./result_8chains/node27_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_0 -p 973 -st none -pt topic27_7_0 -u 0.010568947186352609 > ./result_8chains/node27_7_0.txt &
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
    "./result_8chains/node27_0_0.txt 90"
    "./result_8chains/node27_0_2.txt 90"
    "./result_8chains/node27_1_0.txt 89"
    "./result_8chains/node27_1_2.txt 89"
    "./result_8chains/node27_2_0.txt 88"
    "./result_8chains/node27_2_2.txt 88"
    "./result_8chains/node27_3_0.txt 87"
    "./result_8chains/node27_3_2.txt 87"
    "./result_8chains/node27_4_0.txt 86"
    "./result_8chains/node27_4_2.txt 86"
    "./result_8chains/node27_5_0.txt 85"
    "./result_8chains/node27_5_2.txt 85"
    "./result_8chains/node27_6_0.txt 84"
    "./result_8chains/node27_6_2.txt 84"
    "./result_8chains/node27_7_0.txt 83"
    "./result_8chains/node27_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
