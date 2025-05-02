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
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_2 -p 91 -st topic236_0_1 -pt None -u 0.019421928310021708 > ./result_8chains/node236_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_2 -p 286 -st topic236_1_1 -pt None -u 0.05985710769419428 > ./result_8chains/node236_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_2 -p 461 -st topic236_2_1 -pt None -u 0.006383906352160185 > ./result_8chains/node236_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_2 -p 655 -st topic236_3_1 -pt None -u 0.05797174873586955 > ./result_8chains/node236_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_2 -p 681 -st topic236_4_1 -pt None -u 0.00939531196828064 > ./result_8chains/node236_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_2 -p 740 -st topic236_5_1 -pt None -u 0.003123314135472857 > ./result_8chains/node236_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_6_2 -p 748 -st topic236_6_1 -pt None -u 0.0014698103336532459 > ./result_8chains/node236_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_7_2 -p 850 -st topic236_7_1 -pt None -u 0.0760395164760842 > ./result_8chains/node236_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_0 -p 91 -st none -pt topic236_0_0 -u 0.004637217651346948 > ./result_8chains/node236_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_0 -p 286 -st none -pt topic236_1_0 -u 0.0012774681949009326 > ./result_8chains/node236_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_0 -p 461 -st none -pt topic236_2_0 -u 0.0009027903245701352 > ./result_8chains/node236_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_0 -p 655 -st none -pt topic236_3_0 -u 0.0015622404254563294 > ./result_8chains/node236_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_0 -p 681 -st none -pt topic236_4_0 -u 0.000918298319022598 > ./result_8chains/node236_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_0 -p 740 -st none -pt topic236_5_0 -u 0.06790715922203125 > ./result_8chains/node236_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_6_0 -p 748 -st none -pt topic236_6_0 -u 0.009191485487376402 > ./result_8chains/node236_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_7_0 -p 850 -st none -pt topic236_7_0 -u 0.0008260792365850506 > ./result_8chains/node236_7_0.txt &
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
    "./result_8chains/node236_0_0.txt 90"
    "./result_8chains/node236_0_2.txt 90"
    "./result_8chains/node236_1_0.txt 89"
    "./result_8chains/node236_1_2.txt 89"
    "./result_8chains/node236_2_0.txt 88"
    "./result_8chains/node236_2_2.txt 88"
    "./result_8chains/node236_3_0.txt 87"
    "./result_8chains/node236_3_2.txt 87"
    "./result_8chains/node236_4_0.txt 86"
    "./result_8chains/node236_4_2.txt 86"
    "./result_8chains/node236_5_0.txt 85"
    "./result_8chains/node236_5_2.txt 85"
    "./result_8chains/node236_6_0.txt 84"
    "./result_8chains/node236_6_2.txt 84"
    "./result_8chains/node236_7_0.txt 83"
    "./result_8chains/node236_7_2.txt 83"
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
