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
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_2 -p 46 -st topic218_0_1 -pt None -u 0.0334558586242536 > ./result_10chains/node218_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_2 -p 54 -st topic218_1_1 -pt None -u 0.013933830963391625 > ./result_10chains/node218_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_2 -p 170 -st topic218_2_1 -pt None -u 0.0012163305604393493 > ./result_10chains/node218_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_2 -p 299 -st topic218_3_1 -pt None -u 0.00047670637847080366 > ./result_10chains/node218_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_2 -p 335 -st topic218_4_1 -pt None -u 0.018074797639281215 > ./result_10chains/node218_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_2 -p 362 -st topic218_5_1 -pt None -u 0.0019145591420346997 > ./result_10chains/node218_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_2 -p 425 -st topic218_6_1 -pt None -u 0.0513657202015953 > ./result_10chains/node218_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_2 -p 670 -st topic218_7_1 -pt None -u 0.0036381371883021513 > ./result_10chains/node218_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_8_2 -p 858 -st topic218_8_1 -pt None -u 0.015095734541925455 > ./result_10chains/node218_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_9_2 -p 870 -st topic218_9_1 -pt None -u 0.011440042766572473 > ./result_10chains/node218_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_0 -p 46 -st none -pt topic218_0_0 -u 0.004605231480135641 > ./result_10chains/node218_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_0 -p 54 -st none -pt topic218_1_0 -u 0.01764583640423184 > ./result_10chains/node218_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_0 -p 170 -st none -pt topic218_2_0 -u 0.023056087067391207 > ./result_10chains/node218_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_0 -p 299 -st none -pt topic218_3_0 -u 0.0014605883787054408 > ./result_10chains/node218_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_0 -p 335 -st none -pt topic218_4_0 -u 0.027192415094566158 > ./result_10chains/node218_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_0 -p 362 -st none -pt topic218_5_0 -u 0.017945545128241425 > ./result_10chains/node218_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_0 -p 425 -st none -pt topic218_6_0 -u 0.02003396754643813 > ./result_10chains/node218_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_0 -p 670 -st none -pt topic218_7_0 -u 0.02570220086546776 > ./result_10chains/node218_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_8_0 -p 858 -st none -pt topic218_8_0 -u 0.0034041305989091775 > ./result_10chains/node218_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_9_0 -p 870 -st none -pt topic218_9_0 -u 0.007857524523868594 > ./result_10chains/node218_9_0.txt &
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
    "./result_10chains/node218_0_0.txt 90"
    "./result_10chains/node218_0_2.txt 90"
    "./result_10chains/node218_1_0.txt 89"
    "./result_10chains/node218_1_2.txt 89"
    "./result_10chains/node218_2_0.txt 88"
    "./result_10chains/node218_2_2.txt 88"
    "./result_10chains/node218_3_0.txt 87"
    "./result_10chains/node218_3_2.txt 87"
    "./result_10chains/node218_4_0.txt 86"
    "./result_10chains/node218_4_2.txt 86"
    "./result_10chains/node218_5_0.txt 85"
    "./result_10chains/node218_5_2.txt 85"
    "./result_10chains/node218_6_0.txt 84"
    "./result_10chains/node218_6_2.txt 84"
    "./result_10chains/node218_7_0.txt 83"
    "./result_10chains/node218_7_2.txt 83"
    "./result_10chains/node218_8_0.txt 82"
    "./result_10chains/node218_8_2.txt 82"
    "./result_10chains/node218_9_0.txt 81"
    "./result_10chains/node218_9_2.txt 81"
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
