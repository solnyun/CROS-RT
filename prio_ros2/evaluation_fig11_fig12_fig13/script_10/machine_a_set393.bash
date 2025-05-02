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
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_2 -p 145 -st topic393_0_1 -pt None -u 0.008327774748425332 > ./result_10chains/node393_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_2 -p 439 -st topic393_1_1 -pt None -u 0.006820634456685182 > ./result_10chains/node393_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_2 -p 501 -st topic393_2_1 -pt None -u 0.027673499095835552 > ./result_10chains/node393_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_2 -p 659 -st topic393_3_1 -pt None -u 0.017778471988981415 > ./result_10chains/node393_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_2 -p 678 -st topic393_4_1 -pt None -u 0.024032506892136707 > ./result_10chains/node393_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_2 -p 781 -st topic393_5_1 -pt None -u 0.015055578825847654 > ./result_10chains/node393_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_6_2 -p 838 -st topic393_6_1 -pt None -u 0.00099527979811187 > ./result_10chains/node393_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_7_2 -p 899 -st topic393_7_1 -pt None -u 0.015431469019325988 > ./result_10chains/node393_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_8_2 -p 902 -st topic393_8_1 -pt None -u 0.053650072649592095 > ./result_10chains/node393_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_9_2 -p 961 -st topic393_9_1 -pt None -u 0.046627671548568485 > ./result_10chains/node393_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_0 -p 145 -st none -pt topic393_0_0 -u 0.00857445161310355 > ./result_10chains/node393_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_0 -p 439 -st none -pt topic393_1_0 -u 0.05009305228385197 > ./result_10chains/node393_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_0 -p 501 -st none -pt topic393_2_0 -u 0.006917902003345744 > ./result_10chains/node393_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_0 -p 659 -st none -pt topic393_3_0 -u 0.004315202625497894 > ./result_10chains/node393_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_0 -p 678 -st none -pt topic393_4_0 -u 0.0033885028756699964 > ./result_10chains/node393_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_0 -p 781 -st none -pt topic393_5_0 -u 0.010471130650467897 > ./result_10chains/node393_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_6_0 -p 838 -st none -pt topic393_6_0 -u 0.008341112349084079 > ./result_10chains/node393_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_7_0 -p 899 -st none -pt topic393_7_0 -u 0.026687055715773372 > ./result_10chains/node393_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_8_0 -p 902 -st none -pt topic393_8_0 -u 0.013362085973885274 > ./result_10chains/node393_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_9_0 -p 961 -st none -pt topic393_9_0 -u 0.043274648609306215 > ./result_10chains/node393_9_0.txt &
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
    "./result_10chains/node393_0_0.txt 90"
    "./result_10chains/node393_0_2.txt 90"
    "./result_10chains/node393_1_0.txt 89"
    "./result_10chains/node393_1_2.txt 89"
    "./result_10chains/node393_2_0.txt 88"
    "./result_10chains/node393_2_2.txt 88"
    "./result_10chains/node393_3_0.txt 87"
    "./result_10chains/node393_3_2.txt 87"
    "./result_10chains/node393_4_0.txt 86"
    "./result_10chains/node393_4_2.txt 86"
    "./result_10chains/node393_5_0.txt 85"
    "./result_10chains/node393_5_2.txt 85"
    "./result_10chains/node393_6_0.txt 84"
    "./result_10chains/node393_6_2.txt 84"
    "./result_10chains/node393_7_0.txt 83"
    "./result_10chains/node393_7_2.txt 83"
    "./result_10chains/node393_8_0.txt 82"
    "./result_10chains/node393_8_2.txt 82"
    "./result_10chains/node393_9_0.txt 81"
    "./result_10chains/node393_9_2.txt 81"
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
