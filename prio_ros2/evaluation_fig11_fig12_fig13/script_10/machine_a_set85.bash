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
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_2 -p 34 -st topic85_0_1 -pt None -u 0.001373359324356005 > ./result_10chains/node85_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_2 -p 158 -st topic85_1_1 -pt None -u 0.04776969325131131 > ./result_10chains/node85_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_2 -p 171 -st topic85_2_1 -pt None -u 0.010166246118953448 > ./result_10chains/node85_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_2 -p 261 -st topic85_3_1 -pt None -u 0.01013839681177453 > ./result_10chains/node85_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_2 -p 357 -st topic85_4_1 -pt None -u 0.002532429589914509 > ./result_10chains/node85_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_2 -p 388 -st topic85_5_1 -pt None -u 0.030523394075314597 > ./result_10chains/node85_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_2 -p 444 -st topic85_6_1 -pt None -u 0.007578173837854418 > ./result_10chains/node85_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_2 -p 583 -st topic85_7_1 -pt None -u 0.012879878989841026 > ./result_10chains/node85_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_8_2 -p 830 -st topic85_8_1 -pt None -u 0.00631217111307511 > ./result_10chains/node85_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_9_2 -p 847 -st topic85_9_1 -pt None -u 0.030045722294852764 > ./result_10chains/node85_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_0 -p 34 -st none -pt topic85_0_0 -u 0.011868020875993146 > ./result_10chains/node85_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_0 -p 158 -st none -pt topic85_1_0 -u 0.0007054697667432941 > ./result_10chains/node85_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_0 -p 171 -st none -pt topic85_2_0 -u 0.04449181930854229 > ./result_10chains/node85_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_0 -p 261 -st none -pt topic85_3_0 -u 0.01949011182968946 > ./result_10chains/node85_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_0 -p 357 -st none -pt topic85_4_0 -u 0.007708586995496203 > ./result_10chains/node85_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_0 -p 388 -st none -pt topic85_5_0 -u 0.01741707898070194 > ./result_10chains/node85_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_0 -p 444 -st none -pt topic85_6_0 -u 0.009222666852142875 > ./result_10chains/node85_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_0 -p 583 -st none -pt topic85_7_0 -u 0.028644811426774247 > ./result_10chains/node85_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_8_0 -p 830 -st none -pt topic85_8_0 -u 0.009328189056701505 > ./result_10chains/node85_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_9_0 -p 847 -st none -pt topic85_9_0 -u 0.03329671885946482 > ./result_10chains/node85_9_0.txt &
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
    "./result_10chains/node85_0_0.txt 90"
    "./result_10chains/node85_0_2.txt 90"
    "./result_10chains/node85_1_0.txt 89"
    "./result_10chains/node85_1_2.txt 89"
    "./result_10chains/node85_2_0.txt 88"
    "./result_10chains/node85_2_2.txt 88"
    "./result_10chains/node85_3_0.txt 87"
    "./result_10chains/node85_3_2.txt 87"
    "./result_10chains/node85_4_0.txt 86"
    "./result_10chains/node85_4_2.txt 86"
    "./result_10chains/node85_5_0.txt 85"
    "./result_10chains/node85_5_2.txt 85"
    "./result_10chains/node85_6_0.txt 84"
    "./result_10chains/node85_6_2.txt 84"
    "./result_10chains/node85_7_0.txt 83"
    "./result_10chains/node85_7_2.txt 83"
    "./result_10chains/node85_8_0.txt 82"
    "./result_10chains/node85_8_2.txt 82"
    "./result_10chains/node85_9_0.txt 81"
    "./result_10chains/node85_9_2.txt 81"
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
