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
ros2 run evaluation_3_randomdag uunifast_node -n node468_0_2 -p 165 -st topic468_0_1 -pt None -u 0.010722292210165407 > ./result_10chains/node468_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_1_2 -p 246 -st topic468_1_1 -pt None -u 0.012617090244017748 > ./result_10chains/node468_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_2_2 -p 279 -st topic468_2_1 -pt None -u 0.019978703904197426 > ./result_10chains/node468_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_3_2 -p 331 -st topic468_3_1 -pt None -u 0.03623922434822269 > ./result_10chains/node468_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_4_2 -p 349 -st topic468_4_1 -pt None -u 0.06792929500851136 > ./result_10chains/node468_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_5_2 -p 470 -st topic468_5_1 -pt None -u 0.026246801683236315 > ./result_10chains/node468_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_6_2 -p 598 -st topic468_6_1 -pt None -u 0.003322244094813992 > ./result_10chains/node468_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_7_2 -p 931 -st topic468_7_1 -pt None -u 0.004308901562666015 > ./result_10chains/node468_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_8_2 -p 954 -st topic468_8_1 -pt None -u 0.0013950902755324318 > ./result_10chains/node468_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_9_2 -p 955 -st topic468_9_1 -pt None -u 0.004974974369496487 > ./result_10chains/node468_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_0_0 -p 165 -st none -pt topic468_0_0 -u 0.004851887457375026 > ./result_10chains/node468_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_1_0 -p 246 -st none -pt topic468_1_0 -u 0.012417469144590354 > ./result_10chains/node468_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_2_0 -p 279 -st none -pt topic468_2_0 -u 0.0049824061383928475 > ./result_10chains/node468_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_3_0 -p 331 -st none -pt topic468_3_0 -u 0.0426374160144849 > ./result_10chains/node468_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_4_0 -p 349 -st none -pt topic468_4_0 -u 0.05497792059603138 > ./result_10chains/node468_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_5_0 -p 470 -st none -pt topic468_5_0 -u 0.00622069640321235 > ./result_10chains/node468_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_6_0 -p 598 -st none -pt topic468_6_0 -u 0.013268129533294912 > ./result_10chains/node468_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_7_0 -p 931 -st none -pt topic468_7_0 -u 0.0066278171922033655 > ./result_10chains/node468_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_8_0 -p 954 -st none -pt topic468_8_0 -u 0.006627159817515625 > ./result_10chains/node468_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node468_9_0 -p 955 -st none -pt topic468_9_0 -u 0.015170208791541608 > ./result_10chains/node468_9_0.txt &
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
    "./result_10chains/node468_0_0.txt 90"
    "./result_10chains/node468_0_2.txt 90"
    "./result_10chains/node468_1_0.txt 89"
    "./result_10chains/node468_1_2.txt 89"
    "./result_10chains/node468_2_0.txt 88"
    "./result_10chains/node468_2_2.txt 88"
    "./result_10chains/node468_3_0.txt 87"
    "./result_10chains/node468_3_2.txt 87"
    "./result_10chains/node468_4_0.txt 86"
    "./result_10chains/node468_4_2.txt 86"
    "./result_10chains/node468_5_0.txt 85"
    "./result_10chains/node468_5_2.txt 85"
    "./result_10chains/node468_6_0.txt 84"
    "./result_10chains/node468_6_2.txt 84"
    "./result_10chains/node468_7_0.txt 83"
    "./result_10chains/node468_7_2.txt 83"
    "./result_10chains/node468_8_0.txt 82"
    "./result_10chains/node468_8_2.txt 82"
    "./result_10chains/node468_9_0.txt 81"
    "./result_10chains/node468_9_2.txt 81"
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
