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
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_2 -p 35 -st topic316_0_1 -pt None -u 7.429884250170771e-05 > ./result_10chains/node316_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_2 -p 51 -st topic316_1_1 -pt None -u 0.025791421381910207 > ./result_10chains/node316_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_2 -p 197 -st topic316_2_1 -pt None -u 0.013627461867307844 > ./result_10chains/node316_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_2 -p 227 -st topic316_3_1 -pt None -u 0.00857365542736549 > ./result_10chains/node316_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_2 -p 272 -st topic316_4_1 -pt None -u 0.010778161064225744 > ./result_10chains/node316_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_2 -p 341 -st topic316_5_1 -pt None -u 0.020430887395365527 > ./result_10chains/node316_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_2 -p 343 -st topic316_6_1 -pt None -u 0.00129019997065008 > ./result_10chains/node316_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_2 -p 380 -st topic316_7_1 -pt None -u 0.005273289252177404 > ./result_10chains/node316_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_8_2 -p 490 -st topic316_8_1 -pt None -u 0.018338897307459787 > ./result_10chains/node316_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_9_2 -p 662 -st topic316_9_1 -pt None -u 0.015404712973404795 > ./result_10chains/node316_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_0 -p 35 -st none -pt topic316_0_0 -u 0.02553206917943035 > ./result_10chains/node316_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_0 -p 51 -st none -pt topic316_1_0 -u 0.0045060981869329275 > ./result_10chains/node316_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_0 -p 197 -st none -pt topic316_2_0 -u 0.015253376931056828 > ./result_10chains/node316_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_0 -p 227 -st none -pt topic316_3_0 -u 0.023483019192410803 > ./result_10chains/node316_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_0 -p 272 -st none -pt topic316_4_0 -u 0.02372610201532055 > ./result_10chains/node316_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_0 -p 341 -st none -pt topic316_5_0 -u 0.005101017579886735 > ./result_10chains/node316_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_0 -p 343 -st none -pt topic316_6_0 -u 0.0014663658807066438 > ./result_10chains/node316_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_0 -p 380 -st none -pt topic316_7_0 -u 0.02511050224665362 > ./result_10chains/node316_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_8_0 -p 490 -st none -pt topic316_8_0 -u 0.0192883835517354 > ./result_10chains/node316_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_9_0 -p 662 -st none -pt topic316_9_0 -u 0.07176798984035249 > ./result_10chains/node316_9_0.txt &
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
    "./result_10chains/node316_0_0.txt 90"
    "./result_10chains/node316_0_2.txt 90"
    "./result_10chains/node316_1_0.txt 89"
    "./result_10chains/node316_1_2.txt 89"
    "./result_10chains/node316_2_0.txt 88"
    "./result_10chains/node316_2_2.txt 88"
    "./result_10chains/node316_3_0.txt 87"
    "./result_10chains/node316_3_2.txt 87"
    "./result_10chains/node316_4_0.txt 86"
    "./result_10chains/node316_4_2.txt 86"
    "./result_10chains/node316_5_0.txt 85"
    "./result_10chains/node316_5_2.txt 85"
    "./result_10chains/node316_6_0.txt 84"
    "./result_10chains/node316_6_2.txt 84"
    "./result_10chains/node316_7_0.txt 83"
    "./result_10chains/node316_7_2.txt 83"
    "./result_10chains/node316_8_0.txt 82"
    "./result_10chains/node316_8_2.txt 82"
    "./result_10chains/node316_9_0.txt 81"
    "./result_10chains/node316_9_2.txt 81"
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
