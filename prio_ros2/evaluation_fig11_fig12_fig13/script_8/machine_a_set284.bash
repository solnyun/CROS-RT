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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_2 -p 39 -st topic284_0_1 -pt None -u 0.08395955892826967 > ./result_8chains/node284_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_2 -p 58 -st topic284_1_1 -pt None -u 0.005620585089676999 > ./result_8chains/node284_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_2 -p 133 -st topic284_2_1 -pt None -u 0.020613008029867985 > ./result_8chains/node284_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_2 -p 174 -st topic284_3_1 -pt None -u 0.013642584775823974 > ./result_8chains/node284_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_2 -p 282 -st topic284_4_1 -pt None -u 0.002745636105814464 > ./result_8chains/node284_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_2 -p 305 -st topic284_5_1 -pt None -u 0.0007514999608488199 > ./result_8chains/node284_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_2 -p 487 -st topic284_6_1 -pt None -u 0.02192060188976258 > ./result_8chains/node284_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_2 -p 808 -st topic284_7_1 -pt None -u 0.013603536437622242 > ./result_8chains/node284_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_0 -p 39 -st none -pt topic284_0_0 -u 0.014246341433416132 > ./result_8chains/node284_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_0 -p 58 -st none -pt topic284_1_0 -u 0.052932475818802116 > ./result_8chains/node284_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_0 -p 133 -st none -pt topic284_2_0 -u 0.004442161354321794 > ./result_8chains/node284_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_0 -p 174 -st none -pt topic284_3_0 -u 0.012742282610344935 > ./result_8chains/node284_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_0 -p 282 -st none -pt topic284_4_0 -u 0.04712050659531947 > ./result_8chains/node284_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_0 -p 305 -st none -pt topic284_5_0 -u 0.006880457431159809 > ./result_8chains/node284_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_0 -p 487 -st none -pt topic284_6_0 -u 0.0008763484723904036 > ./result_8chains/node284_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_0 -p 808 -st none -pt topic284_7_0 -u 0.04015881132440522 > ./result_8chains/node284_7_0.txt &
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
    "./result_8chains/node284_0_0.txt 90"
    "./result_8chains/node284_0_2.txt 90"
    "./result_8chains/node284_1_0.txt 89"
    "./result_8chains/node284_1_2.txt 89"
    "./result_8chains/node284_2_0.txt 88"
    "./result_8chains/node284_2_2.txt 88"
    "./result_8chains/node284_3_0.txt 87"
    "./result_8chains/node284_3_2.txt 87"
    "./result_8chains/node284_4_0.txt 86"
    "./result_8chains/node284_4_2.txt 86"
    "./result_8chains/node284_5_0.txt 85"
    "./result_8chains/node284_5_2.txt 85"
    "./result_8chains/node284_6_0.txt 84"
    "./result_8chains/node284_6_2.txt 84"
    "./result_8chains/node284_7_0.txt 83"
    "./result_8chains/node284_7_2.txt 83"
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
