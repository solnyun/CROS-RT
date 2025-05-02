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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_2 -p 20 -st topic90_0_1 -pt None -u 0.020086928601227183 > ./result_6chains/node90_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_2 -p 187 -st topic90_1_1 -pt None -u 0.11363174724669978 > ./result_6chains/node90_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_2 -p 346 -st topic90_2_1 -pt None -u 0.03153780998285444 > ./result_6chains/node90_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_2 -p 484 -st topic90_3_1 -pt None -u 0.005155674547489525 > ./result_6chains/node90_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_2 -p 522 -st topic90_4_1 -pt None -u 0.010146194403763312 > ./result_6chains/node90_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_2 -p 600 -st topic90_5_1 -pt None -u 0.004159912542441521 > ./result_6chains/node90_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_0 -p 20 -st none -pt topic90_0_0 -u 0.06120617821483937 > ./result_6chains/node90_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_0 -p 187 -st none -pt topic90_1_0 -u 0.008210096139269929 > ./result_6chains/node90_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_0 -p 346 -st none -pt topic90_2_0 -u 0.011943825789018925 > ./result_6chains/node90_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_0 -p 484 -st none -pt topic90_3_0 -u 0.00995485871811344 > ./result_6chains/node90_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_0 -p 522 -st none -pt topic90_4_0 -u 0.0457847459640508 > ./result_6chains/node90_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_0 -p 600 -st none -pt topic90_5_0 -u 0.0456725971364688 > ./result_6chains/node90_5_0.txt &
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
    "./result_6chains/node90_0_0.txt 90"
    "./result_6chains/node90_0_2.txt 90"
    "./result_6chains/node90_1_0.txt 89"
    "./result_6chains/node90_1_2.txt 89"
    "./result_6chains/node90_2_0.txt 88"
    "./result_6chains/node90_2_2.txt 88"
    "./result_6chains/node90_3_0.txt 87"
    "./result_6chains/node90_3_2.txt 87"
    "./result_6chains/node90_4_0.txt 86"
    "./result_6chains/node90_4_2.txt 86"
    "./result_6chains/node90_5_0.txt 85"
    "./result_6chains/node90_5_2.txt 85"
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
