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
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_2 -p 61 -st topic17_0_1 -pt None -u 0.04243368697013178 > ./result_10chains/node17_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_2 -p 137 -st topic17_1_1 -pt None -u 0.007347750583434454 > ./result_10chains/node17_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_2 -p 354 -st topic17_2_1 -pt None -u 0.0037789614571909214 > ./result_10chains/node17_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_2 -p 391 -st topic17_3_1 -pt None -u 0.0023123627780202716 > ./result_10chains/node17_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_2 -p 488 -st topic17_4_1 -pt None -u 0.023665609389283526 > ./result_10chains/node17_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_2 -p 558 -st topic17_5_1 -pt None -u 0.006279044632425762 > ./result_10chains/node17_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_2 -p 607 -st topic17_6_1 -pt None -u 0.0033030077980496786 > ./result_10chains/node17_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_2 -p 691 -st topic17_7_1 -pt None -u 0.00922936540423741 > ./result_10chains/node17_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_8_2 -p 704 -st topic17_8_1 -pt None -u 0.023712082678269464 > ./result_10chains/node17_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_9_2 -p 877 -st topic17_9_1 -pt None -u 0.009350869333988262 > ./result_10chains/node17_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_0 -p 61 -st none -pt topic17_0_0 -u 0.0035843220191280056 > ./result_10chains/node17_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_0 -p 137 -st none -pt topic17_1_0 -u 0.006023317552633856 > ./result_10chains/node17_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_0 -p 354 -st none -pt topic17_2_0 -u 0.026300736164040495 > ./result_10chains/node17_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_0 -p 391 -st none -pt topic17_3_0 -u 0.01760533881018761 > ./result_10chains/node17_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_0 -p 488 -st none -pt topic17_4_0 -u 0.030392197682754973 > ./result_10chains/node17_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_0 -p 558 -st none -pt topic17_5_0 -u 0.016013754220110532 > ./result_10chains/node17_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_0 -p 607 -st none -pt topic17_6_0 -u 0.014909741988411968 > ./result_10chains/node17_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_0 -p 691 -st none -pt topic17_7_0 -u 0.0051927545524475816 > ./result_10chains/node17_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_8_0 -p 704 -st none -pt topic17_8_0 -u 0.04571616958416 > ./result_10chains/node17_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_9_0 -p 877 -st none -pt topic17_9_0 -u 0.07429743015266117 > ./result_10chains/node17_9_0.txt &
sleep 10
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
    "./result_10chains/node17_0_0.txt 90"
    "./result_10chains/node17_0_2.txt 90"
    "./result_10chains/node17_1_0.txt 89"
    "./result_10chains/node17_1_2.txt 89"
    "./result_10chains/node17_2_0.txt 88"
    "./result_10chains/node17_2_2.txt 88"
    "./result_10chains/node17_3_0.txt 87"
    "./result_10chains/node17_3_2.txt 87"
    "./result_10chains/node17_4_0.txt 86"
    "./result_10chains/node17_4_2.txt 86"
    "./result_10chains/node17_5_0.txt 85"
    "./result_10chains/node17_5_2.txt 85"
    "./result_10chains/node17_6_0.txt 84"
    "./result_10chains/node17_6_2.txt 84"
    "./result_10chains/node17_7_0.txt 83"
    "./result_10chains/node17_7_2.txt 83"
    "./result_10chains/node17_8_0.txt 82"
    "./result_10chains/node17_8_2.txt 82"
    "./result_10chains/node17_9_0.txt 81"
    "./result_10chains/node17_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
