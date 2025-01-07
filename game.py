import tkinter as tk
from tkinter import ttk, messagebox

class TravelApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Travel Planner")
        self.root.geometry("600x400")
        self.root.resizable(False, False)

        # Initialize data
        self.max_distance = 0
        self.current_distance = 0
        self.visited_cities = []
        self.places = {
            "Colombo": {"Kandy": 60, "Galle": 50},
            "Kandy": {"Sigiriya": 50, "Nuwara Eliya": 20},
            "Sigiriya": {"Anuradhapura": 20, "Jaffna": 70},
            "Galle": {"Hikkaduwa": 20, "Matara": 20},
            "Matara": {"Arugambay": 20, "Yala": 20},
        }
        self.current_place = "Colombo"

        # Styling
        style = ttk.Style()
        style.configure("TButton", font=("Helvetica", 12), padding=5)
        style.configure("TLabel", font=("Helvetica", 12))
        style.configure("TCombobox", font=("Helvetica", 12))

        # Title
        title_label = ttk.Label(root, text="Travel Planner", font=("Helvetica", 18, "bold"))
        title_label.pack(pady=10)

        # Input for max distance
        input_frame = ttk.Frame(root)
        input_frame.pack(pady=10)

        max_distance_label = ttk.Label(input_frame, text="Max travel distance (km):")
        max_distance_label.grid(row=0, column=0, padx=5)

        self.max_distance_entry = ttk.Entry(input_frame, width=10)
        self.max_distance_entry.grid(row=0, column=1, padx=5)

        submit_button = ttk.Button(input_frame, text="Start", command=self.set_max_distance)
        submit_button.grid(row=0, column=2, padx=5)

        # Travel information display
        self.info_label = ttk.Label(root, text="", font=("Helvetica", 12))
        self.info_label.pack(pady=10)

        # Dropdown for destinations
        dropdown_frame = ttk.Frame(root)
        dropdown_frame.pack(pady=10)

        destination_label = ttk.Label(dropdown_frame, text="Select your destination:")
        destination_label.grid(row=0, column=0, padx=5)

        self.destination_var = tk.StringVar()
        self.destination_dropdown = ttk.Combobox(dropdown_frame, textvariable=self.destination_var, state="readonly")
        self.destination_dropdown.grid(row=0, column=1, padx=5)
        self.destination_dropdown["values"] = []

        travel_button = ttk.Button(dropdown_frame, text="Travel", command=self.travel_to_destination)
        travel_button.grid(row=0, column=2, padx=5)

        # Visited cities display
        self.visited_label = ttk.Label(root, text="Visited Cities: None", font=("Helvetica", 12))
        self.visited_label.pack(pady=10)

    def set_max_distance(self):
        try:
            self.max_distance = int(self.max_distance_entry.get())
            if self.max_distance <= 0:
                raise ValueError
            self.current_distance = 0
            self.visited_cities = []
            self.current_place = "Colombo"
            self.update_info()
            self.update_destinations()
        except ValueError:
            messagebox.showerror("Invalid Input", "Please enter a valid positive integer.")

    def update_info(self):
        self.info_label.config(
            text=f"Current Location: {self.current_place}\n"
                 f"Distance Traveled: {self.current_distance} km\n"
                 f"Remaining Distance: {self.max_distance - self.current_distance} km"
        )

    def update_destinations(self):
        destinations = self.places.get(self.current_place, {})
        self.destination_var.set("")
        self.destination_dropdown["values"] = list(destinations.keys())

    def travel_to_destination(self):
        destination = self.destination_var.get()
        if not destination:
            messagebox.showwarning("No Selection", "Please select a destination.")
            return

        distance = self.places.get(self.current_place, {}).get(destination, None)
        if distance is None:
            messagebox.showerror("Error", "Invalid destination selected.")
            return

        if self.current_distance + distance > self.max_distance:
            messagebox.showwarning("Limit Exceeded", "You cannot travel that far today.")
            return

        self.current_distance += distance
        self.visited_cities.append(self.current_place)
        self.current_place = destination
        self.update_info()
        self.update_destinations()

        visited = ", ".join(self.visited_cities + [self.current_place])
        self.visited_label.config(text=f"Visited Cities: {visited}")

# Initialize the Tkinter app
if __name__ == "__main__":
    root = tk.Tk()
    app = TravelApp(root)
    root.mainloop()
