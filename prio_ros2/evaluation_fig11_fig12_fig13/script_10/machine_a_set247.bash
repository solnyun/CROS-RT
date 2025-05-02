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
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_2 -p 104 -st topic247_0_1 -pt None -u 0.00787048147265218 > ./result_10chains/node247_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_2 -p 105 -st topic247_1_1 -pt None -u 0.0224132467819807 > ./result_10chains/node247_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_2 -p 214 -st topic247_2_1 -pt None -u 0.014339766410628785 > ./result_10chains/node247_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_2 -p 244 -st topic247_3_1 -pt None -u 0.023265587688968803 > ./result_10chains/node247_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_2 -p 372 -st topic247_4_1 -pt None -u 0.0005297236366161306 > ./result_10chains/node247_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_2 -p 418 -st topic247_5_1 -pt None -u 0.013267004182172026 > ./result_10chains/node247_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_2 -p 550 -st topic247_6_1 -pt None -u 0.024909935216210932 > ./result_10chains/node247_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_2 -p 684 -st topic247_7_1 -pt None -u 0.03688621493198074 > ./result_10chains/node247_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_8_2 -p 754 -st topic247_8_1 -pt None -u 0.010485529106940256 > ./result_10chains/node247_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_9_2 -p 857 -st topic247_9_1 -pt None -u 0.11848846721672593 > ./result_10chains/node247_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_0 -p 104 -st none -pt topic247_0_0 -u 0.014107148310697148 > ./result_10chains/node247_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_0 -p 105 -st none -pt topic247_1_0 -u 0.01258143526656813 > ./result_10chains/node247_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_0 -p 214 -st none -pt topic247_2_0 -u 0.01967603574020821 > ./result_10chains/node247_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_0 -p 244 -st none -pt topic247_3_0 -u 0.023661421202971544 > ./result_10chains/node247_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_0 -p 372 -st none -pt topic247_4_0 -u 0.00738502797217494 > ./result_10chains/node247_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_0 -p 418 -st none -pt topic247_5_0 -u 0.005323045982077224 > ./result_10chains/node247_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_0 -p 550 -st none -pt topic247_6_0 -u 0.033822516020965754 > ./result_10chains/node247_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_0 -p 684 -st none -pt topic247_7_0 -u 0.020043642909082976 > ./result_10chains/node247_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_8_0 -p 754 -st none -pt topic247_8_0 -u 0.011180389396134721 > ./result_10chains/node247_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_9_0 -p 857 -st none -pt topic247_9_0 -u 0.0005515385224448555 > ./result_10chains/node247_9_0.txt &
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
    "./result_10chains/node247_0_0.txt 90"
    "./result_10chains/node247_0_2.txt 90"
    "./result_10chains/node247_1_0.txt 89"
    "./result_10chains/node247_1_2.txt 89"
    "./result_10chains/node247_2_0.txt 88"
    "./result_10chains/node247_2_2.txt 88"
    "./result_10chains/node247_3_0.txt 87"
    "./result_10chains/node247_3_2.txt 87"
    "./result_10chains/node247_4_0.txt 86"
    "./result_10chains/node247_4_2.txt 86"
    "./result_10chains/node247_5_0.txt 85"
    "./result_10chains/node247_5_2.txt 85"
    "./result_10chains/node247_6_0.txt 84"
    "./result_10chains/node247_6_2.txt 84"
    "./result_10chains/node247_7_0.txt 83"
    "./result_10chains/node247_7_2.txt 83"
    "./result_10chains/node247_8_0.txt 82"
    "./result_10chains/node247_8_2.txt 82"
    "./result_10chains/node247_9_0.txt 81"
    "./result_10chains/node247_9_2.txt 81"
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
