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
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_2 -p 260 -st topic93_0_1 -pt None -u 0.006305808135723678 > ./result_8chains/node93_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_2 -p 356 -st topic93_1_1 -pt None -u 0.0036767504999155043 > ./result_8chains/node93_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_2 -p 388 -st topic93_2_1 -pt None -u 0.0006526983537789577 > ./result_8chains/node93_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_2 -p 402 -st topic93_3_1 -pt None -u 0.005807513341341108 > ./result_8chains/node93_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_2 -p 439 -st topic93_4_1 -pt None -u 0.0008362673843706758 > ./result_8chains/node93_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_2 -p 622 -st topic93_5_1 -pt None -u 0.025006494702427357 > ./result_8chains/node93_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_6_2 -p 788 -st topic93_6_1 -pt None -u 0.006721558405586803 > ./result_8chains/node93_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_7_2 -p 795 -st topic93_7_1 -pt None -u 0.06250582349787202 > ./result_8chains/node93_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_0 -p 260 -st none -pt topic93_0_0 -u 0.0740772627876014 > ./result_8chains/node93_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_0 -p 356 -st none -pt topic93_1_0 -u 0.012454469176245098 > ./result_8chains/node93_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_0 -p 388 -st none -pt topic93_2_0 -u 0.012670952983460548 > ./result_8chains/node93_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_0 -p 402 -st none -pt topic93_3_0 -u 0.047489768484902106 > ./result_8chains/node93_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_0 -p 439 -st none -pt topic93_4_0 -u 0.014043895016523367 > ./result_8chains/node93_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_0 -p 622 -st none -pt topic93_5_0 -u 0.005140398322415807 > ./result_8chains/node93_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_6_0 -p 788 -st none -pt topic93_6_0 -u 0.009749631483640941 > ./result_8chains/node93_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_7_0 -p 795 -st none -pt topic93_7_0 -u 0.002778233125023788 > ./result_8chains/node93_7_0.txt &
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
    "./result_8chains/node93_0_0.txt 90"
    "./result_8chains/node93_0_2.txt 90"
    "./result_8chains/node93_1_0.txt 89"
    "./result_8chains/node93_1_2.txt 89"
    "./result_8chains/node93_2_0.txt 88"
    "./result_8chains/node93_2_2.txt 88"
    "./result_8chains/node93_3_0.txt 87"
    "./result_8chains/node93_3_2.txt 87"
    "./result_8chains/node93_4_0.txt 86"
    "./result_8chains/node93_4_2.txt 86"
    "./result_8chains/node93_5_0.txt 85"
    "./result_8chains/node93_5_2.txt 85"
    "./result_8chains/node93_6_0.txt 84"
    "./result_8chains/node93_6_2.txt 84"
    "./result_8chains/node93_7_0.txt 83"
    "./result_8chains/node93_7_2.txt 83"
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
