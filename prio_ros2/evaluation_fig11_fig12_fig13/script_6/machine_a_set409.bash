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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_2 -p 88 -st topic409_0_1 -pt None -u 0.021069780237561897 > ./result_6chains/node409_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_2 -p 131 -st topic409_1_1 -pt None -u 0.03295833453824326 > ./result_6chains/node409_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_2 -p 158 -st topic409_2_1 -pt None -u 0.0026712785632127534 > ./result_6chains/node409_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_2 -p 707 -st topic409_3_1 -pt None -u 0.0014494279444163538 > ./result_6chains/node409_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_2 -p 729 -st topic409_4_1 -pt None -u 0.005956045729413023 > ./result_6chains/node409_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_2 -p 906 -st topic409_5_1 -pt None -u 0.007282926728442251 > ./result_6chains/node409_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_0 -p 88 -st none -pt topic409_0_0 -u 0.05776142761317049 > ./result_6chains/node409_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_0 -p 131 -st none -pt topic409_1_0 -u 0.03223514008828249 > ./result_6chains/node409_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_0 -p 158 -st none -pt topic409_2_0 -u 0.09498778554386908 > ./result_6chains/node409_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_0 -p 707 -st none -pt topic409_3_0 -u 0.034688981080583714 > ./result_6chains/node409_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_0 -p 729 -st none -pt topic409_4_0 -u 0.0832192640505309 > ./result_6chains/node409_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_0 -p 906 -st none -pt topic409_5_0 -u 0.026136170541351558 > ./result_6chains/node409_5_0.txt &
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
    "./result_6chains/node409_0_0.txt 90"
    "./result_6chains/node409_0_2.txt 90"
    "./result_6chains/node409_1_0.txt 89"
    "./result_6chains/node409_1_2.txt 89"
    "./result_6chains/node409_2_0.txt 88"
    "./result_6chains/node409_2_2.txt 88"
    "./result_6chains/node409_3_0.txt 87"
    "./result_6chains/node409_3_2.txt 87"
    "./result_6chains/node409_4_0.txt 86"
    "./result_6chains/node409_4_2.txt 86"
    "./result_6chains/node409_5_0.txt 85"
    "./result_6chains/node409_5_2.txt 85"
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
