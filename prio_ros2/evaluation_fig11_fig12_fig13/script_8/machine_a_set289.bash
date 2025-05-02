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
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_2 -p 164 -st topic289_0_1 -pt None -u 0.01094633715051152 > ./result_8chains/node289_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_2 -p 266 -st topic289_1_1 -pt None -u 0.0042232330059121526 > ./result_8chains/node289_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_2 -p 376 -st topic289_2_1 -pt None -u 0.01638773696453394 > ./result_8chains/node289_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_2 -p 512 -st topic289_3_1 -pt None -u 0.028655243795288915 > ./result_8chains/node289_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_2 -p 659 -st topic289_4_1 -pt None -u 0.001984414936366502 > ./result_8chains/node289_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_2 -p 805 -st topic289_5_1 -pt None -u 0.005022564044513844 > ./result_8chains/node289_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_2 -p 919 -st topic289_6_1 -pt None -u 0.010974377395202427 > ./result_8chains/node289_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_2 -p 927 -st topic289_7_1 -pt None -u 0.00284744315023859 > ./result_8chains/node289_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_0 -p 164 -st none -pt topic289_0_0 -u 0.015226900931333831 > ./result_8chains/node289_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_0 -p 266 -st none -pt topic289_1_0 -u 0.10677716725554914 > ./result_8chains/node289_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_0 -p 376 -st none -pt topic289_2_0 -u 0.024586311591457688 > ./result_8chains/node289_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_0 -p 512 -st none -pt topic289_3_0 -u 0.012457462012412712 > ./result_8chains/node289_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_0 -p 659 -st none -pt topic289_4_0 -u 0.05098759394403227 > ./result_8chains/node289_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_0 -p 805 -st none -pt topic289_5_0 -u 0.004110303560033002 > ./result_8chains/node289_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_0 -p 919 -st none -pt topic289_6_0 -u 0.019611633123504182 > ./result_8chains/node289_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_0 -p 927 -st none -pt topic289_7_0 -u 0.05322355314607445 > ./result_8chains/node289_7_0.txt &
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
    "./result_8chains/node289_0_0.txt 90"
    "./result_8chains/node289_0_2.txt 90"
    "./result_8chains/node289_1_0.txt 89"
    "./result_8chains/node289_1_2.txt 89"
    "./result_8chains/node289_2_0.txt 88"
    "./result_8chains/node289_2_2.txt 88"
    "./result_8chains/node289_3_0.txt 87"
    "./result_8chains/node289_3_2.txt 87"
    "./result_8chains/node289_4_0.txt 86"
    "./result_8chains/node289_4_2.txt 86"
    "./result_8chains/node289_5_0.txt 85"
    "./result_8chains/node289_5_2.txt 85"
    "./result_8chains/node289_6_0.txt 84"
    "./result_8chains/node289_6_2.txt 84"
    "./result_8chains/node289_7_0.txt 83"
    "./result_8chains/node289_7_2.txt 83"
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
