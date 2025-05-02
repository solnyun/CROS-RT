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
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_2 -p 106 -st topic425_0_1 -pt None -u 0.0021163794531608993 > ./result_10chains/node425_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_2 -p 125 -st topic425_1_1 -pt None -u 0.0287003063290876 > ./result_10chains/node425_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_2 -p 228 -st topic425_2_1 -pt None -u 0.010863736964980775 > ./result_10chains/node425_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_2 -p 248 -st topic425_3_1 -pt None -u 0.0033122538608753027 > ./result_10chains/node425_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_2 -p 286 -st topic425_4_1 -pt None -u 0.002289760565441029 > ./result_10chains/node425_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_2 -p 724 -st topic425_5_1 -pt None -u 0.019766757239379817 > ./result_10chains/node425_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_2 -p 788 -st topic425_6_1 -pt None -u 0.020218645565328333 > ./result_10chains/node425_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_2 -p 878 -st topic425_7_1 -pt None -u 0.00015538915348607685 > ./result_10chains/node425_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_8_2 -p 972 -st topic425_8_1 -pt None -u 0.012905073714433711 > ./result_10chains/node425_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_9_2 -p 994 -st topic425_9_1 -pt None -u 0.00226284044686537 > ./result_10chains/node425_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_0 -p 106 -st none -pt topic425_0_0 -u 0.09794461444714597 > ./result_10chains/node425_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_0 -p 125 -st none -pt topic425_1_0 -u 0.013455372131228105 > ./result_10chains/node425_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_0 -p 228 -st none -pt topic425_2_0 -u 0.012337596001073314 > ./result_10chains/node425_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_0 -p 248 -st none -pt topic425_3_0 -u 0.00524589611074705 > ./result_10chains/node425_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_0 -p 286 -st none -pt topic425_4_0 -u 0.02687240039646288 > ./result_10chains/node425_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_0 -p 724 -st none -pt topic425_5_0 -u 0.010192333287307648 > ./result_10chains/node425_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_0 -p 788 -st none -pt topic425_6_0 -u 0.03286022027994487 > ./result_10chains/node425_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_0 -p 878 -st none -pt topic425_7_0 -u 0.04323207561591311 > ./result_10chains/node425_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_8_0 -p 972 -st none -pt topic425_8_0 -u 0.03511167709844533 > ./result_10chains/node425_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_9_0 -p 994 -st none -pt topic425_9_0 -u 0.0015407271772120007 > ./result_10chains/node425_9_0.txt &
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
    "./result_10chains/node425_0_0.txt 90"
    "./result_10chains/node425_0_2.txt 90"
    "./result_10chains/node425_1_0.txt 89"
    "./result_10chains/node425_1_2.txt 89"
    "./result_10chains/node425_2_0.txt 88"
    "./result_10chains/node425_2_2.txt 88"
    "./result_10chains/node425_3_0.txt 87"
    "./result_10chains/node425_3_2.txt 87"
    "./result_10chains/node425_4_0.txt 86"
    "./result_10chains/node425_4_2.txt 86"
    "./result_10chains/node425_5_0.txt 85"
    "./result_10chains/node425_5_2.txt 85"
    "./result_10chains/node425_6_0.txt 84"
    "./result_10chains/node425_6_2.txt 84"
    "./result_10chains/node425_7_0.txt 83"
    "./result_10chains/node425_7_2.txt 83"
    "./result_10chains/node425_8_0.txt 82"
    "./result_10chains/node425_8_2.txt 82"
    "./result_10chains/node425_9_0.txt 81"
    "./result_10chains/node425_9_2.txt 81"
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
