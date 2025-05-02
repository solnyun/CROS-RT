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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_2 -p 109 -st topic232_0_1 -pt None -u 0.03421020201927155 > ./result_10chains/node232_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_2 -p 228 -st topic232_1_1 -pt None -u 0.004177170003932418 > ./result_10chains/node232_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_2 -p 385 -st topic232_2_1 -pt None -u 0.0295027357350226 > ./result_10chains/node232_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_2 -p 692 -st topic232_3_1 -pt None -u 0.03289782968678501 > ./result_10chains/node232_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_2 -p 759 -st topic232_4_1 -pt None -u 0.02233397437800949 > ./result_10chains/node232_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_2 -p 786 -st topic232_5_1 -pt None -u 0.00020635744105074183 > ./result_10chains/node232_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_2 -p 807 -st topic232_6_1 -pt None -u 0.009015733489492195 > ./result_10chains/node232_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_2 -p 812 -st topic232_7_1 -pt None -u 0.01883918471200363 > ./result_10chains/node232_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_8_2 -p 867 -st topic232_8_1 -pt None -u 0.012909176406299683 > ./result_10chains/node232_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_9_2 -p 896 -st topic232_9_1 -pt None -u 0.013849709343420582 > ./result_10chains/node232_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_0 -p 109 -st none -pt topic232_0_0 -u 0.05076497698676202 > ./result_10chains/node232_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_0 -p 228 -st none -pt topic232_1_0 -u 0.022487779255674634 > ./result_10chains/node232_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_0 -p 385 -st none -pt topic232_2_0 -u 0.003987794697303149 > ./result_10chains/node232_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_0 -p 692 -st none -pt topic232_3_0 -u 0.010961422849445068 > ./result_10chains/node232_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_0 -p 759 -st none -pt topic232_4_0 -u 0.021697841863073386 > ./result_10chains/node232_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_0 -p 786 -st none -pt topic232_5_0 -u 0.02313175585077623 > ./result_10chains/node232_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_0 -p 807 -st none -pt topic232_6_0 -u 0.008648661024697524 > ./result_10chains/node232_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_0 -p 812 -st none -pt topic232_7_0 -u 0.0024466981923354503 > ./result_10chains/node232_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_8_0 -p 867 -st none -pt topic232_8_0 -u 0.011156749770358534 > ./result_10chains/node232_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_9_0 -p 896 -st none -pt topic232_9_0 -u 0.03471025203316254 > ./result_10chains/node232_9_0.txt &
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
    "./result_10chains/node232_0_0.txt 90"
    "./result_10chains/node232_0_2.txt 90"
    "./result_10chains/node232_1_0.txt 89"
    "./result_10chains/node232_1_2.txt 89"
    "./result_10chains/node232_2_0.txt 88"
    "./result_10chains/node232_2_2.txt 88"
    "./result_10chains/node232_3_0.txt 87"
    "./result_10chains/node232_3_2.txt 87"
    "./result_10chains/node232_4_0.txt 86"
    "./result_10chains/node232_4_2.txt 86"
    "./result_10chains/node232_5_0.txt 85"
    "./result_10chains/node232_5_2.txt 85"
    "./result_10chains/node232_6_0.txt 84"
    "./result_10chains/node232_6_2.txt 84"
    "./result_10chains/node232_7_0.txt 83"
    "./result_10chains/node232_7_2.txt 83"
    "./result_10chains/node232_8_0.txt 82"
    "./result_10chains/node232_8_2.txt 82"
    "./result_10chains/node232_9_0.txt 81"
    "./result_10chains/node232_9_2.txt 81"
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
