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
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_2 -p 49 -st topic380_0_1 -pt None -u 0.004757369066705264 > ./result_10chains/node380_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_2 -p 108 -st topic380_1_1 -pt None -u 0.000294319835879131 > ./result_10chains/node380_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_2 -p 176 -st topic380_2_1 -pt None -u 0.06929134789559199 > ./result_10chains/node380_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_2 -p 214 -st topic380_3_1 -pt None -u 0.005078666592141012 > ./result_10chains/node380_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_2 -p 321 -st topic380_4_1 -pt None -u 0.007327667521841913 > ./result_10chains/node380_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_2 -p 364 -st topic380_5_1 -pt None -u 0.030392117166752414 > ./result_10chains/node380_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_2 -p 674 -st topic380_6_1 -pt None -u 0.00978465567445963 > ./result_10chains/node380_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_2 -p 753 -st topic380_7_1 -pt None -u 0.012758674111701035 > ./result_10chains/node380_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_8_2 -p 881 -st topic380_8_1 -pt None -u 0.07681910981585735 > ./result_10chains/node380_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_9_2 -p 908 -st topic380_9_1 -pt None -u 0.003682099978705779 > ./result_10chains/node380_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_0 -p 49 -st none -pt topic380_0_0 -u 0.00021442791184717036 > ./result_10chains/node380_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_0 -p 108 -st none -pt topic380_1_0 -u 0.037276188494111795 > ./result_10chains/node380_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_0 -p 176 -st none -pt topic380_2_0 -u 0.0017792505664170344 > ./result_10chains/node380_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_0 -p 214 -st none -pt topic380_3_0 -u 0.026789636254064997 > ./result_10chains/node380_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_0 -p 321 -st none -pt topic380_4_0 -u 0.001197525777669295 > ./result_10chains/node380_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_0 -p 364 -st none -pt topic380_5_0 -u 0.009826134428065875 > ./result_10chains/node380_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_0 -p 674 -st none -pt topic380_6_0 -u 0.009004742134118227 > ./result_10chains/node380_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_0 -p 753 -st none -pt topic380_7_0 -u 0.022139660110332166 > ./result_10chains/node380_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_8_0 -p 881 -st none -pt topic380_8_0 -u 0.0012444744569918426 > ./result_10chains/node380_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_9_0 -p 908 -st none -pt topic380_9_0 -u 0.0032723964069065956 > ./result_10chains/node380_9_0.txt &
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
    "./result_10chains/node380_0_0.txt 90"
    "./result_10chains/node380_0_2.txt 90"
    "./result_10chains/node380_1_0.txt 89"
    "./result_10chains/node380_1_2.txt 89"
    "./result_10chains/node380_2_0.txt 88"
    "./result_10chains/node380_2_2.txt 88"
    "./result_10chains/node380_3_0.txt 87"
    "./result_10chains/node380_3_2.txt 87"
    "./result_10chains/node380_4_0.txt 86"
    "./result_10chains/node380_4_2.txt 86"
    "./result_10chains/node380_5_0.txt 85"
    "./result_10chains/node380_5_2.txt 85"
    "./result_10chains/node380_6_0.txt 84"
    "./result_10chains/node380_6_2.txt 84"
    "./result_10chains/node380_7_0.txt 83"
    "./result_10chains/node380_7_2.txt 83"
    "./result_10chains/node380_8_0.txt 82"
    "./result_10chains/node380_8_2.txt 82"
    "./result_10chains/node380_9_0.txt 81"
    "./result_10chains/node380_9_2.txt 81"
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
