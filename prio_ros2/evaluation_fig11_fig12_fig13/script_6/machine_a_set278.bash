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
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_2 -p 62 -st topic278_0_1 -pt None -u 0.0038161069473761078 > ./result_6chains/node278_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_2 -p 146 -st topic278_1_1 -pt None -u 0.0047582074519392226 > ./result_6chains/node278_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_2 -p 201 -st topic278_2_1 -pt None -u 0.0027367230177104684 > ./result_6chains/node278_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_2 -p 261 -st topic278_3_1 -pt None -u 0.02685595767127194 > ./result_6chains/node278_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_2 -p 529 -st topic278_4_1 -pt None -u 0.01920962626484482 > ./result_6chains/node278_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_2 -p 970 -st topic278_5_1 -pt None -u 0.01841390996941472 > ./result_6chains/node278_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_0 -p 62 -st none -pt topic278_0_0 -u 0.05853913220484758 > ./result_6chains/node278_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_0 -p 146 -st none -pt topic278_1_0 -u 0.015433334142632704 > ./result_6chains/node278_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_0 -p 201 -st none -pt topic278_2_0 -u 0.029748807782075226 > ./result_6chains/node278_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_0 -p 261 -st none -pt topic278_3_0 -u 0.043113153026210604 > ./result_6chains/node278_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_0 -p 529 -st none -pt topic278_4_0 -u 0.022725704301504376 > ./result_6chains/node278_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_0 -p 970 -st none -pt topic278_5_0 -u 0.05903491062881587 > ./result_6chains/node278_5_0.txt &
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
    "./result_6chains/node278_0_0.txt 90"
    "./result_6chains/node278_0_2.txt 90"
    "./result_6chains/node278_1_0.txt 89"
    "./result_6chains/node278_1_2.txt 89"
    "./result_6chains/node278_2_0.txt 88"
    "./result_6chains/node278_2_2.txt 88"
    "./result_6chains/node278_3_0.txt 87"
    "./result_6chains/node278_3_2.txt 87"
    "./result_6chains/node278_4_0.txt 86"
    "./result_6chains/node278_4_2.txt 86"
    "./result_6chains/node278_5_0.txt 85"
    "./result_6chains/node278_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
