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
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_2 -p 161 -st topic229_0_1 -pt None -u 0.03071662288139343 > ./result_10chains/node229_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_2 -p 358 -st topic229_1_1 -pt None -u 0.019713114401589515 > ./result_10chains/node229_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_2 -p 369 -st topic229_2_1 -pt None -u 0.07164702323203914 > ./result_10chains/node229_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_2 -p 409 -st topic229_3_1 -pt None -u 0.02710011551689473 > ./result_10chains/node229_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_2 -p 435 -st topic229_4_1 -pt None -u 0.014687638231809547 > ./result_10chains/node229_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_2 -p 694 -st topic229_5_1 -pt None -u 0.023345947312055998 > ./result_10chains/node229_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_6_2 -p 820 -st topic229_6_1 -pt None -u 0.00890475577037847 > ./result_10chains/node229_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_7_2 -p 835 -st topic229_7_1 -pt None -u 0.029918101077676604 > ./result_10chains/node229_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_8_2 -p 891 -st topic229_8_1 -pt None -u 0.020093390606668718 > ./result_10chains/node229_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_9_2 -p 993 -st topic229_9_1 -pt None -u 0.02523334493031146 > ./result_10chains/node229_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_0 -p 161 -st none -pt topic229_0_0 -u 0.01217907537386742 > ./result_10chains/node229_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_0 -p 358 -st none -pt topic229_1_0 -u 0.019463484367110873 > ./result_10chains/node229_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_0 -p 369 -st none -pt topic229_2_0 -u 0.008229549432296202 > ./result_10chains/node229_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_0 -p 409 -st none -pt topic229_3_0 -u 0.002052401414651739 > ./result_10chains/node229_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_0 -p 435 -st none -pt topic229_4_0 -u 0.030469712108551206 > ./result_10chains/node229_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_0 -p 694 -st none -pt topic229_5_0 -u 0.0040874085564998885 > ./result_10chains/node229_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_6_0 -p 820 -st none -pt topic229_6_0 -u 0.004443849894383289 > ./result_10chains/node229_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_7_0 -p 835 -st none -pt topic229_7_0 -u 0.027448078739170934 > ./result_10chains/node229_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_8_0 -p 891 -st none -pt topic229_8_0 -u 0.044415341678246054 > ./result_10chains/node229_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_9_0 -p 993 -st none -pt topic229_9_0 -u 0.013609553170258814 > ./result_10chains/node229_9_0.txt &
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
    "./result_10chains/node229_0_0.txt 90"
    "./result_10chains/node229_0_2.txt 90"
    "./result_10chains/node229_1_0.txt 89"
    "./result_10chains/node229_1_2.txt 89"
    "./result_10chains/node229_2_0.txt 88"
    "./result_10chains/node229_2_2.txt 88"
    "./result_10chains/node229_3_0.txt 87"
    "./result_10chains/node229_3_2.txt 87"
    "./result_10chains/node229_4_0.txt 86"
    "./result_10chains/node229_4_2.txt 86"
    "./result_10chains/node229_5_0.txt 85"
    "./result_10chains/node229_5_2.txt 85"
    "./result_10chains/node229_6_0.txt 84"
    "./result_10chains/node229_6_2.txt 84"
    "./result_10chains/node229_7_0.txt 83"
    "./result_10chains/node229_7_2.txt 83"
    "./result_10chains/node229_8_0.txt 82"
    "./result_10chains/node229_8_2.txt 82"
    "./result_10chains/node229_9_0.txt 81"
    "./result_10chains/node229_9_2.txt 81"
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
