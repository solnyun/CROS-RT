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
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_2 -p 252 -st topic302_0_1 -pt None -u 0.020981387832086473 > ./result_8chains/node302_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_2 -p 312 -st topic302_1_1 -pt None -u 0.00663372903481263 > ./result_8chains/node302_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_2 -p 428 -st topic302_2_1 -pt None -u 0.005297049877049709 > ./result_8chains/node302_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_2 -p 558 -st topic302_3_1 -pt None -u 0.027700707350700016 > ./result_8chains/node302_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_2 -p 707 -st topic302_4_1 -pt None -u 0.013763812769242378 > ./result_8chains/node302_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_2 -p 849 -st topic302_5_1 -pt None -u 0.00135121642860897 > ./result_8chains/node302_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_6_2 -p 869 -st topic302_6_1 -pt None -u 0.011599460398211713 > ./result_8chains/node302_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_7_2 -p 903 -st topic302_7_1 -pt None -u 0.023512065358350178 > ./result_8chains/node302_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_0 -p 252 -st none -pt topic302_0_0 -u 0.028840427916722866 > ./result_8chains/node302_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_0 -p 312 -st none -pt topic302_1_0 -u 0.025517329634925534 > ./result_8chains/node302_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_0 -p 428 -st none -pt topic302_2_0 -u 0.003700288491255699 > ./result_8chains/node302_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_0 -p 558 -st none -pt topic302_3_0 -u 0.00711284373494564 > ./result_8chains/node302_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_0 -p 707 -st none -pt topic302_4_0 -u 0.03484556843905917 > ./result_8chains/node302_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_0 -p 849 -st none -pt topic302_5_0 -u 0.021659421167279536 > ./result_8chains/node302_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_6_0 -p 869 -st none -pt topic302_6_0 -u 0.026133935921242912 > ./result_8chains/node302_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_7_0 -p 903 -st none -pt topic302_7_0 -u 0.009412208965682026 > ./result_8chains/node302_7_0.txt &
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
    "./result_8chains/node302_0_0.txt 90"
    "./result_8chains/node302_0_2.txt 90"
    "./result_8chains/node302_1_0.txt 89"
    "./result_8chains/node302_1_2.txt 89"
    "./result_8chains/node302_2_0.txt 88"
    "./result_8chains/node302_2_2.txt 88"
    "./result_8chains/node302_3_0.txt 87"
    "./result_8chains/node302_3_2.txt 87"
    "./result_8chains/node302_4_0.txt 86"
    "./result_8chains/node302_4_2.txt 86"
    "./result_8chains/node302_5_0.txt 85"
    "./result_8chains/node302_5_2.txt 85"
    "./result_8chains/node302_6_0.txt 84"
    "./result_8chains/node302_6_2.txt 84"
    "./result_8chains/node302_7_0.txt 83"
    "./result_8chains/node302_7_2.txt 83"
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
