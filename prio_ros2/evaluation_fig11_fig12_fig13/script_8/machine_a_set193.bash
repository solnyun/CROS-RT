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
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_2 -p 211 -st topic193_0_1 -pt None -u 0.011966819118670813 > ./result_8chains/node193_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_2 -p 219 -st topic193_1_1 -pt None -u 0.03518129739407033 > ./result_8chains/node193_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_2 -p 243 -st topic193_2_1 -pt None -u 0.0057915747660763905 > ./result_8chains/node193_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_2 -p 704 -st topic193_3_1 -pt None -u 0.010672398329953536 > ./result_8chains/node193_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_2 -p 747 -st topic193_4_1 -pt None -u 0.0012605303573354765 > ./result_8chains/node193_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_2 -p 774 -st topic193_5_1 -pt None -u 0.029247992049117544 > ./result_8chains/node193_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_6_2 -p 892 -st topic193_6_1 -pt None -u 0.023549499182814 > ./result_8chains/node193_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_7_2 -p 949 -st topic193_7_1 -pt None -u 0.0006501644870685228 > ./result_8chains/node193_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_0 -p 211 -st none -pt topic193_0_0 -u 0.061761593971410456 > ./result_8chains/node193_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_0 -p 219 -st none -pt topic193_1_0 -u 0.02346708673808051 > ./result_8chains/node193_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_0 -p 243 -st none -pt topic193_2_0 -u 0.0023570632737648922 > ./result_8chains/node193_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_0 -p 704 -st none -pt topic193_3_0 -u 0.008788962803125189 > ./result_8chains/node193_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_0 -p 747 -st none -pt topic193_4_0 -u 0.047909572267323064 > ./result_8chains/node193_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_0 -p 774 -st none -pt topic193_5_0 -u 0.0037984022171423937 > ./result_8chains/node193_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_6_0 -p 892 -st none -pt topic193_6_0 -u 0.014386098182498058 > ./result_8chains/node193_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_7_0 -p 949 -st none -pt topic193_7_0 -u 0.006815722877524494 > ./result_8chains/node193_7_0.txt &
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
    "./result_8chains/node193_0_0.txt 90"
    "./result_8chains/node193_0_2.txt 90"
    "./result_8chains/node193_1_0.txt 89"
    "./result_8chains/node193_1_2.txt 89"
    "./result_8chains/node193_2_0.txt 88"
    "./result_8chains/node193_2_2.txt 88"
    "./result_8chains/node193_3_0.txt 87"
    "./result_8chains/node193_3_2.txt 87"
    "./result_8chains/node193_4_0.txt 86"
    "./result_8chains/node193_4_2.txt 86"
    "./result_8chains/node193_5_0.txt 85"
    "./result_8chains/node193_5_2.txt 85"
    "./result_8chains/node193_6_0.txt 84"
    "./result_8chains/node193_6_2.txt 84"
    "./result_8chains/node193_7_0.txt 83"
    "./result_8chains/node193_7_2.txt 83"
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
