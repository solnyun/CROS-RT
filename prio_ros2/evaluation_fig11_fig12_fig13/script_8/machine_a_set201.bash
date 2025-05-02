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
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_2 -p 11 -st topic201_0_1 -pt None -u 0.0022199273204646652 > ./result_8chains/node201_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_2 -p 30 -st topic201_1_1 -pt None -u 0.05096632298780612 > ./result_8chains/node201_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_2 -p 244 -st topic201_2_1 -pt None -u 0.010986431028150168 > ./result_8chains/node201_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_2 -p 334 -st topic201_3_1 -pt None -u 0.020008092970554614 > ./result_8chains/node201_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_2 -p 509 -st topic201_4_1 -pt None -u 0.04203528924465899 > ./result_8chains/node201_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_2 -p 663 -st topic201_5_1 -pt None -u 0.009776486155992303 > ./result_8chains/node201_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_2 -p 733 -st topic201_6_1 -pt None -u 0.01966188351518673 > ./result_8chains/node201_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_2 -p 791 -st topic201_7_1 -pt None -u 0.024424842277627788 > ./result_8chains/node201_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_0 -p 11 -st none -pt topic201_0_0 -u 0.005110236841537219 > ./result_8chains/node201_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_0 -p 30 -st none -pt topic201_1_0 -u 0.007373241559043953 > ./result_8chains/node201_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_0 -p 244 -st none -pt topic201_2_0 -u 0.007081600849506764 > ./result_8chains/node201_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_0 -p 334 -st none -pt topic201_3_0 -u 0.006563221283036047 > ./result_8chains/node201_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_0 -p 509 -st none -pt topic201_4_0 -u 0.0025277386770231336 > ./result_8chains/node201_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_0 -p 663 -st none -pt topic201_5_0 -u 0.0015607312501213777 > ./result_8chains/node201_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_0 -p 733 -st none -pt topic201_6_0 -u 0.019577633106878017 > ./result_8chains/node201_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_0 -p 791 -st none -pt topic201_7_0 -u 0.02247332482744719 > ./result_8chains/node201_7_0.txt &
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
    "./result_8chains/node201_0_0.txt 90"
    "./result_8chains/node201_0_2.txt 90"
    "./result_8chains/node201_1_0.txt 89"
    "./result_8chains/node201_1_2.txt 89"
    "./result_8chains/node201_2_0.txt 88"
    "./result_8chains/node201_2_2.txt 88"
    "./result_8chains/node201_3_0.txt 87"
    "./result_8chains/node201_3_2.txt 87"
    "./result_8chains/node201_4_0.txt 86"
    "./result_8chains/node201_4_2.txt 86"
    "./result_8chains/node201_5_0.txt 85"
    "./result_8chains/node201_5_2.txt 85"
    "./result_8chains/node201_6_0.txt 84"
    "./result_8chains/node201_6_2.txt 84"
    "./result_8chains/node201_7_0.txt 83"
    "./result_8chains/node201_7_2.txt 83"
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
