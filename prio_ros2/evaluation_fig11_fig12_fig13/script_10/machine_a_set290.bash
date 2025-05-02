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
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_2 -p 32 -st topic290_0_1 -pt None -u 0.0028004196327380826 > ./result_10chains/node290_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_2 -p 42 -st topic290_1_1 -pt None -u 0.0298182088584249 > ./result_10chains/node290_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_2 -p 219 -st topic290_2_1 -pt None -u 0.008008470458836903 > ./result_10chains/node290_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_2 -p 250 -st topic290_3_1 -pt None -u 0.0004426759659205137 > ./result_10chains/node290_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_2 -p 312 -st topic290_4_1 -pt None -u 0.01137301448905692 > ./result_10chains/node290_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_2 -p 330 -st topic290_5_1 -pt None -u 0.024415124262908983 > ./result_10chains/node290_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_2 -p 472 -st topic290_6_1 -pt None -u 0.01034438114699418 > ./result_10chains/node290_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_2 -p 658 -st topic290_7_1 -pt None -u 0.0037257964262184112 > ./result_10chains/node290_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_8_2 -p 744 -st topic290_8_1 -pt None -u 0.010369337631213012 > ./result_10chains/node290_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_9_2 -p 903 -st topic290_9_1 -pt None -u 0.02272305346833275 > ./result_10chains/node290_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_0 -p 32 -st none -pt topic290_0_0 -u 0.0011541033397622913 > ./result_10chains/node290_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_0 -p 42 -st none -pt topic290_1_0 -u 0.03185797752272307 > ./result_10chains/node290_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_0 -p 219 -st none -pt topic290_2_0 -u 0.0508243184602048 > ./result_10chains/node290_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_0 -p 250 -st none -pt topic290_3_0 -u 0.011433137790712922 > ./result_10chains/node290_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_0 -p 312 -st none -pt topic290_4_0 -u 0.0043528830018760845 > ./result_10chains/node290_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_0 -p 330 -st none -pt topic290_5_0 -u 0.030365058705878606 > ./result_10chains/node290_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_0 -p 472 -st none -pt topic290_6_0 -u 0.03283213310147909 > ./result_10chains/node290_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_0 -p 658 -st none -pt topic290_7_0 -u 0.00013924841481585681 > ./result_10chains/node290_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_8_0 -p 744 -st none -pt topic290_8_0 -u 0.006772806498165335 > ./result_10chains/node290_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_9_0 -p 903 -st none -pt topic290_9_0 -u 0.009963903608841938 > ./result_10chains/node290_9_0.txt &
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
    "./result_10chains/node290_0_0.txt 90"
    "./result_10chains/node290_0_2.txt 90"
    "./result_10chains/node290_1_0.txt 89"
    "./result_10chains/node290_1_2.txt 89"
    "./result_10chains/node290_2_0.txt 88"
    "./result_10chains/node290_2_2.txt 88"
    "./result_10chains/node290_3_0.txt 87"
    "./result_10chains/node290_3_2.txt 87"
    "./result_10chains/node290_4_0.txt 86"
    "./result_10chains/node290_4_2.txt 86"
    "./result_10chains/node290_5_0.txt 85"
    "./result_10chains/node290_5_2.txt 85"
    "./result_10chains/node290_6_0.txt 84"
    "./result_10chains/node290_6_2.txt 84"
    "./result_10chains/node290_7_0.txt 83"
    "./result_10chains/node290_7_2.txt 83"
    "./result_10chains/node290_8_0.txt 82"
    "./result_10chains/node290_8_2.txt 82"
    "./result_10chains/node290_9_0.txt 81"
    "./result_10chains/node290_9_2.txt 81"
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
