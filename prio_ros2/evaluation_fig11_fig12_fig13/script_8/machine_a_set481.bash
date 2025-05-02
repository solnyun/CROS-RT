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
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_2 -p 60 -st topic481_0_1 -pt None -u 0.0015094085973755278 > ./result_8chains/node481_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_2 -p 471 -st topic481_1_1 -pt None -u 0.03583235117892747 > ./result_8chains/node481_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_2 -p 497 -st topic481_2_1 -pt None -u 0.014648319954482902 > ./result_8chains/node481_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_2 -p 630 -st topic481_3_1 -pt None -u 0.003072482124258147 > ./result_8chains/node481_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_2 -p 694 -st topic481_4_1 -pt None -u 0.028175953688520383 > ./result_8chains/node481_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_2 -p 699 -st topic481_5_1 -pt None -u 0.020094009328781914 > ./result_8chains/node481_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_2 -p 755 -st topic481_6_1 -pt None -u 0.02170265429553328 > ./result_8chains/node481_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_2 -p 878 -st topic481_7_1 -pt None -u 0.0199149678555669 > ./result_8chains/node481_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_0 -p 60 -st none -pt topic481_0_0 -u 0.007023182326915178 > ./result_8chains/node481_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_0 -p 471 -st none -pt topic481_1_0 -u 0.00656386133012582 > ./result_8chains/node481_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_0 -p 497 -st none -pt topic481_2_0 -u 0.010561297446610829 > ./result_8chains/node481_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_0 -p 630 -st none -pt topic481_3_0 -u 0.0032178257295067403 > ./result_8chains/node481_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_0 -p 694 -st none -pt topic481_4_0 -u 0.004612563003532133 > ./result_8chains/node481_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_0 -p 699 -st none -pt topic481_5_0 -u 0.015596682335497936 > ./result_8chains/node481_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_0 -p 755 -st none -pt topic481_6_0 -u 0.017497050701777345 > ./result_8chains/node481_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_0 -p 878 -st none -pt topic481_7_0 -u 0.12941404583144747 > ./result_8chains/node481_7_0.txt &
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
    "./result_8chains/node481_0_0.txt 90"
    "./result_8chains/node481_0_2.txt 90"
    "./result_8chains/node481_1_0.txt 89"
    "./result_8chains/node481_1_2.txt 89"
    "./result_8chains/node481_2_0.txt 88"
    "./result_8chains/node481_2_2.txt 88"
    "./result_8chains/node481_3_0.txt 87"
    "./result_8chains/node481_3_2.txt 87"
    "./result_8chains/node481_4_0.txt 86"
    "./result_8chains/node481_4_2.txt 86"
    "./result_8chains/node481_5_0.txt 85"
    "./result_8chains/node481_5_2.txt 85"
    "./result_8chains/node481_6_0.txt 84"
    "./result_8chains/node481_6_2.txt 84"
    "./result_8chains/node481_7_0.txt 83"
    "./result_8chains/node481_7_2.txt 83"
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
