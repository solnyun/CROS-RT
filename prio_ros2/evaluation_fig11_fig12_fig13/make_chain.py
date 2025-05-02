import random

def UUniFast(n, U_sum):
    utilizations = []
    sumU = U_sum

    for i in range(1, n):
        nextSumU = sumU * (random.random() ** (1.0 / (n - i)))
        utilizations.append(sumU - nextSumU)
        sumU = nextSumU

    utilizations.append(sumU)
    return utilizations

def distribute_commands(num_edges, num_commands):
    def generate_patterns(current, transitions_left, path):
        if transitions_left == 0:
            return [path + [current] * (num_commands - len(path))]
        results = []
        next_location = 'b' if current == 'a' else 'a'
        for i in range(1, num_commands - len(path) - transitions_left + 1):
            results.extend(generate_patterns(next_location, transitions_left - 1, path + [current] * i))
        return results

    all_patterns = generate_patterns('a', num_edges, [])
    chosen_pattern = random.choice(all_patterns)
    return chosen_pattern

def make_command(num_udp_comm, chainset_indes):
    NUM_CHAINS_PER_SET = 10
    NUM_CALLBACKS_PER_CHAIN = 3
    total_utilization = 0.5

    periods = sorted(random.sample(range(10, 1000), k=NUM_CHAINS_PER_SET))
    utilizations = UUniFast(NUM_CHAINS_PER_SET * NUM_CALLBACKS_PER_CHAIN, total_utilization)

    commands_with_paths = []

    utilization_index = 0

    for j in range(NUM_CHAINS_PER_SET):
        commands = []
        txt_prio = []
        for k in range(NUM_CALLBACKS_PER_CHAIN):
            node_name = f"node{i}_{j}_{k}"
            period = periods[j]
            pub_topic_name = f"None"
            sub_topic_name = f"none"
            utilization = utilizations[utilization_index]
            utilization_index += 1
            txt_path = f"./result_{NUM_CHAINS_PER_SET}chains/{node_name}.txt"
            priority = 90 - j

            if k == 0:
                pub_topic_name = f"topic{i}_{j}_{k}"
            elif k == (NUM_CALLBACKS_PER_CHAIN - 1):
                sub_topic_name = f"topic{i}_{j}_{k-1}"
            else:
                pub_topic_name = f"topic{i}_{j}_{k}"
                sub_topic_name = f"topic{i}_{j}_{k-1}"

            cmd = (f"ros2 run evaluation_3_randomdag uunifast_node "
                   f"-n {node_name} "
                   f"-p {period} "
                   f"-st {sub_topic_name} "
                   f"-pt {pub_topic_name} "
                   f"-u {utilization} "
                   f"> {txt_path} &")
            commands.append(cmd)
            commands_with_paths.append((cmd, txt_path, priority))

            # 각 세트별로 명령어 분배
        chosen_pattern = distribute_commands(num_udp_comm, len(commands))
        file_a = [cmd for cmd, loc in zip(commands, chosen_pattern) if loc == 'a']
        file_b = [cmd for cmd, loc in zip(commands, chosen_pattern) if loc == 'b']

        # 결과 파일 작성
        mode = 'w' if j == 0 else 'a'
        with open(f"script_{NUM_CHAINS_PER_SET}/machine_a_set{i}.bash", mode) as fa:
            fa.write("\n".join(file_a))
            fa.write("\nsleep 20\n")
        with open(f"script_{NUM_CHAINS_PER_SET}/machine_b_set{i}.bash", mode) as fb:
            fb.write("\n".join(file_b))
            fb.write("\nsleep 20\n")


NUM_CHAINSETS = 500

for i in range(NUM_CHAINSETS):
    make_command(2, i)
