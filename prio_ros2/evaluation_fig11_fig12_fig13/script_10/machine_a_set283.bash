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
ros2 run evaluation_3_randomdag uunifast_node -n node283_0_2 -p 195 -st topic283_0_1 -pt None -u 0.017826158799947478 > ./result_10chains/node283_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_1_2 -p 265 -st topic283_1_1 -pt None -u 0.004147823818842211 > ./result_10chains/node283_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_2_2 -p 395 -st topic283_2_1 -pt None -u 0.08327430987434148 > ./result_10chains/node283_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_3_2 -p 425 -st topic283_3_1 -pt None -u 0.02813940527142539 > ./result_10chains/node283_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_4_2 -p 435 -st topic283_4_1 -pt None -u 0.003572132850088783 > ./result_10chains/node283_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_5_2 -p 448 -st topic283_5_1 -pt None -u 0.00572300206930515 > ./result_10chains/node283_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_6_2 -p 663 -st topic283_6_1 -pt None -u 0.003938802685164555 > ./result_10chains/node283_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_7_2 -p 749 -st topic283_7_1 -pt None -u 0.00046526480180858476 > ./result_10chains/node283_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_8_2 -p 774 -st topic283_8_1 -pt None -u 0.017231199527476745 > ./result_10chains/node283_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_9_2 -p 962 -st topic283_9_1 -pt None -u 0.07282722266447238 > ./result_10chains/node283_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_0_0 -p 195 -st none -pt topic283_0_0 -u 0.002856248706339437 > ./result_10chains/node283_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_1_0 -p 265 -st none -pt topic283_1_0 -u 0.008624289886155045 > ./result_10chains/node283_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_2_0 -p 395 -st none -pt topic283_2_0 -u 0.013147898209564024 > ./result_10chains/node283_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_3_0 -p 425 -st none -pt topic283_3_0 -u 0.008032476900794894 > ./result_10chains/node283_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_4_0 -p 435 -st none -pt topic283_4_0 -u 0.00427665970350144 > ./result_10chains/node283_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_5_0 -p 448 -st none -pt topic283_5_0 -u 0.004311367364676105 > ./result_10chains/node283_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_6_0 -p 663 -st none -pt topic283_6_0 -u 0.0004050767338147354 > ./result_10chains/node283_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_7_0 -p 749 -st none -pt topic283_7_0 -u 0.005534897358183272 > ./result_10chains/node283_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_8_0 -p 774 -st none -pt topic283_8_0 -u 0.0626518120842661 > ./result_10chains/node283_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_9_0 -p 962 -st none -pt topic283_9_0 -u 0.0007894298195799815 > ./result_10chains/node283_9_0.txt &
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
    "./result_10chains/node283_0_0.txt 90"
    "./result_10chains/node283_0_2.txt 90"
    "./result_10chains/node283_1_0.txt 89"
    "./result_10chains/node283_1_2.txt 89"
    "./result_10chains/node283_2_0.txt 88"
    "./result_10chains/node283_2_2.txt 88"
    "./result_10chains/node283_3_0.txt 87"
    "./result_10chains/node283_3_2.txt 87"
    "./result_10chains/node283_4_0.txt 86"
    "./result_10chains/node283_4_2.txt 86"
    "./result_10chains/node283_5_0.txt 85"
    "./result_10chains/node283_5_2.txt 85"
    "./result_10chains/node283_6_0.txt 84"
    "./result_10chains/node283_6_2.txt 84"
    "./result_10chains/node283_7_0.txt 83"
    "./result_10chains/node283_7_2.txt 83"
    "./result_10chains/node283_8_0.txt 82"
    "./result_10chains/node283_8_2.txt 82"
    "./result_10chains/node283_9_0.txt 81"
    "./result_10chains/node283_9_2.txt 81"
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
