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
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_2 -p 79 -st topic151_0_1 -pt None -u 0.022614638234454087 > ./result_10chains/node151_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_2 -p 109 -st topic151_1_1 -pt None -u 0.01437940847793967 > ./result_10chains/node151_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_2 -p 163 -st topic151_2_1 -pt None -u 0.019093523381871425 > ./result_10chains/node151_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_2 -p 199 -st topic151_3_1 -pt None -u 0.008520521309578366 > ./result_10chains/node151_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_2 -p 369 -st topic151_4_1 -pt None -u 0.01680110755296982 > ./result_10chains/node151_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_2 -p 623 -st topic151_5_1 -pt None -u 0.019863996318086746 > ./result_10chains/node151_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_2 -p 646 -st topic151_6_1 -pt None -u 0.0316756821206344 > ./result_10chains/node151_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_2 -p 660 -st topic151_7_1 -pt None -u 0.02021176073655785 > ./result_10chains/node151_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_8_2 -p 958 -st topic151_8_1 -pt None -u 0.024506031142606473 > ./result_10chains/node151_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_9_2 -p 992 -st topic151_9_1 -pt None -u 0.010407806017120826 > ./result_10chains/node151_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_0 -p 79 -st none -pt topic151_0_0 -u 0.02350911627197866 > ./result_10chains/node151_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_0 -p 109 -st none -pt topic151_1_0 -u 0.001271773530896858 > ./result_10chains/node151_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_0 -p 163 -st none -pt topic151_2_0 -u 0.003189796982194515 > ./result_10chains/node151_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_0 -p 199 -st none -pt topic151_3_0 -u 0.017679689717971403 > ./result_10chains/node151_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_0 -p 369 -st none -pt topic151_4_0 -u 0.0023098582814155555 > ./result_10chains/node151_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_0 -p 623 -st none -pt topic151_5_0 -u 0.029419460925060675 > ./result_10chains/node151_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_0 -p 646 -st none -pt topic151_6_0 -u 0.012908326694156647 > ./result_10chains/node151_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_0 -p 660 -st none -pt topic151_7_0 -u 0.02334001999546692 > ./result_10chains/node151_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_8_0 -p 958 -st none -pt topic151_8_0 -u 0.014300325445844628 > ./result_10chains/node151_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_9_0 -p 992 -st none -pt topic151_9_0 -u 0.028001026525471834 > ./result_10chains/node151_9_0.txt &
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
    "./result_10chains/node151_0_0.txt 90"
    "./result_10chains/node151_0_2.txt 90"
    "./result_10chains/node151_1_0.txt 89"
    "./result_10chains/node151_1_2.txt 89"
    "./result_10chains/node151_2_0.txt 88"
    "./result_10chains/node151_2_2.txt 88"
    "./result_10chains/node151_3_0.txt 87"
    "./result_10chains/node151_3_2.txt 87"
    "./result_10chains/node151_4_0.txt 86"
    "./result_10chains/node151_4_2.txt 86"
    "./result_10chains/node151_5_0.txt 85"
    "./result_10chains/node151_5_2.txt 85"
    "./result_10chains/node151_6_0.txt 84"
    "./result_10chains/node151_6_2.txt 84"
    "./result_10chains/node151_7_0.txt 83"
    "./result_10chains/node151_7_2.txt 83"
    "./result_10chains/node151_8_0.txt 82"
    "./result_10chains/node151_8_2.txt 82"
    "./result_10chains/node151_9_0.txt 81"
    "./result_10chains/node151_9_2.txt 81"
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
