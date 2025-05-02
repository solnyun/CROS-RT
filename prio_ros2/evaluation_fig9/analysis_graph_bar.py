import pandas as pd
import matplotlib.pyplot as plt

# Load the Excel file
file_path = './all_chain.xlsx'
df = pd.read_excel(file_path)

# Extracting the maximum values for each chain and type, excluding 100000 and 0
chains = ['chain1', 'chain2', 'chain3', 'chain4']
types = ['vanilla', 'framework', "preempt"]

max_values = {}
for chain in chains:
    for type_ in types:
        column_name = f'{type_}_{chain}'
        if column_name in df.columns:
            valid_values = df[column_name][(df[column_name] != 100000) & (df[column_name] != 0)]
            max_value = valid_values.max()
            max_values[f'{type_}_{chain}'] = max_value
        else:
            max_values[f'{type_}_{chain}'] = 0

# Preparing data for plotting
bar_width = 0.25
index = range(len(chains))

# Plotting
fig, ax = plt.subplots()

vanilla_values = [max_values[f'vanilla_{chain}'] for chain in chains]
framework_values = [max_values[f'framework_{chain}'] for chain in chains]
preempt_values = [max_values[f'preempt_{chain}'] for chain in chains]

bar1 = ax.bar(index, vanilla_values, bar_width, label='Vanilla', color='#264653')
bar2 = ax.bar([i + bar_width for i in index], framework_values, bar_width, label='Framework', color='#e76f51')
bar3 = ax.bar([i + 2 * bar_width for i in index], preempt_values, bar_width, label='Preempt-RT', color='#2a9d8f')

# Adding labels and title
ax.set_ylabel('Worst-case End-to-End Latency')
ax.set_xticks([i + bar_width for i in index])
ax.set_xticklabels(chains)
ax.legend()

# Display the plot
plt.show()

# Save the plot
fig.savefig("./graph_bar.png")

