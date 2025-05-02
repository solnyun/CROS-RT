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
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_2 -p 47 -st topic230_0_1 -pt None -u 0.022103936051737216 > ./result_10chains/node230_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_2 -p 250 -st topic230_1_1 -pt None -u 0.023530752589870363 > ./result_10chains/node230_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_2 -p 323 -st topic230_2_1 -pt None -u 0.020806579125849545 > ./result_10chains/node230_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_2 -p 324 -st topic230_3_1 -pt None -u 0.040934111863284994 > ./result_10chains/node230_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_2 -p 524 -st topic230_4_1 -pt None -u 0.024452381841626708 > ./result_10chains/node230_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_2 -p 645 -st topic230_5_1 -pt None -u 0.01652144210467993 > ./result_10chains/node230_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_6_2 -p 737 -st topic230_6_1 -pt None -u 0.0010788527321680674 > ./result_10chains/node230_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_7_2 -p 762 -st topic230_7_1 -pt None -u 0.010480867474646605 > ./result_10chains/node230_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_8_2 -p 907 -st topic230_8_1 -pt None -u 0.012931196282299648 > ./result_10chains/node230_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_9_2 -p 935 -st topic230_9_1 -pt None -u 0.05323219029920645 > ./result_10chains/node230_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_0 -p 47 -st none -pt topic230_0_0 -u 0.012976691271763985 > ./result_10chains/node230_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_0 -p 250 -st none -pt topic230_1_0 -u 0.017433737952824158 > ./result_10chains/node230_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_0 -p 323 -st none -pt topic230_2_0 -u 0.01593536921883859 > ./result_10chains/node230_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_0 -p 324 -st none -pt topic230_3_0 -u 0.012733792106992547 > ./result_10chains/node230_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_0 -p 524 -st none -pt topic230_4_0 -u 0.03436592606690675 > ./result_10chains/node230_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_0 -p 645 -st none -pt topic230_5_0 -u 0.0003502931600827264 > ./result_10chains/node230_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_6_0 -p 737 -st none -pt topic230_6_0 -u 0.022987232916244688 > ./result_10chains/node230_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_7_0 -p 762 -st none -pt topic230_7_0 -u 0.007335875590791685 > ./result_10chains/node230_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_8_0 -p 907 -st none -pt topic230_8_0 -u 0.0013919462866073817 > ./result_10chains/node230_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_9_0 -p 935 -st none -pt topic230_9_0 -u 0.007116058057693109 > ./result_10chains/node230_9_0.txt &
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
    "./result_10chains/node230_0_0.txt 90"
    "./result_10chains/node230_0_2.txt 90"
    "./result_10chains/node230_1_0.txt 89"
    "./result_10chains/node230_1_2.txt 89"
    "./result_10chains/node230_2_0.txt 88"
    "./result_10chains/node230_2_2.txt 88"
    "./result_10chains/node230_3_0.txt 87"
    "./result_10chains/node230_3_2.txt 87"
    "./result_10chains/node230_4_0.txt 86"
    "./result_10chains/node230_4_2.txt 86"
    "./result_10chains/node230_5_0.txt 85"
    "./result_10chains/node230_5_2.txt 85"
    "./result_10chains/node230_6_0.txt 84"
    "./result_10chains/node230_6_2.txt 84"
    "./result_10chains/node230_7_0.txt 83"
    "./result_10chains/node230_7_2.txt 83"
    "./result_10chains/node230_8_0.txt 82"
    "./result_10chains/node230_8_2.txt 82"
    "./result_10chains/node230_9_0.txt 81"
    "./result_10chains/node230_9_2.txt 81"
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
