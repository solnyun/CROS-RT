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
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_2 -p 23 -st topic480_0_1 -pt None -u 0.0020646074397996372 > ./result_10chains/node480_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_2 -p 35 -st topic480_1_1 -pt None -u 0.01595469580703257 > ./result_10chains/node480_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_2 -p 57 -st topic480_2_1 -pt None -u 0.012186643018418541 > ./result_10chains/node480_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_2 -p 222 -st topic480_3_1 -pt None -u 0.011286123346499921 > ./result_10chains/node480_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_2 -p 357 -st topic480_4_1 -pt None -u 0.010673461238799087 > ./result_10chains/node480_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_2 -p 380 -st topic480_5_1 -pt None -u 0.0028176229854356416 > ./result_10chains/node480_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_2 -p 586 -st topic480_6_1 -pt None -u 0.005097326607920977 > ./result_10chains/node480_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_2 -p 773 -st topic480_7_1 -pt None -u 0.0164931923101089 > ./result_10chains/node480_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_8_2 -p 878 -st topic480_8_1 -pt None -u 0.0006411558656432004 > ./result_10chains/node480_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_9_2 -p 917 -st topic480_9_1 -pt None -u 0.027363864661814088 > ./result_10chains/node480_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_0 -p 23 -st none -pt topic480_0_0 -u 0.004792763794132959 > ./result_10chains/node480_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_0 -p 35 -st none -pt topic480_1_0 -u 0.015680036274379194 > ./result_10chains/node480_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_0 -p 57 -st none -pt topic480_2_0 -u 0.002421866723249455 > ./result_10chains/node480_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_0 -p 222 -st none -pt topic480_3_0 -u 0.01600719612321405 > ./result_10chains/node480_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_0 -p 357 -st none -pt topic480_4_0 -u 0.003787573555952828 > ./result_10chains/node480_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_0 -p 380 -st none -pt topic480_5_0 -u 0.0046070788067510415 > ./result_10chains/node480_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_0 -p 586 -st none -pt topic480_6_0 -u 0.020281860545673852 > ./result_10chains/node480_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_0 -p 773 -st none -pt topic480_7_0 -u 0.03595319456207277 > ./result_10chains/node480_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_8_0 -p 878 -st none -pt topic480_8_0 -u 0.02698412642757067 > ./result_10chains/node480_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_9_0 -p 917 -st none -pt topic480_9_0 -u 0.006068949666874018 > ./result_10chains/node480_9_0.txt &
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
    "./result_10chains/node480_0_0.txt 90"
    "./result_10chains/node480_0_2.txt 90"
    "./result_10chains/node480_1_0.txt 89"
    "./result_10chains/node480_1_2.txt 89"
    "./result_10chains/node480_2_0.txt 88"
    "./result_10chains/node480_2_2.txt 88"
    "./result_10chains/node480_3_0.txt 87"
    "./result_10chains/node480_3_2.txt 87"
    "./result_10chains/node480_4_0.txt 86"
    "./result_10chains/node480_4_2.txt 86"
    "./result_10chains/node480_5_0.txt 85"
    "./result_10chains/node480_5_2.txt 85"
    "./result_10chains/node480_6_0.txt 84"
    "./result_10chains/node480_6_2.txt 84"
    "./result_10chains/node480_7_0.txt 83"
    "./result_10chains/node480_7_2.txt 83"
    "./result_10chains/node480_8_0.txt 82"
    "./result_10chains/node480_8_2.txt 82"
    "./result_10chains/node480_9_0.txt 81"
    "./result_10chains/node480_9_2.txt 81"
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
