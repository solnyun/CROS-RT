import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load the data
data = pd.read_excel("./all_chain.xlsx")

# Replace 100000 (message error) with NaN
data = data.replace(100000, pd.NA)

# Update columns to include preempt chain
data.columns = ["Chain1_Vanilla", "Chain1_Framework", "Chain1_Preempt",
                "Chain2_Vanilla", "Chain2_Framework", "Chain2_Preempt",
                "Chain3_Vanilla", "Chain3_Framework", "Chain3_Preempt",
                "Chain4_Vanilla", "Chain4_Framework", "Chain4_Preempt"]

# Melt the dataframe for seaborn boxplot
melted_data_ethernet = data.melt(var_name='chains', value_name='latency')

# Split the 'chains' column into 'chain' and 'type'
melted_data_ethernet[['Chain', 'Type']] = melted_data_ethernet['chains'].str.split('_', expand=True)

# Drop rows with 'NA' values in the 'latency' column
melted_data_ethernet = melted_data_ethernet.dropna(subset=['latency'])

# Plot the boxplot
fig, ax = plt.subplots(figsize=(14, 8))  # 그래프 크기 조정
sns.boxplot(x='Chain', y='latency', hue='Type', data=melted_data_ethernet, palette=['#264653', '#e76f51', '#2a9d8f'], ax=ax)

# Set x and y labels with specified font size and remove title
ax.set_xlabel('Chain', fontsize=20, fontweight='bold')
ax.set_ylabel('End-to-End Latency (ms)', fontsize=20, fontweight='bold')
ax.tick_params(axis='both', which='major', labelsize=14)

# Handle legends
handles, labels = ax.get_legend_handles_labels()
labels[0] = "Vanilla"
labels[1] = "Framework"
labels[2] = "Preempt-RT"
ax.legend(handles=handles, labels=labels, fontsize=18, loc='upper left')

max_values = data.max()
print("Max values for each chain:")
print(max_values)

plt.savefig("./analysis_graph_box.png")
plt.show()

