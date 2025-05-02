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
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_2 -p 197 -st topic478_0_1 -pt None -u 0.027800109738400358 > ./result_8chains/node478_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_2 -p 244 -st topic478_1_1 -pt None -u 0.019719431413769806 > ./result_8chains/node478_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_2 -p 297 -st topic478_2_1 -pt None -u 0.000771057021582422 > ./result_8chains/node478_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_2 -p 409 -st topic478_3_1 -pt None -u 0.026981445784379443 > ./result_8chains/node478_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_2 -p 603 -st topic478_4_1 -pt None -u 0.010523028775965726 > ./result_8chains/node478_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_2 -p 721 -st topic478_5_1 -pt None -u 0.020970238974363564 > ./result_8chains/node478_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_2 -p 803 -st topic478_6_1 -pt None -u 0.012666454459596646 > ./result_8chains/node478_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_2 -p 961 -st topic478_7_1 -pt None -u 0.02021435297073952 > ./result_8chains/node478_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_0 -p 197 -st none -pt topic478_0_0 -u 0.010950731047201512 > ./result_8chains/node478_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_0 -p 244 -st none -pt topic478_1_0 -u 0.0016918827958073979 > ./result_8chains/node478_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_0 -p 297 -st none -pt topic478_2_0 -u 0.007459683989204879 > ./result_8chains/node478_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_0 -p 409 -st none -pt topic478_3_0 -u 0.03129055368157968 > ./result_8chains/node478_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_0 -p 603 -st none -pt topic478_4_0 -u 0.0027792601717987475 > ./result_8chains/node478_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_0 -p 721 -st none -pt topic478_5_0 -u 0.01373480410988931 > ./result_8chains/node478_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_0 -p 803 -st none -pt topic478_6_0 -u 0.017067799214191298 > ./result_8chains/node478_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_0 -p 961 -st none -pt topic478_7_0 -u 0.03399253778741697 > ./result_8chains/node478_7_0.txt &
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
    "./result_8chains/node478_0_0.txt 90"
    "./result_8chains/node478_0_2.txt 90"
    "./result_8chains/node478_1_0.txt 89"
    "./result_8chains/node478_1_2.txt 89"
    "./result_8chains/node478_2_0.txt 88"
    "./result_8chains/node478_2_2.txt 88"
    "./result_8chains/node478_3_0.txt 87"
    "./result_8chains/node478_3_2.txt 87"
    "./result_8chains/node478_4_0.txt 86"
    "./result_8chains/node478_4_2.txt 86"
    "./result_8chains/node478_5_0.txt 85"
    "./result_8chains/node478_5_2.txt 85"
    "./result_8chains/node478_6_0.txt 84"
    "./result_8chains/node478_6_2.txt 84"
    "./result_8chains/node478_7_0.txt 83"
    "./result_8chains/node478_7_2.txt 83"
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
