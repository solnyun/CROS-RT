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
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_2 -p 52 -st topic400_0_1 -pt None -u 0.006212002618121215 > ./result_8chains/node400_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_2 -p 260 -st topic400_1_1 -pt None -u 0.022201070105118736 > ./result_8chains/node400_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_2 -p 508 -st topic400_2_1 -pt None -u 0.01738003173195496 > ./result_8chains/node400_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_2 -p 646 -st topic400_3_1 -pt None -u 0.003979248645693628 > ./result_8chains/node400_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_2 -p 680 -st topic400_4_1 -pt None -u 0.03620420654737885 > ./result_8chains/node400_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_2 -p 766 -st topic400_5_1 -pt None -u 0.012534913320573965 > ./result_8chains/node400_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_6_2 -p 783 -st topic400_6_1 -pt None -u 0.010504720221838761 > ./result_8chains/node400_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_7_2 -p 976 -st topic400_7_1 -pt None -u 0.006386601614469301 > ./result_8chains/node400_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_0 -p 52 -st none -pt topic400_0_0 -u 0.010265687961130143 > ./result_8chains/node400_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_0 -p 260 -st none -pt topic400_1_0 -u 0.014258664447232339 > ./result_8chains/node400_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_0 -p 508 -st none -pt topic400_2_0 -u 0.02882381389380617 > ./result_8chains/node400_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_0 -p 646 -st none -pt topic400_3_0 -u 0.0249522125665336 > ./result_8chains/node400_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_0 -p 680 -st none -pt topic400_4_0 -u 0.009941173832473449 > ./result_8chains/node400_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_0 -p 766 -st none -pt topic400_5_0 -u 0.07839104292623997 > ./result_8chains/node400_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_6_0 -p 783 -st none -pt topic400_6_0 -u 0.005988647601842166 > ./result_8chains/node400_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_7_0 -p 976 -st none -pt topic400_7_0 -u 0.01688213924339478 > ./result_8chains/node400_7_0.txt &
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
    "./result_8chains/node400_0_0.txt 90"
    "./result_8chains/node400_0_2.txt 90"
    "./result_8chains/node400_1_0.txt 89"
    "./result_8chains/node400_1_2.txt 89"
    "./result_8chains/node400_2_0.txt 88"
    "./result_8chains/node400_2_2.txt 88"
    "./result_8chains/node400_3_0.txt 87"
    "./result_8chains/node400_3_2.txt 87"
    "./result_8chains/node400_4_0.txt 86"
    "./result_8chains/node400_4_2.txt 86"
    "./result_8chains/node400_5_0.txt 85"
    "./result_8chains/node400_5_2.txt 85"
    "./result_8chains/node400_6_0.txt 84"
    "./result_8chains/node400_6_2.txt 84"
    "./result_8chains/node400_7_0.txt 83"
    "./result_8chains/node400_7_2.txt 83"
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
