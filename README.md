# Tourist-guide-application in Jaclang

This project implements a **Travel Planner** using **Jac Language**. It allows users to navigate between different cities on a graph structure based on their maximum travel distance. The program dynamically calculates travel routes and ensures distance constraints are respected.

---

## Features

- **Graph-based Navigation**: Nodes (`Place`) represent cities, and edges (`a`) represent distances between them.
- **Dynamic Input**: Users input their maximum travel distance and choose destinations step-by-step.
- **Travel Constraints**: Ensures users cannot exceed the maximum distance they can travel in a day.
- **Visited Cities Tracker**: Keeps track of all the cities visited by the traveler.
- **Interactive User Interface**: Displays available destinations at each step and prompts for the next destination.

---

## How It Works

1. The user specifies the maximum distance they can travel (in kilometers).
2. The program starts at the root node (`Colombo`).
3. At each step:
   - The program displays available destinations.
   - The user selects their next destination.
   - The distance traveled is calculated and added to the total.
   - If the total distance exceeds the limit, the program terminates with a warning.
4. The program continues until the user decides to stop or exceeds the maximum distance.

---

## Code Structure

### **Nodes**
The `Place` node represents a city with a `Name` property and the ability to interact with a traveler.

```jac
node Place {
    has Name: str;
    can check with Traveller entry;
}
```

### **Edges**
The `a` edge connects places and holds the travel distance (in kilometers).

```jac
edge a {
    has val: int = 20; # Distance (kilometers)
}
```

### **Walker**
The `Traveller` walker navigates the graph, tracking visited cities and total travel distance.

```jac
walker Traveller {
    has visited_cities: list = [];
    has Distance: int = 0;
    has max_distance_can_travel: int = 0;

    can start_from with `root entry {
        visit [-->](`?Place);
    }

    can log_visit with Place entry {
        self.visited_cities.append(here);
        print("Visited cities so far: ", [city.Name for city in self.visited_cities]);
    }
}
```

### **Main Program**
The `with entry` block initializes the graph and starts the travel process.

```jac
with entry {
    Start = Place("Colombo");
    Kandy = Place("Kandy");
    Sigiriya = Place("Sigiriya");
    Galle = Place("Galle");
    Matara = Place("Matara");

    root +:a:val=0:+> Start;
    Start +:a:val=60:+> Kandy +:a:val=50:+> Place("Nuwara Eliya");
    Kandy +:a:+> Sigiriya;
    Sigiriya +:a:+> Place("Anuradhapura");
    Sigiriya +:a:val=70:+> Place("Jaffna");

    Start +:a:val=50:+> Galle;
    Galle +:a:+> Place("Hikkaduwa");
    Galle +:a:+> Matara +:a:+> Place("Arugambay");
    Matara +:a:+> Place("Yala");

    traveller = root spawn Traveller();
}
```

---

## Example Travel Flow

1. **Input**: How far can you travel today (km)? `100`
2. **Output**:
   - Available destinations: `Kandy`, `Galle`
   - Select your next destination: `Kandy`
3. **Result**:
   - "Now you are going to Kandy"
   - "Travelled distance: 60 km"
   - Available destinations: `Sigiriya`, `Nuwara Eliya`

---

## Running the Code

1. Install the **Jac language interpreter** if you haven't already.
2. Copy the code into a `.jac` file (e.g., `travel_planner.jac`).
3. Run the program using the Jac interpreter:
   ```bash
   jac run travel_planner.jac
   ```
4. Follow the prompts to navigate through the travel planner.

---

## Graph Representation

Here's the visual representation of the graph:

![image](https://github.com/user-attachments/assets/2253c44c-3619-4ec6-ba3c-a95a3fb41cc8)


---

## Future Enhancements

- Add more cities and routes.
- Implement multiple travelers.
- Introduce additional constraints (e.g., time limits or fuel costs).
- Optimize travel paths using algorithms like Dijkstra or A*.

---

Feel free to clone and modify the project as needed. Contributions are welcome! 😊
