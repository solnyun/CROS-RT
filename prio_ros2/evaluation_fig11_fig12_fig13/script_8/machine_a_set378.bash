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
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_2 -p 88 -st topic378_0_1 -pt None -u 0.015327097388812994 > ./result_8chains/node378_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_2 -p 138 -st topic378_1_1 -pt None -u 0.01832769504424947 > ./result_8chains/node378_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_2 -p 322 -st topic378_2_1 -pt None -u 0.012447601891463655 > ./result_8chains/node378_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_2 -p 421 -st topic378_3_1 -pt None -u 0.03223743712084909 > ./result_8chains/node378_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_2 -p 497 -st topic378_4_1 -pt None -u 0.01850778900362214 > ./result_8chains/node378_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_2 -p 557 -st topic378_5_1 -pt None -u 0.005252635769127462 > ./result_8chains/node378_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_2 -p 607 -st topic378_6_1 -pt None -u 0.004350934712263957 > ./result_8chains/node378_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_2 -p 940 -st topic378_7_1 -pt None -u 0.011783035851497382 > ./result_8chains/node378_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_0 -p 88 -st none -pt topic378_0_0 -u 0.00668270449696956 > ./result_8chains/node378_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_0 -p 138 -st none -pt topic378_1_0 -u 0.035666824047254186 > ./result_8chains/node378_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_0 -p 322 -st none -pt topic378_2_0 -u 0.008184345707251017 > ./result_8chains/node378_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_0 -p 421 -st none -pt topic378_3_0 -u 0.024552307980066135 > ./result_8chains/node378_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_0 -p 497 -st none -pt topic378_4_0 -u 0.06162255200137012 > ./result_8chains/node378_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_0 -p 557 -st none -pt topic378_5_0 -u 0.004049621172252091 > ./result_8chains/node378_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_0 -p 607 -st none -pt topic378_6_0 -u 0.00851886758385044 > ./result_8chains/node378_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_0 -p 940 -st none -pt topic378_7_0 -u 0.034992190041632926 > ./result_8chains/node378_7_0.txt &
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
    "./result_8chains/node378_0_0.txt 90"
    "./result_8chains/node378_0_2.txt 90"
    "./result_8chains/node378_1_0.txt 89"
    "./result_8chains/node378_1_2.txt 89"
    "./result_8chains/node378_2_0.txt 88"
    "./result_8chains/node378_2_2.txt 88"
    "./result_8chains/node378_3_0.txt 87"
    "./result_8chains/node378_3_2.txt 87"
    "./result_8chains/node378_4_0.txt 86"
    "./result_8chains/node378_4_2.txt 86"
    "./result_8chains/node378_5_0.txt 85"
    "./result_8chains/node378_5_2.txt 85"
    "./result_8chains/node378_6_0.txt 84"
    "./result_8chains/node378_6_2.txt 84"
    "./result_8chains/node378_7_0.txt 83"
    "./result_8chains/node378_7_2.txt 83"
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
