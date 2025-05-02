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
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_2 -p 272 -st topic53_0_1 -pt None -u 0.048349165455130905 > ./result_8chains/node53_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_2 -p 470 -st topic53_1_1 -pt None -u 0.0016031754743517923 > ./result_8chains/node53_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_2 -p 515 -st topic53_2_1 -pt None -u 0.00047332893131873943 > ./result_8chains/node53_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_2 -p 713 -st topic53_3_1 -pt None -u 0.0003181809610958708 > ./result_8chains/node53_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_2 -p 735 -st topic53_4_1 -pt None -u 0.0036875806008140333 > ./result_8chains/node53_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_2 -p 858 -st topic53_5_1 -pt None -u 0.020228418819672703 > ./result_8chains/node53_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_6_2 -p 865 -st topic53_6_1 -pt None -u 0.002051106209991063 > ./result_8chains/node53_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_7_2 -p 926 -st topic53_7_1 -pt None -u 0.007422000946573138 > ./result_8chains/node53_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_0 -p 272 -st none -pt topic53_0_0 -u 0.030038909402481717 > ./result_8chains/node53_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_0 -p 470 -st none -pt topic53_1_0 -u 0.04073535141554657 > ./result_8chains/node53_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_0 -p 515 -st none -pt topic53_2_0 -u 0.00932060915927091 > ./result_8chains/node53_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_0 -p 713 -st none -pt topic53_3_0 -u 0.008689077280413071 > ./result_8chains/node53_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_0 -p 735 -st none -pt topic53_4_0 -u 0.04486164666597431 > ./result_8chains/node53_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_0 -p 858 -st none -pt topic53_5_0 -u 0.019419068912764625 > ./result_8chains/node53_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_6_0 -p 865 -st none -pt topic53_6_0 -u 0.02032919567698259 > ./result_8chains/node53_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_7_0 -p 926 -st none -pt topic53_7_0 -u 0.025158293275873454 > ./result_8chains/node53_7_0.txt &
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
    "./result_8chains/node53_0_0.txt 90"
    "./result_8chains/node53_0_2.txt 90"
    "./result_8chains/node53_1_0.txt 89"
    "./result_8chains/node53_1_2.txt 89"
    "./result_8chains/node53_2_0.txt 88"
    "./result_8chains/node53_2_2.txt 88"
    "./result_8chains/node53_3_0.txt 87"
    "./result_8chains/node53_3_2.txt 87"
    "./result_8chains/node53_4_0.txt 86"
    "./result_8chains/node53_4_2.txt 86"
    "./result_8chains/node53_5_0.txt 85"
    "./result_8chains/node53_5_2.txt 85"
    "./result_8chains/node53_6_0.txt 84"
    "./result_8chains/node53_6_2.txt 84"
    "./result_8chains/node53_7_0.txt 83"
    "./result_8chains/node53_7_2.txt 83"
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
