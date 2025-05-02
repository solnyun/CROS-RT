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
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_2 -p 53 -st topic208_0_1 -pt None -u 0.011814773709320436 > ./result_10chains/node208_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_2 -p 99 -st topic208_1_1 -pt None -u 0.022486190932411887 > ./result_10chains/node208_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_2 -p 161 -st topic208_2_1 -pt None -u 0.03325901399755604 > ./result_10chains/node208_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_2 -p 173 -st topic208_3_1 -pt None -u 0.005861928178616915 > ./result_10chains/node208_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_4_2 -p 204 -st topic208_4_1 -pt None -u 0.005714802842897937 > ./result_10chains/node208_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_5_2 -p 474 -st topic208_5_1 -pt None -u 0.022329556865150896 > ./result_10chains/node208_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_6_2 -p 632 -st topic208_6_1 -pt None -u 0.0017567520341413845 > ./result_10chains/node208_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_7_2 -p 718 -st topic208_7_1 -pt None -u 0.028596010707441333 > ./result_10chains/node208_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_8_2 -p 762 -st topic208_8_1 -pt None -u 0.0020033269578191362 > ./result_10chains/node208_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_9_2 -p 812 -st topic208_9_1 -pt None -u 0.002120956993653811 > ./result_10chains/node208_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_0 -p 53 -st none -pt topic208_0_0 -u 0.020863778428250268 > ./result_10chains/node208_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_0 -p 99 -st none -pt topic208_1_0 -u 0.0051037677942926685 > ./result_10chains/node208_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_0 -p 161 -st none -pt topic208_2_0 -u 0.014534790825568356 > ./result_10chains/node208_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_0 -p 173 -st none -pt topic208_3_0 -u 0.024214642786069107 > ./result_10chains/node208_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_4_0 -p 204 -st none -pt topic208_4_0 -u 0.017735970535123102 > ./result_10chains/node208_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_5_0 -p 474 -st none -pt topic208_5_0 -u 0.030083963710653444 > ./result_10chains/node208_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_6_0 -p 632 -st none -pt topic208_6_0 -u 0.021754096093480807 > ./result_10chains/node208_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_7_0 -p 718 -st none -pt topic208_7_0 -u 0.024620581378965473 > ./result_10chains/node208_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_8_0 -p 762 -st none -pt topic208_8_0 -u 0.026046207101960928 > ./result_10chains/node208_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_9_0 -p 812 -st none -pt topic208_9_0 -u 0.021419232908298905 > ./result_10chains/node208_9_0.txt &
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
    "./result_10chains/node208_0_0.txt 90"
    "./result_10chains/node208_0_2.txt 90"
    "./result_10chains/node208_1_0.txt 89"
    "./result_10chains/node208_1_2.txt 89"
    "./result_10chains/node208_2_0.txt 88"
    "./result_10chains/node208_2_2.txt 88"
    "./result_10chains/node208_3_0.txt 87"
    "./result_10chains/node208_3_2.txt 87"
    "./result_10chains/node208_4_0.txt 86"
    "./result_10chains/node208_4_2.txt 86"
    "./result_10chains/node208_5_0.txt 85"
    "./result_10chains/node208_5_2.txt 85"
    "./result_10chains/node208_6_0.txt 84"
    "./result_10chains/node208_6_2.txt 84"
    "./result_10chains/node208_7_0.txt 83"
    "./result_10chains/node208_7_2.txt 83"
    "./result_10chains/node208_8_0.txt 82"
    "./result_10chains/node208_8_2.txt 82"
    "./result_10chains/node208_9_0.txt 81"
    "./result_10chains/node208_9_2.txt 81"
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
