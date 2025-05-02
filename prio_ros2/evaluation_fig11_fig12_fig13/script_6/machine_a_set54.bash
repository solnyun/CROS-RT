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
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_2 -p 11 -st topic54_0_1 -pt None -u 0.05808583217634122 > ./result_6chains/node54_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_2 -p 13 -st topic54_1_1 -pt None -u 0.05566419869402506 > ./result_6chains/node54_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_2 -p 473 -st topic54_2_1 -pt None -u 0.018339397978360428 > ./result_6chains/node54_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_2 -p 672 -st topic54_3_1 -pt None -u 0.0651716915403289 > ./result_6chains/node54_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_2 -p 851 -st topic54_4_1 -pt None -u 0.03586907040952694 > ./result_6chains/node54_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_2 -p 967 -st topic54_5_1 -pt None -u 0.023056234936554267 > ./result_6chains/node54_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_0 -p 11 -st none -pt topic54_0_0 -u 0.0017154849263044114 > ./result_6chains/node54_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_0 -p 13 -st none -pt topic54_1_0 -u 0.012352557755980487 > ./result_6chains/node54_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_0 -p 473 -st none -pt topic54_2_0 -u 0.029210518457685075 > ./result_6chains/node54_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_0 -p 672 -st none -pt topic54_3_0 -u 0.0024811015000683057 > ./result_6chains/node54_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_0 -p 851 -st none -pt topic54_4_0 -u 0.017944157736725724 > ./result_6chains/node54_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_0 -p 967 -st none -pt topic54_5_0 -u 0.05904487062114539 > ./result_6chains/node54_5_0.txt &
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
    "./result_6chains/node54_0_0.txt 90"
    "./result_6chains/node54_0_2.txt 90"
    "./result_6chains/node54_1_0.txt 89"
    "./result_6chains/node54_1_2.txt 89"
    "./result_6chains/node54_2_0.txt 88"
    "./result_6chains/node54_2_2.txt 88"
    "./result_6chains/node54_3_0.txt 87"
    "./result_6chains/node54_3_2.txt 87"
    "./result_6chains/node54_4_0.txt 86"
    "./result_6chains/node54_4_2.txt 86"
    "./result_6chains/node54_5_0.txt 85"
    "./result_6chains/node54_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
