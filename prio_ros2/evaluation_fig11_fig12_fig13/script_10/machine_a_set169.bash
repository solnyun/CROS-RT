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
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_2 -p 91 -st topic169_0_1 -pt None -u 0.030545490386668983 > ./result_10chains/node169_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_2 -p 164 -st topic169_1_1 -pt None -u 0.02151323913612868 > ./result_10chains/node169_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_2 -p 215 -st topic169_2_1 -pt None -u 0.0037694247222548327 > ./result_10chains/node169_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_2 -p 344 -st topic169_3_1 -pt None -u 0.02977126986691847 > ./result_10chains/node169_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_2 -p 352 -st topic169_4_1 -pt None -u 0.007304463803981587 > ./result_10chains/node169_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_2 -p 366 -st topic169_5_1 -pt None -u 0.003687220475441094 > ./result_10chains/node169_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_6_2 -p 721 -st topic169_6_1 -pt None -u 0.008445821542728965 > ./result_10chains/node169_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_7_2 -p 748 -st topic169_7_1 -pt None -u 0.034696834554188816 > ./result_10chains/node169_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_8_2 -p 753 -st topic169_8_1 -pt None -u 0.013975291157948821 > ./result_10chains/node169_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_9_2 -p 925 -st topic169_9_1 -pt None -u 0.03847186915991512 > ./result_10chains/node169_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_0 -p 91 -st none -pt topic169_0_0 -u 0.010798681434612323 > ./result_10chains/node169_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_0 -p 164 -st none -pt topic169_1_0 -u 0.003121681602607007 > ./result_10chains/node169_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_0 -p 215 -st none -pt topic169_2_0 -u 0.06306017869083574 > ./result_10chains/node169_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_0 -p 344 -st none -pt topic169_3_0 -u 0.009541877533834509 > ./result_10chains/node169_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_0 -p 352 -st none -pt topic169_4_0 -u 0.00322758117334751 > ./result_10chains/node169_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_0 -p 366 -st none -pt topic169_5_0 -u 0.010835866278009143 > ./result_10chains/node169_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_6_0 -p 721 -st none -pt topic169_6_0 -u 0.0004071453905505895 > ./result_10chains/node169_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_7_0 -p 748 -st none -pt topic169_7_0 -u 0.002895618519912324 > ./result_10chains/node169_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_8_0 -p 753 -st none -pt topic169_8_0 -u 0.029903668534636135 > ./result_10chains/node169_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_9_0 -p 925 -st none -pt topic169_9_0 -u 0.02731404984817512 > ./result_10chains/node169_9_0.txt &
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
    "./result_10chains/node169_0_0.txt 90"
    "./result_10chains/node169_0_2.txt 90"
    "./result_10chains/node169_1_0.txt 89"
    "./result_10chains/node169_1_2.txt 89"
    "./result_10chains/node169_2_0.txt 88"
    "./result_10chains/node169_2_2.txt 88"
    "./result_10chains/node169_3_0.txt 87"
    "./result_10chains/node169_3_2.txt 87"
    "./result_10chains/node169_4_0.txt 86"
    "./result_10chains/node169_4_2.txt 86"
    "./result_10chains/node169_5_0.txt 85"
    "./result_10chains/node169_5_2.txt 85"
    "./result_10chains/node169_6_0.txt 84"
    "./result_10chains/node169_6_2.txt 84"
    "./result_10chains/node169_7_0.txt 83"
    "./result_10chains/node169_7_2.txt 83"
    "./result_10chains/node169_8_0.txt 82"
    "./result_10chains/node169_8_2.txt 82"
    "./result_10chains/node169_9_0.txt 81"
    "./result_10chains/node169_9_2.txt 81"
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
