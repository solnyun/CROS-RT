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
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_2 -p 29 -st topic430_0_1 -pt None -u 0.02024980098098844 > ./result_8chains/node430_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_2 -p 259 -st topic430_1_1 -pt None -u 0.0022941896906282233 > ./result_8chains/node430_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_2 -p 426 -st topic430_2_1 -pt None -u 0.007042641281306161 > ./result_8chains/node430_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_2 -p 497 -st topic430_3_1 -pt None -u 0.014932414045345899 > ./result_8chains/node430_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_2 -p 554 -st topic430_4_1 -pt None -u 0.014675135591875277 > ./result_8chains/node430_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_2 -p 626 -st topic430_5_1 -pt None -u 0.012657331827977403 > ./result_8chains/node430_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_6_2 -p 798 -st topic430_6_1 -pt None -u 0.021952346479527762 > ./result_8chains/node430_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_7_2 -p 837 -st topic430_7_1 -pt None -u 0.004390741113971661 > ./result_8chains/node430_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_0 -p 29 -st none -pt topic430_0_0 -u 0.03373130063286256 > ./result_8chains/node430_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_0 -p 259 -st none -pt topic430_1_0 -u 0.020570702456367218 > ./result_8chains/node430_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_0 -p 426 -st none -pt topic430_2_0 -u 0.0055437898914175165 > ./result_8chains/node430_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_0 -p 497 -st none -pt topic430_3_0 -u 0.02169177581551368 > ./result_8chains/node430_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_0 -p 554 -st none -pt topic430_4_0 -u 0.006877502961035009 > ./result_8chains/node430_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_0 -p 626 -st none -pt topic430_5_0 -u 0.00420542364817017 > ./result_8chains/node430_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_6_0 -p 798 -st none -pt topic430_6_0 -u 0.04293054227676721 > ./result_8chains/node430_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_7_0 -p 837 -st none -pt topic430_7_0 -u 0.08840394488047919 > ./result_8chains/node430_7_0.txt &
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
    "./result_8chains/node430_0_0.txt 90"
    "./result_8chains/node430_0_2.txt 90"
    "./result_8chains/node430_1_0.txt 89"
    "./result_8chains/node430_1_2.txt 89"
    "./result_8chains/node430_2_0.txt 88"
    "./result_8chains/node430_2_2.txt 88"
    "./result_8chains/node430_3_0.txt 87"
    "./result_8chains/node430_3_2.txt 87"
    "./result_8chains/node430_4_0.txt 86"
    "./result_8chains/node430_4_2.txt 86"
    "./result_8chains/node430_5_0.txt 85"
    "./result_8chains/node430_5_2.txt 85"
    "./result_8chains/node430_6_0.txt 84"
    "./result_8chains/node430_6_2.txt 84"
    "./result_8chains/node430_7_0.txt 83"
    "./result_8chains/node430_7_2.txt 83"
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
