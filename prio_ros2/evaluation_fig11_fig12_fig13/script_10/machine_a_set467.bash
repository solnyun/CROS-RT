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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_2 -p 57 -st topic467_0_1 -pt None -u 0.027974878334140085 > ./result_10chains/node467_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_2 -p 66 -st topic467_1_1 -pt None -u 0.0014664422082450446 > ./result_10chains/node467_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_2 -p 104 -st topic467_2_1 -pt None -u 0.004044718460273489 > ./result_10chains/node467_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_2 -p 145 -st topic467_3_1 -pt None -u 0.06655242021258695 > ./result_10chains/node467_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_2 -p 236 -st topic467_4_1 -pt None -u 0.01060751412594968 > ./result_10chains/node467_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_2 -p 284 -st topic467_5_1 -pt None -u 0.0007724492757320567 > ./result_10chains/node467_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_2 -p 423 -st topic467_6_1 -pt None -u 0.0068933123024548515 > ./result_10chains/node467_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_2 -p 448 -st topic467_7_1 -pt None -u 0.017998302655189688 > ./result_10chains/node467_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_8_2 -p 838 -st topic467_8_1 -pt None -u 0.04026982735357143 > ./result_10chains/node467_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_9_2 -p 886 -st topic467_9_1 -pt None -u 0.0046465235924113505 > ./result_10chains/node467_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_0 -p 57 -st none -pt topic467_0_0 -u 0.009038178240202921 > ./result_10chains/node467_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_0 -p 66 -st none -pt topic467_1_0 -u 0.037305967033023246 > ./result_10chains/node467_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_0 -p 104 -st none -pt topic467_2_0 -u 0.004496390433081865 > ./result_10chains/node467_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_0 -p 145 -st none -pt topic467_3_0 -u 0.023435997946152143 > ./result_10chains/node467_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_0 -p 236 -st none -pt topic467_4_0 -u 0.025832572803350523 > ./result_10chains/node467_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_0 -p 284 -st none -pt topic467_5_0 -u 0.006558442494366351 > ./result_10chains/node467_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_0 -p 423 -st none -pt topic467_6_0 -u 0.026377076406842698 > ./result_10chains/node467_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_0 -p 448 -st none -pt topic467_7_0 -u 0.013922488211948317 > ./result_10chains/node467_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_8_0 -p 838 -st none -pt topic467_8_0 -u 8.700418417102729e-05 > ./result_10chains/node467_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_9_0 -p 886 -st none -pt topic467_9_0 -u 0.007711439945516469 > ./result_10chains/node467_9_0.txt &
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
    "./result_10chains/node467_0_0.txt 90"
    "./result_10chains/node467_0_2.txt 90"
    "./result_10chains/node467_1_0.txt 89"
    "./result_10chains/node467_1_2.txt 89"
    "./result_10chains/node467_2_0.txt 88"
    "./result_10chains/node467_2_2.txt 88"
    "./result_10chains/node467_3_0.txt 87"
    "./result_10chains/node467_3_2.txt 87"
    "./result_10chains/node467_4_0.txt 86"
    "./result_10chains/node467_4_2.txt 86"
    "./result_10chains/node467_5_0.txt 85"
    "./result_10chains/node467_5_2.txt 85"
    "./result_10chains/node467_6_0.txt 84"
    "./result_10chains/node467_6_2.txt 84"
    "./result_10chains/node467_7_0.txt 83"
    "./result_10chains/node467_7_2.txt 83"
    "./result_10chains/node467_8_0.txt 82"
    "./result_10chains/node467_8_2.txt 82"
    "./result_10chains/node467_9_0.txt 81"
    "./result_10chains/node467_9_2.txt 81"
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
