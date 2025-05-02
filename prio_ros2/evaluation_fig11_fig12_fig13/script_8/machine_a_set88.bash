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
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_2 -p 30 -st topic88_0_1 -pt None -u 0.0359972510970763 > ./result_8chains/node88_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_2 -p 31 -st topic88_1_1 -pt None -u 0.01928268324629051 > ./result_8chains/node88_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_2 -p 333 -st topic88_2_1 -pt None -u 0.016182468695135344 > ./result_8chains/node88_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_2 -p 473 -st topic88_3_1 -pt None -u 0.04965424478978839 > ./result_8chains/node88_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_2 -p 566 -st topic88_4_1 -pt None -u 0.05226118462855242 > ./result_8chains/node88_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_2 -p 630 -st topic88_5_1 -pt None -u 0.010168835796066505 > ./result_8chains/node88_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_6_2 -p 696 -st topic88_6_1 -pt None -u 0.02374071987971897 > ./result_8chains/node88_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_7_2 -p 741 -st topic88_7_1 -pt None -u 0.026466610829784305 > ./result_8chains/node88_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_0 -p 30 -st none -pt topic88_0_0 -u 0.029967666341766896 > ./result_8chains/node88_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_0 -p 31 -st none -pt topic88_1_0 -u 0.005875390553670368 > ./result_8chains/node88_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_0 -p 333 -st none -pt topic88_2_0 -u 0.05046180681198942 > ./result_8chains/node88_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_0 -p 473 -st none -pt topic88_3_0 -u 0.0031404411031907276 > ./result_8chains/node88_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_0 -p 566 -st none -pt topic88_4_0 -u 0.009985392939850068 > ./result_8chains/node88_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_0 -p 630 -st none -pt topic88_5_0 -u 0.0065358785786261975 > ./result_8chains/node88_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_6_0 -p 696 -st none -pt topic88_6_0 -u 0.04421257533782255 > ./result_8chains/node88_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_7_0 -p 741 -st none -pt topic88_7_0 -u 0.039595176920833836 > ./result_8chains/node88_7_0.txt &
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
    "./result_8chains/node88_0_0.txt 90"
    "./result_8chains/node88_0_2.txt 90"
    "./result_8chains/node88_1_0.txt 89"
    "./result_8chains/node88_1_2.txt 89"
    "./result_8chains/node88_2_0.txt 88"
    "./result_8chains/node88_2_2.txt 88"
    "./result_8chains/node88_3_0.txt 87"
    "./result_8chains/node88_3_2.txt 87"
    "./result_8chains/node88_4_0.txt 86"
    "./result_8chains/node88_4_2.txt 86"
    "./result_8chains/node88_5_0.txt 85"
    "./result_8chains/node88_5_2.txt 85"
    "./result_8chains/node88_6_0.txt 84"
    "./result_8chains/node88_6_2.txt 84"
    "./result_8chains/node88_7_0.txt 83"
    "./result_8chains/node88_7_2.txt 83"
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
