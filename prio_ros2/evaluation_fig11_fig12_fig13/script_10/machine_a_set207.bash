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
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_2 -p 123 -st topic207_0_1 -pt None -u 0.0025448211018095357 > ./result_10chains/node207_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_2 -p 124 -st topic207_1_1 -pt None -u 0.00726452304202585 > ./result_10chains/node207_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_2 -p 180 -st topic207_2_1 -pt None -u 0.03370139209911488 > ./result_10chains/node207_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_2 -p 286 -st topic207_3_1 -pt None -u 0.013992289515504464 > ./result_10chains/node207_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_2 -p 446 -st topic207_4_1 -pt None -u 0.08056002539169704 > ./result_10chains/node207_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_2 -p 544 -st topic207_5_1 -pt None -u 0.02214257338521647 > ./result_10chains/node207_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_6_2 -p 572 -st topic207_6_1 -pt None -u 0.02808076688346664 > ./result_10chains/node207_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_7_2 -p 577 -st topic207_7_1 -pt None -u 0.0020972547268101743 > ./result_10chains/node207_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_8_2 -p 637 -st topic207_8_1 -pt None -u 0.028871056391120642 > ./result_10chains/node207_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_9_2 -p 773 -st topic207_9_1 -pt None -u 0.011875009004595583 > ./result_10chains/node207_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_0 -p 123 -st none -pt topic207_0_0 -u 0.014447111301672977 > ./result_10chains/node207_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_0 -p 124 -st none -pt topic207_1_0 -u 0.00656105344879343 > ./result_10chains/node207_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_0 -p 180 -st none -pt topic207_2_0 -u 0.012096004046999509 > ./result_10chains/node207_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_0 -p 286 -st none -pt topic207_3_0 -u 0.02119746050421839 > ./result_10chains/node207_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_0 -p 446 -st none -pt topic207_4_0 -u 0.0014174731272482144 > ./result_10chains/node207_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_0 -p 544 -st none -pt topic207_5_0 -u 0.0022470284164764487 > ./result_10chains/node207_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_6_0 -p 572 -st none -pt topic207_6_0 -u 0.04273460242454116 > ./result_10chains/node207_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_7_0 -p 577 -st none -pt topic207_7_0 -u 0.04510502131441889 > ./result_10chains/node207_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_8_0 -p 637 -st none -pt topic207_8_0 -u 0.005691806932284937 > ./result_10chains/node207_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_9_0 -p 773 -st none -pt topic207_9_0 -u 0.028171018517886746 > ./result_10chains/node207_9_0.txt &
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
    "./result_10chains/node207_0_0.txt 90"
    "./result_10chains/node207_0_2.txt 90"
    "./result_10chains/node207_1_0.txt 89"
    "./result_10chains/node207_1_2.txt 89"
    "./result_10chains/node207_2_0.txt 88"
    "./result_10chains/node207_2_2.txt 88"
    "./result_10chains/node207_3_0.txt 87"
    "./result_10chains/node207_3_2.txt 87"
    "./result_10chains/node207_4_0.txt 86"
    "./result_10chains/node207_4_2.txt 86"
    "./result_10chains/node207_5_0.txt 85"
    "./result_10chains/node207_5_2.txt 85"
    "./result_10chains/node207_6_0.txt 84"
    "./result_10chains/node207_6_2.txt 84"
    "./result_10chains/node207_7_0.txt 83"
    "./result_10chains/node207_7_2.txt 83"
    "./result_10chains/node207_8_0.txt 82"
    "./result_10chains/node207_8_2.txt 82"
    "./result_10chains/node207_9_0.txt 81"
    "./result_10chains/node207_9_2.txt 81"
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
