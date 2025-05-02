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
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_2 -p 27 -st topic71_0_1 -pt None -u 0.040116406563297846 > ./result_10chains/node71_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_2 -p 91 -st topic71_1_1 -pt None -u 0.013121287934701686 > ./result_10chains/node71_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_2 -p 228 -st topic71_2_1 -pt None -u 0.01650260317574581 > ./result_10chains/node71_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_2 -p 265 -st topic71_3_1 -pt None -u 0.007060896581138731 > ./result_10chains/node71_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_2 -p 421 -st topic71_4_1 -pt None -u 0.05993337752400585 > ./result_10chains/node71_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_2 -p 533 -st topic71_5_1 -pt None -u 0.009552354874896501 > ./result_10chains/node71_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_6_2 -p 583 -st topic71_6_1 -pt None -u 0.004103514797999613 > ./result_10chains/node71_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_7_2 -p 598 -st topic71_7_1 -pt None -u 0.02387815208327465 > ./result_10chains/node71_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_8_2 -p 619 -st topic71_8_1 -pt None -u 0.0029221476474432656 > ./result_10chains/node71_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_9_2 -p 763 -st topic71_9_1 -pt None -u 0.005635794627970672 > ./result_10chains/node71_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_0 -p 27 -st none -pt topic71_0_0 -u 0.014619941301944828 > ./result_10chains/node71_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_0 -p 91 -st none -pt topic71_1_0 -u 0.008421858216761835 > ./result_10chains/node71_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_0 -p 228 -st none -pt topic71_2_0 -u 0.01760411051582117 > ./result_10chains/node71_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_0 -p 265 -st none -pt topic71_3_0 -u 0.01114826376910788 > ./result_10chains/node71_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_0 -p 421 -st none -pt topic71_4_0 -u 0.012749195931074098 > ./result_10chains/node71_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_0 -p 533 -st none -pt topic71_5_0 -u 0.00484875933540857 > ./result_10chains/node71_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_6_0 -p 583 -st none -pt topic71_6_0 -u 0.03798987758153183 > ./result_10chains/node71_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_7_0 -p 598 -st none -pt topic71_7_0 -u 0.020562472716899954 > ./result_10chains/node71_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_8_0 -p 619 -st none -pt topic71_8_0 -u 0.01556255239164496 > ./result_10chains/node71_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_9_0 -p 763 -st none -pt topic71_9_0 -u 0.0038817887667115802 > ./result_10chains/node71_9_0.txt &
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
    "./result_10chains/node71_0_0.txt 90"
    "./result_10chains/node71_0_2.txt 90"
    "./result_10chains/node71_1_0.txt 89"
    "./result_10chains/node71_1_2.txt 89"
    "./result_10chains/node71_2_0.txt 88"
    "./result_10chains/node71_2_2.txt 88"
    "./result_10chains/node71_3_0.txt 87"
    "./result_10chains/node71_3_2.txt 87"
    "./result_10chains/node71_4_0.txt 86"
    "./result_10chains/node71_4_2.txt 86"
    "./result_10chains/node71_5_0.txt 85"
    "./result_10chains/node71_5_2.txt 85"
    "./result_10chains/node71_6_0.txt 84"
    "./result_10chains/node71_6_2.txt 84"
    "./result_10chains/node71_7_0.txt 83"
    "./result_10chains/node71_7_2.txt 83"
    "./result_10chains/node71_8_0.txt 82"
    "./result_10chains/node71_8_2.txt 82"
    "./result_10chains/node71_9_0.txt 81"
    "./result_10chains/node71_9_2.txt 81"
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
