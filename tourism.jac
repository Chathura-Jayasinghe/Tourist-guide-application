node Place{
    has Name:str; 
    
    can check with Traveller entry;
    
}


:node:Place:can:check {
    # if here.Distance < 65 {
        travelled_distance = :edge:[self<--];
        here.Distance += travelled_distance[0].val;
        print("Travelled distance: ", here.Distance);
        available:list = [self--> ];
        
        print("Available destinations: " ,[city.Name for city in available]);

        destination = input("Select your next destination: ");

        found: bool = False;
        for item in available{
            if item.Name == destination.capitalize(){
                found = True;
                if here.Distance < 65 {
                    print(f"Now you will going to {item.Name}");
                    visit[item];
                    break;
                } else {
                    print("Sorry, you cannot travel that far today.");
                }
            } 
        }
        if not found {
            print("Location not found");
        }    
    # } else {
    #     print("Sorry, you cannot travel that far today.");
    # }
        
}


edge a{
    has val:int = 20; #Distance(kilometers)
}


walker Traveller{
    has visited_cities:list = [];
    has count:int = 0;
    has Distance:int = 0;

    can start_from with `root entry { #start form root node
        visit [-->](`?Place);
    } 

    can log_visit with Place entry { #append the visited node from here
        self.visited_cities.append(here);
        print("Visited cities so far : ", [city.Name for city in self.visited_cities]);
        self.count +=1;
    }


}



with entry{
    Start = Place("Colombo");   #define the special nodes
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
    # print(traveller);
}