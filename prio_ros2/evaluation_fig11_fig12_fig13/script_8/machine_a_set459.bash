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
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_2 -p 93 -st topic459_0_1 -pt None -u 0.004243102353358508 > ./result_8chains/node459_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_2 -p 232 -st topic459_1_1 -pt None -u 0.01724536265891019 > ./result_8chains/node459_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_2 -p 263 -st topic459_2_1 -pt None -u 0.004169514008450448 > ./result_8chains/node459_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_2 -p 292 -st topic459_3_1 -pt None -u 0.018821105290327544 > ./result_8chains/node459_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_2 -p 302 -st topic459_4_1 -pt None -u 0.08624541584985371 > ./result_8chains/node459_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_2 -p 337 -st topic459_5_1 -pt None -u 0.012551223772094361 > ./result_8chains/node459_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_2 -p 604 -st topic459_6_1 -pt None -u 0.061492303439717566 > ./result_8chains/node459_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_2 -p 796 -st topic459_7_1 -pt None -u 0.009734038070597188 > ./result_8chains/node459_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_0 -p 93 -st none -pt topic459_0_0 -u 0.002931982917973197 > ./result_8chains/node459_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_0 -p 232 -st none -pt topic459_1_0 -u 0.005534563828953454 > ./result_8chains/node459_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_0 -p 263 -st none -pt topic459_2_0 -u 0.0026047640682220763 > ./result_8chains/node459_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_0 -p 292 -st none -pt topic459_3_0 -u 0.006343756636287834 > ./result_8chains/node459_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_0 -p 302 -st none -pt topic459_4_0 -u 0.00618743736854005 > ./result_8chains/node459_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_0 -p 337 -st none -pt topic459_5_0 -u 0.007560458699170047 > ./result_8chains/node459_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_0 -p 604 -st none -pt topic459_6_0 -u 0.04185583075804766 > ./result_8chains/node459_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_0 -p 796 -st none -pt topic459_7_0 -u 0.0011638574513762254 > ./result_8chains/node459_7_0.txt &
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
    "./result_8chains/node459_0_0.txt 90"
    "./result_8chains/node459_0_2.txt 90"
    "./result_8chains/node459_1_0.txt 89"
    "./result_8chains/node459_1_2.txt 89"
    "./result_8chains/node459_2_0.txt 88"
    "./result_8chains/node459_2_2.txt 88"
    "./result_8chains/node459_3_0.txt 87"
    "./result_8chains/node459_3_2.txt 87"
    "./result_8chains/node459_4_0.txt 86"
    "./result_8chains/node459_4_2.txt 86"
    "./result_8chains/node459_5_0.txt 85"
    "./result_8chains/node459_5_2.txt 85"
    "./result_8chains/node459_6_0.txt 84"
    "./result_8chains/node459_6_2.txt 84"
    "./result_8chains/node459_7_0.txt 83"
    "./result_8chains/node459_7_2.txt 83"
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
