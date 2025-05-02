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
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_2 -p 245 -st topic114_0_1 -pt None -u 0.0006031140106037003 > ./result_8chains/node114_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_2 -p 292 -st topic114_1_1 -pt None -u 0.00818788869766407 > ./result_8chains/node114_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_2 -p 393 -st topic114_2_1 -pt None -u 0.010365482683052207 > ./result_8chains/node114_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_2 -p 531 -st topic114_3_1 -pt None -u 0.006305461714076338 > ./result_8chains/node114_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_2 -p 551 -st topic114_4_1 -pt None -u 0.011746675845741572 > ./result_8chains/node114_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_2 -p 671 -st topic114_5_1 -pt None -u 0.00451637918572205 > ./result_8chains/node114_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_2 -p 797 -st topic114_6_1 -pt None -u 0.011354213083836304 > ./result_8chains/node114_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_2 -p 936 -st topic114_7_1 -pt None -u 0.007808660128735403 > ./result_8chains/node114_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_0 -p 245 -st none -pt topic114_0_0 -u 0.03999623336546826 > ./result_8chains/node114_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_0 -p 292 -st none -pt topic114_1_0 -u 0.005392379618466947 > ./result_8chains/node114_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_0 -p 393 -st none -pt topic114_2_0 -u 0.03408562528099257 > ./result_8chains/node114_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_0 -p 531 -st none -pt topic114_3_0 -u 0.09013714881564949 > ./result_8chains/node114_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_0 -p 551 -st none -pt topic114_4_0 -u 0.003129012752102256 > ./result_8chains/node114_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_0 -p 671 -st none -pt topic114_5_0 -u 0.052348720951086516 > ./result_8chains/node114_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_0 -p 797 -st none -pt topic114_6_0 -u 0.009652156381325973 > ./result_8chains/node114_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_0 -p 936 -st none -pt topic114_7_0 -u 0.017237393328234554 > ./result_8chains/node114_7_0.txt &
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
    "./result_8chains/node114_0_0.txt 90"
    "./result_8chains/node114_0_2.txt 90"
    "./result_8chains/node114_1_0.txt 89"
    "./result_8chains/node114_1_2.txt 89"
    "./result_8chains/node114_2_0.txt 88"
    "./result_8chains/node114_2_2.txt 88"
    "./result_8chains/node114_3_0.txt 87"
    "./result_8chains/node114_3_2.txt 87"
    "./result_8chains/node114_4_0.txt 86"
    "./result_8chains/node114_4_2.txt 86"
    "./result_8chains/node114_5_0.txt 85"
    "./result_8chains/node114_5_2.txt 85"
    "./result_8chains/node114_6_0.txt 84"
    "./result_8chains/node114_6_2.txt 84"
    "./result_8chains/node114_7_0.txt 83"
    "./result_8chains/node114_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
