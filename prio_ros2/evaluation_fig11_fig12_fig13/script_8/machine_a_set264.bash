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
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_2 -p 34 -st topic264_0_1 -pt None -u 0.011343202641345196 > ./result_8chains/node264_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_2 -p 150 -st topic264_1_1 -pt None -u 0.00546095943674374 > ./result_8chains/node264_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_2 -p 363 -st topic264_2_1 -pt None -u 0.0013094858994535663 > ./result_8chains/node264_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_2 -p 498 -st topic264_3_1 -pt None -u 0.012060380759489786 > ./result_8chains/node264_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_2 -p 506 -st topic264_4_1 -pt None -u 0.008260095691572517 > ./result_8chains/node264_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_2 -p 587 -st topic264_5_1 -pt None -u 0.02094900370335305 > ./result_8chains/node264_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_2 -p 810 -st topic264_6_1 -pt None -u 0.003343312682723032 > ./result_8chains/node264_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_2 -p 939 -st topic264_7_1 -pt None -u 0.06326117500804879 > ./result_8chains/node264_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_0 -p 34 -st none -pt topic264_0_0 -u 0.02133651891429439 > ./result_8chains/node264_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_0 -p 150 -st none -pt topic264_1_0 -u 0.005096784872194171 > ./result_8chains/node264_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_0 -p 363 -st none -pt topic264_2_0 -u 0.039902409308756714 > ./result_8chains/node264_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_0 -p 498 -st none -pt topic264_3_0 -u 0.007441210314185764 > ./result_8chains/node264_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_0 -p 506 -st none -pt topic264_4_0 -u 0.01813320912475261 > ./result_8chains/node264_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_0 -p 587 -st none -pt topic264_5_0 -u 0.018034080568009925 > ./result_8chains/node264_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_0 -p 810 -st none -pt topic264_6_0 -u 0.0092158573588942 > ./result_8chains/node264_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_0 -p 939 -st none -pt topic264_7_0 -u 0.002912913672363737 > ./result_8chains/node264_7_0.txt &
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
    "./result_8chains/node264_0_0.txt 90"
    "./result_8chains/node264_0_2.txt 90"
    "./result_8chains/node264_1_0.txt 89"
    "./result_8chains/node264_1_2.txt 89"
    "./result_8chains/node264_2_0.txt 88"
    "./result_8chains/node264_2_2.txt 88"
    "./result_8chains/node264_3_0.txt 87"
    "./result_8chains/node264_3_2.txt 87"
    "./result_8chains/node264_4_0.txt 86"
    "./result_8chains/node264_4_2.txt 86"
    "./result_8chains/node264_5_0.txt 85"
    "./result_8chains/node264_5_2.txt 85"
    "./result_8chains/node264_6_0.txt 84"
    "./result_8chains/node264_6_2.txt 84"
    "./result_8chains/node264_7_0.txt 83"
    "./result_8chains/node264_7_2.txt 83"
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
