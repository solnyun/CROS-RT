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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_2 -p 218 -st topic370_0_1 -pt None -u 0.02526709944410288 > ./result_4chains/node370_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_2 -p 645 -st topic370_1_1 -pt None -u 0.03757577477933091 > ./result_4chains/node370_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_2 -p 871 -st topic370_2_1 -pt None -u 0.033034140676061446 > ./result_4chains/node370_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_2 -p 893 -st topic370_3_1 -pt None -u 0.014058157735647102 > ./result_4chains/node370_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_0 -p 218 -st none -pt topic370_0_0 -u 0.07256724719753477 > ./result_4chains/node370_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_0 -p 645 -st none -pt topic370_1_0 -u 0.014795093711999219 > ./result_4chains/node370_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_0 -p 871 -st none -pt topic370_2_0 -u 0.0339115671380546 > ./result_4chains/node370_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_0 -p 893 -st none -pt topic370_3_0 -u 0.07049894559878415 > ./result_4chains/node370_3_0.txt &
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
    "./result_4chains/node370_0_0.txt 90"
    "./result_4chains/node370_0_2.txt 90"
    "./result_4chains/node370_1_0.txt 89"
    "./result_4chains/node370_1_2.txt 89"
    "./result_4chains/node370_2_0.txt 88"
    "./result_4chains/node370_2_2.txt 88"
    "./result_4chains/node370_3_0.txt 87"
    "./result_4chains/node370_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
