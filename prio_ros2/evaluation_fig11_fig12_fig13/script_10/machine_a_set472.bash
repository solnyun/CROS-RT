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
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_2 -p 131 -st topic472_0_1 -pt None -u 0.02013510399181767 > ./result_10chains/node472_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_2 -p 230 -st topic472_1_1 -pt None -u 0.012183385058820495 > ./result_10chains/node472_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_2 -p 284 -st topic472_2_1 -pt None -u 0.040229245685159065 > ./result_10chains/node472_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_2 -p 385 -st topic472_3_1 -pt None -u 0.004559018097944234 > ./result_10chains/node472_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_2 -p 417 -st topic472_4_1 -pt None -u 0.009628852558509093 > ./result_10chains/node472_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_2 -p 499 -st topic472_5_1 -pt None -u 0.0024923984296257584 > ./result_10chains/node472_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_6_2 -p 600 -st topic472_6_1 -pt None -u 0.010571869103290665 > ./result_10chains/node472_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_7_2 -p 640 -st topic472_7_1 -pt None -u 0.020328606017384468 > ./result_10chains/node472_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_8_2 -p 709 -st topic472_8_1 -pt None -u 0.029573496055920197 > ./result_10chains/node472_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_9_2 -p 946 -st topic472_9_1 -pt None -u 0.02256853556799747 > ./result_10chains/node472_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_0 -p 131 -st none -pt topic472_0_0 -u 0.029188065242294836 > ./result_10chains/node472_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_0 -p 230 -st none -pt topic472_1_0 -u 0.0026666884742473917 > ./result_10chains/node472_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_0 -p 284 -st none -pt topic472_2_0 -u 0.0022444066642337 > ./result_10chains/node472_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_0 -p 385 -st none -pt topic472_3_0 -u 0.005584834898066604 > ./result_10chains/node472_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_0 -p 417 -st none -pt topic472_4_0 -u 0.0014148592187677722 > ./result_10chains/node472_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_0 -p 499 -st none -pt topic472_5_0 -u 0.013631989280974643 > ./result_10chains/node472_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_6_0 -p 600 -st none -pt topic472_6_0 -u 0.04206584292220403 > ./result_10chains/node472_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_7_0 -p 640 -st none -pt topic472_7_0 -u 0.013204174932046897 > ./result_10chains/node472_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_8_0 -p 709 -st none -pt topic472_8_0 -u 0.014473759511841822 > ./result_10chains/node472_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_9_0 -p 946 -st none -pt topic472_9_0 -u 0.002834613175739187 > ./result_10chains/node472_9_0.txt &
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
    "./result_10chains/node472_0_0.txt 90"
    "./result_10chains/node472_0_2.txt 90"
    "./result_10chains/node472_1_0.txt 89"
    "./result_10chains/node472_1_2.txt 89"
    "./result_10chains/node472_2_0.txt 88"
    "./result_10chains/node472_2_2.txt 88"
    "./result_10chains/node472_3_0.txt 87"
    "./result_10chains/node472_3_2.txt 87"
    "./result_10chains/node472_4_0.txt 86"
    "./result_10chains/node472_4_2.txt 86"
    "./result_10chains/node472_5_0.txt 85"
    "./result_10chains/node472_5_2.txt 85"
    "./result_10chains/node472_6_0.txt 84"
    "./result_10chains/node472_6_2.txt 84"
    "./result_10chains/node472_7_0.txt 83"
    "./result_10chains/node472_7_2.txt 83"
    "./result_10chains/node472_8_0.txt 82"
    "./result_10chains/node472_8_2.txt 82"
    "./result_10chains/node472_9_0.txt 81"
    "./result_10chains/node472_9_2.txt 81"
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
