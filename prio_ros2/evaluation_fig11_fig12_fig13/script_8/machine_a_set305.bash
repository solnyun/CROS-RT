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
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_2 -p 65 -st topic305_0_1 -pt None -u 0.02598224337319549 > ./result_8chains/node305_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_2 -p 149 -st topic305_1_1 -pt None -u 0.001362375724035747 > ./result_8chains/node305_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_2 -p 387 -st topic305_2_1 -pt None -u 0.01565388540539031 > ./result_8chains/node305_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_2 -p 453 -st topic305_3_1 -pt None -u 0.022983479067794327 > ./result_8chains/node305_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_2 -p 561 -st topic305_4_1 -pt None -u 0.01622531288970519 > ./result_8chains/node305_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_2 -p 804 -st topic305_5_1 -pt None -u 0.010852363643204993 > ./result_8chains/node305_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_6_2 -p 910 -st topic305_6_1 -pt None -u 0.01137281351141041 > ./result_8chains/node305_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_7_2 -p 947 -st topic305_7_1 -pt None -u 0.02692531097306428 > ./result_8chains/node305_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_0 -p 65 -st none -pt topic305_0_0 -u 0.015404429251277274 > ./result_8chains/node305_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_0 -p 149 -st none -pt topic305_1_0 -u 0.019771511336318937 > ./result_8chains/node305_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_0 -p 387 -st none -pt topic305_2_0 -u 0.0087055760509272 > ./result_8chains/node305_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_0 -p 453 -st none -pt topic305_3_0 -u 0.011870455500689103 > ./result_8chains/node305_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_0 -p 561 -st none -pt topic305_4_0 -u 0.012184027119296836 > ./result_8chains/node305_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_0 -p 804 -st none -pt topic305_5_0 -u 0.020922065860555755 > ./result_8chains/node305_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_6_0 -p 910 -st none -pt topic305_6_0 -u 0.016918076733612272 > ./result_8chains/node305_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_7_0 -p 947 -st none -pt topic305_7_0 -u 0.009502839020159318 > ./result_8chains/node305_7_0.txt &
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
    "./result_8chains/node305_0_0.txt 90"
    "./result_8chains/node305_0_2.txt 90"
    "./result_8chains/node305_1_0.txt 89"
    "./result_8chains/node305_1_2.txt 89"
    "./result_8chains/node305_2_0.txt 88"
    "./result_8chains/node305_2_2.txt 88"
    "./result_8chains/node305_3_0.txt 87"
    "./result_8chains/node305_3_2.txt 87"
    "./result_8chains/node305_4_0.txt 86"
    "./result_8chains/node305_4_2.txt 86"
    "./result_8chains/node305_5_0.txt 85"
    "./result_8chains/node305_5_2.txt 85"
    "./result_8chains/node305_6_0.txt 84"
    "./result_8chains/node305_6_2.txt 84"
    "./result_8chains/node305_7_0.txt 83"
    "./result_8chains/node305_7_2.txt 83"
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
