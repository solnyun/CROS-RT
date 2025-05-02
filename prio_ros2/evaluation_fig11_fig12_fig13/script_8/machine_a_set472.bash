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
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_2 -p 139 -st topic472_0_1 -pt None -u 0.024737056948110625 > ./result_8chains/node472_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_2 -p 308 -st topic472_1_1 -pt None -u 0.007392506873103388 > ./result_8chains/node472_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_2 -p 512 -st topic472_2_1 -pt None -u 0.021909320473990912 > ./result_8chains/node472_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_2 -p 618 -st topic472_3_1 -pt None -u 0.009219955226988208 > ./result_8chains/node472_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_2 -p 750 -st topic472_4_1 -pt None -u 0.002650375315434994 > ./result_8chains/node472_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_2 -p 871 -st topic472_5_1 -pt None -u 0.03532313543016634 > ./result_8chains/node472_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_6_2 -p 912 -st topic472_6_1 -pt None -u 0.010345793450858232 > ./result_8chains/node472_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_7_2 -p 994 -st topic472_7_1 -pt None -u 0.05800938515013569 > ./result_8chains/node472_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_0 -p 139 -st none -pt topic472_0_0 -u 0.007895143024494233 > ./result_8chains/node472_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_0 -p 308 -st none -pt topic472_1_0 -u 0.02476824252138149 > ./result_8chains/node472_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_0 -p 512 -st none -pt topic472_2_0 -u 0.013485174781160902 > ./result_8chains/node472_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_0 -p 618 -st none -pt topic472_3_0 -u 0.009860101926139841 > ./result_8chains/node472_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_0 -p 750 -st none -pt topic472_4_0 -u 0.02478567611073057 > ./result_8chains/node472_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_0 -p 871 -st none -pt topic472_5_0 -u 0.008602427109625166 > ./result_8chains/node472_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_6_0 -p 912 -st none -pt topic472_6_0 -u 0.0191756022977307 > ./result_8chains/node472_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_7_0 -p 994 -st none -pt topic472_7_0 -u 0.0018113769970256668 > ./result_8chains/node472_7_0.txt &
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
    "./result_8chains/node472_0_0.txt 90"
    "./result_8chains/node472_0_2.txt 90"
    "./result_8chains/node472_1_0.txt 89"
    "./result_8chains/node472_1_2.txt 89"
    "./result_8chains/node472_2_0.txt 88"
    "./result_8chains/node472_2_2.txt 88"
    "./result_8chains/node472_3_0.txt 87"
    "./result_8chains/node472_3_2.txt 87"
    "./result_8chains/node472_4_0.txt 86"
    "./result_8chains/node472_4_2.txt 86"
    "./result_8chains/node472_5_0.txt 85"
    "./result_8chains/node472_5_2.txt 85"
    "./result_8chains/node472_6_0.txt 84"
    "./result_8chains/node472_6_2.txt 84"
    "./result_8chains/node472_7_0.txt 83"
    "./result_8chains/node472_7_2.txt 83"
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
