import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load your data
data_path = './all_chain.xlsx'  # Update this path to your actual data file location
df = pd.read_excel(data_path, engine='openpyxl')

# Replace values greater than 10000 with NaN in a copy of the DataFrame
df_replaced = df.where(df <= 10000, np.nan)

def plot_vanilla_framework_combined_cdf_custom_colors_with_deadlines(data):
    fig, axs = plt.subplots(2, 2, figsize=(15, 15))  # Adjusting for 4 subplots (2 rows, 2 columns)
    axs = axs.flatten()  # Flattening the array for easy indexing

    vanilla_color = '#264653'  # Specific hex color for vanilla
    framework_color = '#e76f51'  # Specific hex color for framework
    deadline_colors = 'red'  # Color for the deadlines

    # Deadlines for each chain
    deadlines = [80, 80, 160, 1000]

    for i in range(1, 5):  # For each chain from 1 to 6
        chain_prefix = f'chain{i}'
        vanilla_column = f'vanilla_{chain_prefix}'
        framework_column = f'framework_{chain_prefix}'

        # Plotting the CDFs
        value_counts_vanilla = data[vanilla_column].value_counts().sort_index()
        cumsum_vanilla = value_counts_vanilla.cumsum()
        cdf_vanilla = cumsum_vanilla / cumsum_vanilla.iloc[-1]
        axs[i-1].plot(np.array(cdf_vanilla.index), np.array(cdf_vanilla), label=vanilla_column, color=vanilla_color)

        value_counts_framework = data[framework_column].value_counts().sort_index()
        cumsum_framework = value_counts_framework.cumsum()
        cdf_framework = cumsum_framework / cumsum_framework.iloc[-1]
        axs[i-1].plot(np.array(cdf_framework.index), np.array(cdf_framework), label=framework_column, color=framework_color)

        # Adding deadline as a vertical line
        axs[i-1].axvline(x=deadlines[i-1], color=deadline_colors, linestyle='--', label=f'Deadline {deadlines[i-1]}ms')

        axs[i-1].set_xlabel('Value')
        axs[i-1].set_ylabel('CDF')
        axs[i-1].set_title(f'Combined CDF Plot of {chain_prefix}')
        axs[i-1].legend()
        axs[i-1].grid(True)

    plt.tight_layout()
    plt.savefig("./divide1_prio/analysis_graph_cdf.png")
    plt.show()

# Calling the plotting function with the modified DataFrame
plot_vanilla_framework_combined_cdf_custom_colors_with_deadlines(df_replaced)

