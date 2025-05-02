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
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_2 -p 90 -st topic41_0_1 -pt None -u 0.04396280276347647 > ./result_10chains/node41_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_2 -p 142 -st topic41_1_1 -pt None -u 0.006245041074183055 > ./result_10chains/node41_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_2 -p 259 -st topic41_2_1 -pt None -u 0.06130029664668618 > ./result_10chains/node41_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_2 -p 391 -st topic41_3_1 -pt None -u 0.0009528284863860592 > ./result_10chains/node41_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_2 -p 477 -st topic41_4_1 -pt None -u 0.03166821861015426 > ./result_10chains/node41_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_2 -p 700 -st topic41_5_1 -pt None -u 0.0009180605108165263 > ./result_10chains/node41_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_2 -p 796 -st topic41_6_1 -pt None -u 0.024226682882186587 > ./result_10chains/node41_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_2 -p 891 -st topic41_7_1 -pt None -u 0.01233531365470289 > ./result_10chains/node41_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_8_2 -p 912 -st topic41_8_1 -pt None -u 0.014841030632553463 > ./result_10chains/node41_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_9_2 -p 960 -st topic41_9_1 -pt None -u 0.012825834096668896 > ./result_10chains/node41_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_0 -p 90 -st none -pt topic41_0_0 -u 0.04428419349214041 > ./result_10chains/node41_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_0 -p 142 -st none -pt topic41_1_0 -u 0.0020941509427523375 > ./result_10chains/node41_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_0 -p 259 -st none -pt topic41_2_0 -u 0.007756274077801162 > ./result_10chains/node41_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_0 -p 391 -st none -pt topic41_3_0 -u 0.006185952928849436 > ./result_10chains/node41_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_0 -p 477 -st none -pt topic41_4_0 -u 0.01971977150587123 > ./result_10chains/node41_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_0 -p 700 -st none -pt topic41_5_0 -u 0.0050788083620608715 > ./result_10chains/node41_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_0 -p 796 -st none -pt topic41_6_0 -u 0.05297222742625707 > ./result_10chains/node41_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_0 -p 891 -st none -pt topic41_7_0 -u 0.0019049093342404372 > ./result_10chains/node41_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_8_0 -p 912 -st none -pt topic41_8_0 -u 0.024991136442103587 > ./result_10chains/node41_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_9_0 -p 960 -st none -pt topic41_9_0 -u 0.0041234420905486915 > ./result_10chains/node41_9_0.txt &
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
    "./result_10chains/node41_0_0.txt 90"
    "./result_10chains/node41_0_2.txt 90"
    "./result_10chains/node41_1_0.txt 89"
    "./result_10chains/node41_1_2.txt 89"
    "./result_10chains/node41_2_0.txt 88"
    "./result_10chains/node41_2_2.txt 88"
    "./result_10chains/node41_3_0.txt 87"
    "./result_10chains/node41_3_2.txt 87"
    "./result_10chains/node41_4_0.txt 86"
    "./result_10chains/node41_4_2.txt 86"
    "./result_10chains/node41_5_0.txt 85"
    "./result_10chains/node41_5_2.txt 85"
    "./result_10chains/node41_6_0.txt 84"
    "./result_10chains/node41_6_2.txt 84"
    "./result_10chains/node41_7_0.txt 83"
    "./result_10chains/node41_7_2.txt 83"
    "./result_10chains/node41_8_0.txt 82"
    "./result_10chains/node41_8_2.txt 82"
    "./result_10chains/node41_9_0.txt 81"
    "./result_10chains/node41_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
