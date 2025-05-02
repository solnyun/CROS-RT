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
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_2 -p 29 -st topic97_0_1 -pt None -u 0.00020273272267190556 > ./result_10chains/node97_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_2 -p 174 -st topic97_1_1 -pt None -u 0.0005190410666539025 > ./result_10chains/node97_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_2 -p 231 -st topic97_2_1 -pt None -u 0.014518801457619523 > ./result_10chains/node97_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_2 -p 232 -st topic97_3_1 -pt None -u 0.004249141711474946 > ./result_10chains/node97_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_2 -p 330 -st topic97_4_1 -pt None -u 0.019041274015852372 > ./result_10chains/node97_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_2 -p 405 -st topic97_5_1 -pt None -u 0.00028869830890346226 > ./result_10chains/node97_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_6_2 -p 496 -st topic97_6_1 -pt None -u 0.006115977087930713 > ./result_10chains/node97_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_7_2 -p 559 -st topic97_7_1 -pt None -u 0.0021149346708019545 > ./result_10chains/node97_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_8_2 -p 594 -st topic97_8_1 -pt None -u 0.04580389023747498 > ./result_10chains/node97_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_9_2 -p 733 -st topic97_9_1 -pt None -u 0.008195413016267993 > ./result_10chains/node97_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_0 -p 29 -st none -pt topic97_0_0 -u 0.0007436004553115771 > ./result_10chains/node97_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_0 -p 174 -st none -pt topic97_1_0 -u 0.031257592831740566 > ./result_10chains/node97_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_0 -p 231 -st none -pt topic97_2_0 -u 0.014460557396962948 > ./result_10chains/node97_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_0 -p 232 -st none -pt topic97_3_0 -u 0.04691052805971918 > ./result_10chains/node97_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_0 -p 330 -st none -pt topic97_4_0 -u 0.017556629039034988 > ./result_10chains/node97_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_0 -p 405 -st none -pt topic97_5_0 -u 0.023566366287455343 > ./result_10chains/node97_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_6_0 -p 496 -st none -pt topic97_6_0 -u 0.018422940691489226 > ./result_10chains/node97_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_7_0 -p 559 -st none -pt topic97_7_0 -u 0.000964246747845704 > ./result_10chains/node97_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_8_0 -p 594 -st none -pt topic97_8_0 -u 0.052116027835953996 > ./result_10chains/node97_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_9_0 -p 733 -st none -pt topic97_9_0 -u 0.018560466660406588 > ./result_10chains/node97_9_0.txt &
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
    "./result_10chains/node97_0_0.txt 90"
    "./result_10chains/node97_0_2.txt 90"
    "./result_10chains/node97_1_0.txt 89"
    "./result_10chains/node97_1_2.txt 89"
    "./result_10chains/node97_2_0.txt 88"
    "./result_10chains/node97_2_2.txt 88"
    "./result_10chains/node97_3_0.txt 87"
    "./result_10chains/node97_3_2.txt 87"
    "./result_10chains/node97_4_0.txt 86"
    "./result_10chains/node97_4_2.txt 86"
    "./result_10chains/node97_5_0.txt 85"
    "./result_10chains/node97_5_2.txt 85"
    "./result_10chains/node97_6_0.txt 84"
    "./result_10chains/node97_6_2.txt 84"
    "./result_10chains/node97_7_0.txt 83"
    "./result_10chains/node97_7_2.txt 83"
    "./result_10chains/node97_8_0.txt 82"
    "./result_10chains/node97_8_2.txt 82"
    "./result_10chains/node97_9_0.txt 81"
    "./result_10chains/node97_9_2.txt 81"
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
