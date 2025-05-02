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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_2 -p 113 -st topic265_0_1 -pt None -u 0.01926265721882281 > ./result_8chains/node265_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_2 -p 395 -st topic265_1_1 -pt None -u 0.03698360633933978 > ./result_8chains/node265_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_2 -p 692 -st topic265_2_1 -pt None -u 0.03359085280026275 > ./result_8chains/node265_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_2 -p 800 -st topic265_3_1 -pt None -u 0.015491377830343295 > ./result_8chains/node265_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_2 -p 859 -st topic265_4_1 -pt None -u 0.0108220224305359 > ./result_8chains/node265_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_2 -p 869 -st topic265_5_1 -pt None -u 0.027056365947280114 > ./result_8chains/node265_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_2 -p 966 -st topic265_6_1 -pt None -u 0.005163322761490896 > ./result_8chains/node265_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_2 -p 973 -st topic265_7_1 -pt None -u 0.01784687606202462 > ./result_8chains/node265_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_0 -p 113 -st none -pt topic265_0_0 -u 0.04916681398587036 > ./result_8chains/node265_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_0 -p 395 -st none -pt topic265_1_0 -u 0.0073616126136175075 > ./result_8chains/node265_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_0 -p 692 -st none -pt topic265_2_0 -u 0.024235492258706637 > ./result_8chains/node265_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_0 -p 800 -st none -pt topic265_3_0 -u 0.006865712549049718 > ./result_8chains/node265_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_0 -p 859 -st none -pt topic265_4_0 -u 0.04811231415701972 > ./result_8chains/node265_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_0 -p 869 -st none -pt topic265_5_0 -u 0.011064521074611644 > ./result_8chains/node265_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_0 -p 966 -st none -pt topic265_6_0 -u 0.012630901973420885 > ./result_8chains/node265_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_0 -p 973 -st none -pt topic265_7_0 -u 0.013508163079426407 > ./result_8chains/node265_7_0.txt &
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
    "./result_8chains/node265_0_0.txt 90"
    "./result_8chains/node265_0_2.txt 90"
    "./result_8chains/node265_1_0.txt 89"
    "./result_8chains/node265_1_2.txt 89"
    "./result_8chains/node265_2_0.txt 88"
    "./result_8chains/node265_2_2.txt 88"
    "./result_8chains/node265_3_0.txt 87"
    "./result_8chains/node265_3_2.txt 87"
    "./result_8chains/node265_4_0.txt 86"
    "./result_8chains/node265_4_2.txt 86"
    "./result_8chains/node265_5_0.txt 85"
    "./result_8chains/node265_5_2.txt 85"
    "./result_8chains/node265_6_0.txt 84"
    "./result_8chains/node265_6_2.txt 84"
    "./result_8chains/node265_7_0.txt 83"
    "./result_8chains/node265_7_2.txt 83"
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
