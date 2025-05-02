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
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_2 -p 49 -st topic476_0_1 -pt None -u 0.003941248101872963 > ./result_10chains/node476_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_2 -p 216 -st topic476_1_1 -pt None -u 0.048223219740595125 > ./result_10chains/node476_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_2 -p 297 -st topic476_2_1 -pt None -u 0.0019650915368994437 > ./result_10chains/node476_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_2 -p 350 -st topic476_3_1 -pt None -u 0.027657966509861687 > ./result_10chains/node476_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_2 -p 372 -st topic476_4_1 -pt None -u 0.014645308688050973 > ./result_10chains/node476_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_2 -p 408 -st topic476_5_1 -pt None -u 0.011117841501407738 > ./result_10chains/node476_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_6_2 -p 593 -st topic476_6_1 -pt None -u 0.03822293670902502 > ./result_10chains/node476_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_7_2 -p 639 -st topic476_7_1 -pt None -u 0.005432405580570995 > ./result_10chains/node476_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_8_2 -p 774 -st topic476_8_1 -pt None -u 0.028643928779920558 > ./result_10chains/node476_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_9_2 -p 952 -st topic476_9_1 -pt None -u 0.030761732944179783 > ./result_10chains/node476_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_0 -p 49 -st none -pt topic476_0_0 -u 0.0024621968940845562 > ./result_10chains/node476_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_0 -p 216 -st none -pt topic476_1_0 -u 0.0006572599219930586 > ./result_10chains/node476_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_0 -p 297 -st none -pt topic476_2_0 -u 0.016453503645972534 > ./result_10chains/node476_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_0 -p 350 -st none -pt topic476_3_0 -u 0.027790509682238562 > ./result_10chains/node476_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_0 -p 372 -st none -pt topic476_4_0 -u 0.0027023748519683366 > ./result_10chains/node476_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_0 -p 408 -st none -pt topic476_5_0 -u 0.023751135224966358 > ./result_10chains/node476_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_6_0 -p 593 -st none -pt topic476_6_0 -u 0.004155529497530064 > ./result_10chains/node476_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_7_0 -p 639 -st none -pt topic476_7_0 -u 0.008123128028055121 > ./result_10chains/node476_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_8_0 -p 774 -st none -pt topic476_8_0 -u 0.00018775369718358748 > ./result_10chains/node476_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_9_0 -p 952 -st none -pt topic476_9_0 -u 0.026525852278608597 > ./result_10chains/node476_9_0.txt &
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
    "./result_10chains/node476_0_0.txt 90"
    "./result_10chains/node476_0_2.txt 90"
    "./result_10chains/node476_1_0.txt 89"
    "./result_10chains/node476_1_2.txt 89"
    "./result_10chains/node476_2_0.txt 88"
    "./result_10chains/node476_2_2.txt 88"
    "./result_10chains/node476_3_0.txt 87"
    "./result_10chains/node476_3_2.txt 87"
    "./result_10chains/node476_4_0.txt 86"
    "./result_10chains/node476_4_2.txt 86"
    "./result_10chains/node476_5_0.txt 85"
    "./result_10chains/node476_5_2.txt 85"
    "./result_10chains/node476_6_0.txt 84"
    "./result_10chains/node476_6_2.txt 84"
    "./result_10chains/node476_7_0.txt 83"
    "./result_10chains/node476_7_2.txt 83"
    "./result_10chains/node476_8_0.txt 82"
    "./result_10chains/node476_8_2.txt 82"
    "./result_10chains/node476_9_0.txt 81"
    "./result_10chains/node476_9_2.txt 81"
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
