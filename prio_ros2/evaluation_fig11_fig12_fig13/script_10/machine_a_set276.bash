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
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_2 -p 189 -st topic276_0_1 -pt None -u 0.006317513717281675 > ./result_10chains/node276_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_2 -p 190 -st topic276_1_1 -pt None -u 0.03576813882841423 > ./result_10chains/node276_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_2 -p 223 -st topic276_2_1 -pt None -u 0.01935619052879245 > ./result_10chains/node276_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_2 -p 246 -st topic276_3_1 -pt None -u 0.005519402108656535 > ./result_10chains/node276_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_2 -p 295 -st topic276_4_1 -pt None -u 0.02060476646650583 > ./result_10chains/node276_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_2 -p 470 -st topic276_5_1 -pt None -u 0.0035254899207233514 > ./result_10chains/node276_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_2 -p 670 -st topic276_6_1 -pt None -u 0.016755175262673727 > ./result_10chains/node276_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_2 -p 737 -st topic276_7_1 -pt None -u 0.013655695417512131 > ./result_10chains/node276_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_8_2 -p 822 -st topic276_8_1 -pt None -u 0.023932144283295237 > ./result_10chains/node276_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_9_2 -p 893 -st topic276_9_1 -pt None -u 0.0374620020670737 > ./result_10chains/node276_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_0 -p 189 -st none -pt topic276_0_0 -u 0.021526531652785064 > ./result_10chains/node276_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_0 -p 190 -st none -pt topic276_1_0 -u 0.0029696642093772763 > ./result_10chains/node276_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_0 -p 223 -st none -pt topic276_2_0 -u 0.013793066994630787 > ./result_10chains/node276_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_0 -p 246 -st none -pt topic276_3_0 -u 0.02907757079084833 > ./result_10chains/node276_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_0 -p 295 -st none -pt topic276_4_0 -u 0.0016291952243619456 > ./result_10chains/node276_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_0 -p 470 -st none -pt topic276_5_0 -u 0.0235753479861619 > ./result_10chains/node276_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_0 -p 670 -st none -pt topic276_6_0 -u 0.013448676743088223 > ./result_10chains/node276_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_0 -p 737 -st none -pt topic276_7_0 -u 0.0012386173252487143 > ./result_10chains/node276_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_8_0 -p 822 -st none -pt topic276_8_0 -u 0.02997733470926775 > ./result_10chains/node276_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_9_0 -p 893 -st none -pt topic276_9_0 -u 0.051279657510919334 > ./result_10chains/node276_9_0.txt &
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
    "./result_10chains/node276_0_0.txt 90"
    "./result_10chains/node276_0_2.txt 90"
    "./result_10chains/node276_1_0.txt 89"
    "./result_10chains/node276_1_2.txt 89"
    "./result_10chains/node276_2_0.txt 88"
    "./result_10chains/node276_2_2.txt 88"
    "./result_10chains/node276_3_0.txt 87"
    "./result_10chains/node276_3_2.txt 87"
    "./result_10chains/node276_4_0.txt 86"
    "./result_10chains/node276_4_2.txt 86"
    "./result_10chains/node276_5_0.txt 85"
    "./result_10chains/node276_5_2.txt 85"
    "./result_10chains/node276_6_0.txt 84"
    "./result_10chains/node276_6_2.txt 84"
    "./result_10chains/node276_7_0.txt 83"
    "./result_10chains/node276_7_2.txt 83"
    "./result_10chains/node276_8_0.txt 82"
    "./result_10chains/node276_8_2.txt 82"
    "./result_10chains/node276_9_0.txt 81"
    "./result_10chains/node276_9_2.txt 81"
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
