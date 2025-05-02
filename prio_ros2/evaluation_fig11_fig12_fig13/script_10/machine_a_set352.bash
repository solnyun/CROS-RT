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
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_2 -p 192 -st topic352_0_1 -pt None -u 0.0874708272614097 > ./result_10chains/node352_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_2 -p 233 -st topic352_1_1 -pt None -u 0.0005732437810732627 > ./result_10chains/node352_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_2 -p 250 -st topic352_2_1 -pt None -u 0.00397942303662191 > ./result_10chains/node352_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_2 -p 684 -st topic352_3_1 -pt None -u 0.014622609625196348 > ./result_10chains/node352_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_2 -p 709 -st topic352_4_1 -pt None -u 0.016824045827394996 > ./result_10chains/node352_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_2 -p 760 -st topic352_5_1 -pt None -u 0.05418780293319761 > ./result_10chains/node352_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_6_2 -p 762 -st topic352_6_1 -pt None -u 0.004616865300263756 > ./result_10chains/node352_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_7_2 -p 871 -st topic352_7_1 -pt None -u 0.0008899107822529506 > ./result_10chains/node352_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_8_2 -p 888 -st topic352_8_1 -pt None -u 0.0022664741169459157 > ./result_10chains/node352_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_9_2 -p 956 -st topic352_9_1 -pt None -u 0.002480712641044894 > ./result_10chains/node352_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_0 -p 192 -st none -pt topic352_0_0 -u 0.013295302346368665 > ./result_10chains/node352_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_0 -p 233 -st none -pt topic352_1_0 -u 0.009085101587076594 > ./result_10chains/node352_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_0 -p 250 -st none -pt topic352_2_0 -u 0.004604435992599132 > ./result_10chains/node352_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_0 -p 684 -st none -pt topic352_3_0 -u 0.0038314854927012365 > ./result_10chains/node352_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_0 -p 709 -st none -pt topic352_4_0 -u 0.005207771199679745 > ./result_10chains/node352_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_0 -p 760 -st none -pt topic352_5_0 -u 0.005616937828322843 > ./result_10chains/node352_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_6_0 -p 762 -st none -pt topic352_6_0 -u 0.05198853061464409 > ./result_10chains/node352_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_7_0 -p 871 -st none -pt topic352_7_0 -u 0.0191294699912766 > ./result_10chains/node352_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_8_0 -p 888 -st none -pt topic352_8_0 -u 0.0005619380975199623 > ./result_10chains/node352_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_9_0 -p 956 -st none -pt topic352_9_0 -u 0.059648679987813716 > ./result_10chains/node352_9_0.txt &
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
    "./result_10chains/node352_0_0.txt 90"
    "./result_10chains/node352_0_2.txt 90"
    "./result_10chains/node352_1_0.txt 89"
    "./result_10chains/node352_1_2.txt 89"
    "./result_10chains/node352_2_0.txt 88"
    "./result_10chains/node352_2_2.txt 88"
    "./result_10chains/node352_3_0.txt 87"
    "./result_10chains/node352_3_2.txt 87"
    "./result_10chains/node352_4_0.txt 86"
    "./result_10chains/node352_4_2.txt 86"
    "./result_10chains/node352_5_0.txt 85"
    "./result_10chains/node352_5_2.txt 85"
    "./result_10chains/node352_6_0.txt 84"
    "./result_10chains/node352_6_2.txt 84"
    "./result_10chains/node352_7_0.txt 83"
    "./result_10chains/node352_7_2.txt 83"
    "./result_10chains/node352_8_0.txt 82"
    "./result_10chains/node352_8_2.txt 82"
    "./result_10chains/node352_9_0.txt 81"
    "./result_10chains/node352_9_2.txt 81"
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
