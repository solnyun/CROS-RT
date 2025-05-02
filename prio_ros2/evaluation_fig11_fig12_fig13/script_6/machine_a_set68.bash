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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_2 -p 761 -st topic68_0_1 -pt None -u 0.0501246460120236 > ./result_6chains/node68_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_2 -p 816 -st topic68_1_1 -pt None -u 0.011405595741256824 > ./result_6chains/node68_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_2 -p 873 -st topic68_2_1 -pt None -u 0.03474284357085711 > ./result_6chains/node68_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_2 -p 896 -st topic68_3_1 -pt None -u 0.03332322922219422 > ./result_6chains/node68_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_2 -p 899 -st topic68_4_1 -pt None -u 0.01492037148605714 > ./result_6chains/node68_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_2 -p 923 -st topic68_5_1 -pt None -u 0.007614148425345566 > ./result_6chains/node68_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_0 -p 761 -st none -pt topic68_0_0 -u 0.05023051477133894 > ./result_6chains/node68_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_0 -p 816 -st none -pt topic68_1_0 -u 0.006248735962700092 > ./result_6chains/node68_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_0 -p 873 -st none -pt topic68_2_0 -u 0.023994455458400787 > ./result_6chains/node68_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_0 -p 896 -st none -pt topic68_3_0 -u 0.05117954598329216 > ./result_6chains/node68_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_0 -p 899 -st none -pt topic68_4_0 -u 0.05237948608053686 > ./result_6chains/node68_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_0 -p 923 -st none -pt topic68_5_0 -u 0.05619654976125105 > ./result_6chains/node68_5_0.txt &
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
    "./result_6chains/node68_0_0.txt 90"
    "./result_6chains/node68_0_2.txt 90"
    "./result_6chains/node68_1_0.txt 89"
    "./result_6chains/node68_1_2.txt 89"
    "./result_6chains/node68_2_0.txt 88"
    "./result_6chains/node68_2_2.txt 88"
    "./result_6chains/node68_3_0.txt 87"
    "./result_6chains/node68_3_2.txt 87"
    "./result_6chains/node68_4_0.txt 86"
    "./result_6chains/node68_4_2.txt 86"
    "./result_6chains/node68_5_0.txt 85"
    "./result_6chains/node68_5_2.txt 85"
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
