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
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_2 -p 66 -st topic365_0_1 -pt None -u 0.020013960568231792 > ./result_8chains/node365_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_2 -p 154 -st topic365_1_1 -pt None -u 0.001120066744453141 > ./result_8chains/node365_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_2 -p 386 -st topic365_2_1 -pt None -u 0.008467906161901517 > ./result_8chains/node365_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_2 -p 456 -st topic365_3_1 -pt None -u 0.016157543938202457 > ./result_8chains/node365_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_2 -p 623 -st topic365_4_1 -pt None -u 0.007952571109793888 > ./result_8chains/node365_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_2 -p 722 -st topic365_5_1 -pt None -u 0.003641200020044949 > ./result_8chains/node365_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_6_2 -p 835 -st topic365_6_1 -pt None -u 0.012242480164041836 > ./result_8chains/node365_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_7_2 -p 849 -st topic365_7_1 -pt None -u 0.004158188996850574 > ./result_8chains/node365_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_0 -p 66 -st none -pt topic365_0_0 -u 0.00026897383967194877 > ./result_8chains/node365_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_0 -p 154 -st none -pt topic365_1_0 -u 0.01906560143579239 > ./result_8chains/node365_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_0 -p 386 -st none -pt topic365_2_0 -u 0.010548969281974963 > ./result_8chains/node365_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_0 -p 456 -st none -pt topic365_3_0 -u 0.03792422528506234 > ./result_8chains/node365_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_0 -p 623 -st none -pt topic365_4_0 -u 0.005647039972662277 > ./result_8chains/node365_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_0 -p 722 -st none -pt topic365_5_0 -u 0.055153085363438936 > ./result_8chains/node365_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_6_0 -p 835 -st none -pt topic365_6_0 -u 0.01340619146842334 > ./result_8chains/node365_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_7_0 -p 849 -st none -pt topic365_7_0 -u 0.01495910623802145 > ./result_8chains/node365_7_0.txt &
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
    "./result_8chains/node365_0_0.txt 90"
    "./result_8chains/node365_0_2.txt 90"
    "./result_8chains/node365_1_0.txt 89"
    "./result_8chains/node365_1_2.txt 89"
    "./result_8chains/node365_2_0.txt 88"
    "./result_8chains/node365_2_2.txt 88"
    "./result_8chains/node365_3_0.txt 87"
    "./result_8chains/node365_3_2.txt 87"
    "./result_8chains/node365_4_0.txt 86"
    "./result_8chains/node365_4_2.txt 86"
    "./result_8chains/node365_5_0.txt 85"
    "./result_8chains/node365_5_2.txt 85"
    "./result_8chains/node365_6_0.txt 84"
    "./result_8chains/node365_6_2.txt 84"
    "./result_8chains/node365_7_0.txt 83"
    "./result_8chains/node365_7_2.txt 83"
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
