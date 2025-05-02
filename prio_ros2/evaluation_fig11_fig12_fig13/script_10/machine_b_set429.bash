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
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_1 -p 101 -st topic429_0_0 -pt topic429_0_1 -u 0.01920584111482443 > ./result_10chains/node429_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_1 -p 231 -st topic429_1_0 -pt topic429_1_1 -u 0.004044102655999804 > ./result_10chains/node429_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_1 -p 278 -st topic429_2_0 -pt topic429_2_1 -u 0.0380395086285486 > ./result_10chains/node429_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_1 -p 280 -st topic429_3_0 -pt topic429_3_1 -u 0.0013085683381207636 > ./result_10chains/node429_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_1 -p 423 -st topic429_4_0 -pt topic429_4_1 -u 0.0010484051239800507 > ./result_10chains/node429_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_1 -p 528 -st topic429_5_0 -pt topic429_5_1 -u 0.0046196928979453655 > ./result_10chains/node429_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_1 -p 561 -st topic429_6_0 -pt topic429_6_1 -u 0.00247660099128498 > ./result_10chains/node429_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_1 -p 837 -st topic429_7_0 -pt topic429_7_1 -u 0.006228344579430292 > ./result_10chains/node429_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_8_1 -p 912 -st topic429_8_0 -pt topic429_8_1 -u 0.016584848339037755 > ./result_10chains/node429_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_9_1 -p 928 -st topic429_9_0 -pt topic429_9_1 -u 0.01593431169290044 > ./result_10chains/node429_9_1.txt &
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
    "./result_10chains/node429_0_1.txt 90"
    "./result_10chains/node429_1_1.txt 89"
    "./result_10chains/node429_2_1.txt 88"
    "./result_10chains/node429_3_1.txt 87"
    "./result_10chains/node429_4_1.txt 86"
    "./result_10chains/node429_5_1.txt 85"
    "./result_10chains/node429_6_1.txt 84"
    "./result_10chains/node429_7_1.txt 83"
    "./result_10chains/node429_8_1.txt 82"
    "./result_10chains/node429_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
