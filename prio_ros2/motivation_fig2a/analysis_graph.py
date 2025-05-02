import os
import sys
import pandas as pd
import matplotlib.pyplot as plt
import re

def read_vanilla_file(file_path):
    """Reads a vanilla_chain file and extracts the Data# number and latency."""
    try:
        df = pd.read_csv(file_path, delimiter=' ', header=None, names=['Data', 'Latency'])
        df['Data'] = df['Data'].str.extract('(\d+)').astype(int)
        start_number = df['Data'].iloc[0]
        print(f"Read from {file_path}:\n{df.head()}")
        return df, start_number
    except Exception as e:
        print(f"Failed to read file {file_path}: {e}")
        return None, None

def read_pub_file(file_path, start_number, initial_time):
    """Reads a pub file from the start number and extracts the Data# number and time."""
    data_numbers = []
    times = []
    time_pattern = re.compile(r'\d+\.\d+')  # matches floating point numbers
    try:
        with open(file_path, 'r') as file:
            for line in file:
                if 'Data#' in line:
                    data_number_match = re.search(r'Data#(\d+)', line)
                    time_match = time_pattern.search(line)
                    if data_number_match and time_match:
                        data_number = int(data_number_match.group(1))
                        if data_number >= start_number:
                            time = float(time_match.group(0))
                            data_numbers.append(data_number)
                            times.append(time)
        # Adjust time to start from initial_time for the start number
        times = [round((t - initial_time) * 1000) for t in times]  # Convert to milliseconds and round
        df = pd.DataFrame({'Data': data_numbers, 'Time': times})
        print(f"Read from {file_path}:\n{df.head()}")
        return df
    except Exception as e:
        print(f"Failed to read file {file_path}: {e}")
        return None

def plot_graphs(directory):
    """Reads necessary files from the directory and plots graphs."""
    # Define file paths
    vanilla_chain1_path = os.path.join(directory, 'vanilla_chain1.txt')
    vanilla_chain2_path = os.path.join(directory, 'vanilla_chain2.txt')
    pub_90_path = os.path.join(directory, 'pub_90.txt')
    pub_80_path = os.path.join(directory, 'pub_80.txt')

    # Read vanilla_chain1 and vanilla_chain2 files
    vanilla_chain1, start_number1 = read_vanilla_file(vanilla_chain1_path)
    vanilla_chain2, start_number2 = read_vanilla_file(vanilla_chain2_path)
    if vanilla_chain1 is None or start_number1 is None or vanilla_chain2 is None or start_number2 is None:
        print("Error reading vanilla_chain files")
        return

    # Get the initial time from vanilla_chain2
    pub_80_initial_time = None
    with open(pub_80_path, 'r') as file:
        for line in file:
            if 'Data#' in line:
                data_number_match = re.search(r'Data#(\d+)', line)
                time_match = re.search(r'\d+\.\d+', line)
                if data_number_match and time_match:
                    data_number = int(data_number_match.group(1))
                    if data_number == start_number2:
                        pub_80_initial_time = float(time_match.group(0))
                        break
    if pub_80_initial_time is None:
        print("Error finding initial time in pub_80.txt")
        return

    # Read pub_90 and pub_80 files
    pub_90 = read_pub_file(pub_90_path, start_number1, pub_80_initial_time)
    pub_80 = read_pub_file(pub_80_path, start_number2, pub_80_initial_time)
    if pub_90 is None or pub_80 is None:
        print("Error reading pub files")
        return

    # Merge data based on Data# number
    merged_90 = pd.merge(vanilla_chain1, pub_90, on='Data')
    merged_80 = pd.merge(vanilla_chain2, pub_80, on='Data')

    print(f"Merged data for pub_90 and vanilla_chain1:\n{merged_90.head()}")
    print(f"Merged data for pub_80 and vanilla_chain2:\n{merged_80.head()}")

    # Convert to numpy arrays for plotting
    time_90 = merged_90['Time'].to_numpy()
    latency_90 = merged_90['Latency'].to_numpy()
    time_80 = merged_80['Time'].to_numpy()
    latency_80 = merged_80['Latency'].to_numpy()

    # Create a single figure and axis
    plt.figure(figsize=(8, 7))  # Increase figure size to avoid clipping x-axis labels

    # Plot merged data on the same graph using plot
    plt.plot(time_90, latency_90, label='High-priority Chain', color='#1D3557', marker='o')
    plt.plot(time_80, latency_80, label='Low-priority Chain', color='#0A9396', marker='o')

    plt.xlabel('Time (s)', fontsize=28, fontweight='bold', fontname='sans-serif')
    plt.ylabel('Response Time (ms)', fontsize=28, fontweight='semibold', family="sans-serif")
    plt.xticks(ticks=[i*1000 for i in range(16)], labels=[str(i) for i in range(16)], fontsize=22, family="sans-serif")
    plt.yticks(fontsize=22, family="sans-serif")
    plt.xlim(0, 12000)  # Set x-axis limit from 0 to 15000 ms
    plt.ylim(3, 38)  # Set y-axis limit from 0 to 45 ms

    # Customize axis spines
    ax = plt.gca()  # Get the current axis
    ax.spines['top'].set_visible(False)  # Remove top border
    ax.spines['right'].set_visible(False)  # Remove right border

    # Adjust legend position
    plt.legend(
        fontsize=50,
        prop={'family': "sans-serif", 'size': 24},
        bbox_to_anchor=(0.5, 1.05),  # 범례를 그래프 위로 이동
        loc='center'  # 가운데 정렬
    )
    
    plt.tight_layout()  # Adjust layout to prevent clipping
    plt.savefig("./figure2a.png")
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory>")
    else:
        directory = sys.argv[1]
        plot_graphs(directory)


