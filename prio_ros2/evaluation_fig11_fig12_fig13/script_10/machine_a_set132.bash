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
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_2 -p 84 -st topic132_0_1 -pt None -u 0.008770727191993288 > ./result_10chains/node132_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_2 -p 138 -st topic132_1_1 -pt None -u 0.028221460482551197 > ./result_10chains/node132_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_2 -p 200 -st topic132_2_1 -pt None -u 0.001549781435932096 > ./result_10chains/node132_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_2 -p 295 -st topic132_3_1 -pt None -u 0.027321615243389885 > ./result_10chains/node132_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_2 -p 337 -st topic132_4_1 -pt None -u 0.05357196258314101 > ./result_10chains/node132_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_2 -p 359 -st topic132_5_1 -pt None -u 0.0020914472802380235 > ./result_10chains/node132_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_6_2 -p 627 -st topic132_6_1 -pt None -u 0.006381586104028808 > ./result_10chains/node132_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_7_2 -p 663 -st topic132_7_1 -pt None -u 0.011969318659634673 > ./result_10chains/node132_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_8_2 -p 696 -st topic132_8_1 -pt None -u 0.06539899602350213 > ./result_10chains/node132_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_9_2 -p 957 -st topic132_9_1 -pt None -u 0.00324538579699735 > ./result_10chains/node132_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_0 -p 84 -st none -pt topic132_0_0 -u 0.006962117012448199 > ./result_10chains/node132_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_0 -p 138 -st none -pt topic132_1_0 -u 0.003249064181874317 > ./result_10chains/node132_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_0 -p 200 -st none -pt topic132_2_0 -u 0.019654350453471692 > ./result_10chains/node132_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_0 -p 295 -st none -pt topic132_3_0 -u 0.02538521580352321 > ./result_10chains/node132_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_0 -p 337 -st none -pt topic132_4_0 -u 0.00487595229419191 > ./result_10chains/node132_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_0 -p 359 -st none -pt topic132_5_0 -u 0.01692083851863621 > ./result_10chains/node132_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_6_0 -p 627 -st none -pt topic132_6_0 -u 0.009249832705833433 > ./result_10chains/node132_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_7_0 -p 663 -st none -pt topic132_7_0 -u 0.004150824594994856 > ./result_10chains/node132_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_8_0 -p 696 -st none -pt topic132_8_0 -u 0.04008212825405663 > ./result_10chains/node132_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_9_0 -p 957 -st none -pt topic132_9_0 -u 0.004715509687520611 > ./result_10chains/node132_9_0.txt &
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
    "./result_10chains/node132_0_0.txt 90"
    "./result_10chains/node132_0_2.txt 90"
    "./result_10chains/node132_1_0.txt 89"
    "./result_10chains/node132_1_2.txt 89"
    "./result_10chains/node132_2_0.txt 88"
    "./result_10chains/node132_2_2.txt 88"
    "./result_10chains/node132_3_0.txt 87"
    "./result_10chains/node132_3_2.txt 87"
    "./result_10chains/node132_4_0.txt 86"
    "./result_10chains/node132_4_2.txt 86"
    "./result_10chains/node132_5_0.txt 85"
    "./result_10chains/node132_5_2.txt 85"
    "./result_10chains/node132_6_0.txt 84"
    "./result_10chains/node132_6_2.txt 84"
    "./result_10chains/node132_7_0.txt 83"
    "./result_10chains/node132_7_2.txt 83"
    "./result_10chains/node132_8_0.txt 82"
    "./result_10chains/node132_8_2.txt 82"
    "./result_10chains/node132_9_0.txt 81"
    "./result_10chains/node132_9_2.txt 81"
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
