import matplotlib.pyplot as plt
import os
import sys

# Function to read data from a file, calculate settling time, and plot
def plot_pendulum_position_to_convergence(file_path):
    float_points = []
    times = []
    m_pi = 3.141592653589793238462643383279502884
    command = m_pi / 2
    tolerance = command * 0.05  # Change tolerance to 2% of the command value
    
    inside_tolerance = False
    first_inside_time = None
    initial_time = None  # Variable to store the initial time value

    # Read data from the file
    with open(file_path, 'r') as file:
        for line in file:
            if 'cur_pos' in line:
                parts = line.split()
                current_float_point, current_time = float(parts[1]), float(parts[2])

                if initial_time is None:  # Set the initial time
                    initial_time = current_time
                
                adjusted_time = current_time - initial_time  # Adjust time to start from 0
                
                float_points.append(current_float_point)
                times.append(adjusted_time)
                
                # Check if current point is within the tolerance
                if abs(current_float_point - command) <= tolerance:
                    if not inside_tolerance:
                        inside_tolerance = True
                        if first_inside_time is None:
                            first_inside_time = adjusted_time
                else:
                    inside_tolerance = False
                    first_inside_time = None  # Reset if it goes outside the tolerance again

    # Plotting
    plt.figure(figsize=(10, 6))
    plt.plot(times, float_points, label='Pendulum Position')
    plt.axhline(y=command, color='r', linestyle='-', linewidth=1)
    if first_inside_time is not None:
        plt.axvline(x=first_inside_time, color='g', linestyle='--', linewidth=1)
    
    # Adding Setpoint and Settling Time information to the legend
    legend_labels = ['Pendulum Position', f'Setpoint: {command:.3f}']
    if first_inside_time is not None:
        legend_labels.append(f'Settling Time: {first_inside_time:.3f}s')
    
    #plt.title('Pendulum Position Until Convergence')
    plt.xlabel('Time', fontsize=18)
    plt.ylabel('Position', fontsize=18)
    plt.legend(legend_labels,fontsize=18)
    plt.grid(True)
    plt.xlim(left=0)  # Ensure x-axis starts at 0
    plt.ylim(-0.1, 3.0)
    save_path = f"result/{os.path.splitext(os.path.basename(file_path))[0]}_analysis_graph.png"
    plt.savefig(save_path)
    plt.show()

    return first_inside_time

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    first_inside_time = plot_pendulum_position_to_convergence(file_path)
    if first_inside_time is not None:
        print(f"Settling Time: {first_inside_time:.3f} seconds")
    else:
        print("Settling Time: Not found within the data")

