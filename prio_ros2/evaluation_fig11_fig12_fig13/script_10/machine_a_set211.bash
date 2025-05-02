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
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_2 -p 10 -st topic211_0_1 -pt None -u 0.0008101435196610773 > ./result_10chains/node211_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_2 -p 30 -st topic211_1_1 -pt None -u 0.014747096574805718 > ./result_10chains/node211_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_2 -p 319 -st topic211_2_1 -pt None -u 0.001778704086817573 > ./result_10chains/node211_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_2 -p 344 -st topic211_3_1 -pt None -u 0.03980579514259136 > ./result_10chains/node211_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_2 -p 415 -st topic211_4_1 -pt None -u 0.03874978209960869 > ./result_10chains/node211_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_2 -p 677 -st topic211_5_1 -pt None -u 0.0008483693272366422 > ./result_10chains/node211_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_6_2 -p 700 -st topic211_6_1 -pt None -u 0.027452013296984407 > ./result_10chains/node211_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_7_2 -p 704 -st topic211_7_1 -pt None -u 0.026803693304580878 > ./result_10chains/node211_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_8_2 -p 769 -st topic211_8_1 -pt None -u 0.027502653045981894 > ./result_10chains/node211_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_9_2 -p 852 -st topic211_9_1 -pt None -u 0.007040722874598799 > ./result_10chains/node211_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_0 -p 10 -st none -pt topic211_0_0 -u 0.0012791649834691388 > ./result_10chains/node211_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_0 -p 30 -st none -pt topic211_1_0 -u 0.013016834486641093 > ./result_10chains/node211_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_0 -p 319 -st none -pt topic211_2_0 -u 0.03314345572542482 > ./result_10chains/node211_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_0 -p 344 -st none -pt topic211_3_0 -u 0.0062993773886027005 > ./result_10chains/node211_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_0 -p 415 -st none -pt topic211_4_0 -u 0.03178803405709485 > ./result_10chains/node211_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_0 -p 677 -st none -pt topic211_5_0 -u 0.023621398967577256 > ./result_10chains/node211_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_6_0 -p 700 -st none -pt topic211_6_0 -u 0.003168139116003804 > ./result_10chains/node211_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_7_0 -p 704 -st none -pt topic211_7_0 -u 0.004635433745458384 > ./result_10chains/node211_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_8_0 -p 769 -st none -pt topic211_8_0 -u 0.006327938323260354 > ./result_10chains/node211_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_9_0 -p 852 -st none -pt topic211_9_0 -u 0.018635565208205262 > ./result_10chains/node211_9_0.txt &
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
    "./result_10chains/node211_0_0.txt 90"
    "./result_10chains/node211_0_2.txt 90"
    "./result_10chains/node211_1_0.txt 89"
    "./result_10chains/node211_1_2.txt 89"
    "./result_10chains/node211_2_0.txt 88"
    "./result_10chains/node211_2_2.txt 88"
    "./result_10chains/node211_3_0.txt 87"
    "./result_10chains/node211_3_2.txt 87"
    "./result_10chains/node211_4_0.txt 86"
    "./result_10chains/node211_4_2.txt 86"
    "./result_10chains/node211_5_0.txt 85"
    "./result_10chains/node211_5_2.txt 85"
    "./result_10chains/node211_6_0.txt 84"
    "./result_10chains/node211_6_2.txt 84"
    "./result_10chains/node211_7_0.txt 83"
    "./result_10chains/node211_7_2.txt 83"
    "./result_10chains/node211_8_0.txt 82"
    "./result_10chains/node211_8_2.txt 82"
    "./result_10chains/node211_9_0.txt 81"
    "./result_10chains/node211_9_2.txt 81"
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
