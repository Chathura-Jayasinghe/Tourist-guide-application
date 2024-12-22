node Place{
    has Name:str; 

    can check with Traveller entry;
    
}

glob max_distance_can_travel = int(input("how far can you travel today(km): "));

:node:Place:can:check {
    # if here.Distance < 65 {
        # travelled_distance = :edge:[self<--];
        # here.Distance += travelled_distance[0].val;
        # print("Travelled distance: ", here.Distance);
        

        downward_available:list = [self-->(`?Place)]; #####show downward nodes
        upward_available:list = [self<--(`?Place)];#  #####show upward nodes
        
        available = downward_available + upward_available;

        found: bool = False;
        
        while not found {
            print("Available destinations: " ,[city.Name for city in available]);

            destination = input("Select your next destination: "); ##get input

            # found: bool = False;
            # for item in available{
            #     if item.Name == destination.capitalize(){
            #         found = True;
            #         if here.Distance < max_distance_can_travel { ####change this point
            #             print(f"Now you will going to {item.Name}");
            #             visit[item];
            #             # print("item",item);
            #             if item in downward_available{
            #                 travelled_distance = :edge:[item<--];
            #                 here.Distance += travelled_distance[0].val; 
            #             }
            #             elif item in upward_available{
            #                 travelled_distance = :edge:[item-->];
            #                 here.Distance += travelled_distance[0].val;
            #             }
            #             if here.Distance < max_distance_can_travel{}
            #             # here.Distance += travelled_distance[0].val;
            #             print("Travelled distance:",here.Distance);
            #             # print("Travelled distance:",travelled_distance);
            #             break;
            #         } else {
            #             print("Sorry, you cannot travel that far today.");
            #         }
            #     } 
            # }
            found: bool = False;
            for item in available{
                if item.Name == destination.capitalize(){
                    found: bool = True;
            
                        
                        if item in downward_available{
                            travelled_distance = :edge:[item<--];
                            here.Distance += travelled_distance[0].val; 
                            if here.Distance < max_distance_can_travel {
                                visit[item];
                                print(f"Now you will going to {item.Name}");
                                print("Travelled distance:",here.Distance);
                            }else {
                                print("Sorry, you cannot travel that far today.");
                                exit;
                                # found: bool = False;
                            }   
                        }
                        elif item in upward_available{
                            travelled_distance = :edge:[item-->];
                            here.Distance += travelled_distance[0].val;
                            if here.Distance < max_distance_can_travel {
                                visit[item];
                                print(f"Now you will going to {item.Name}");
                                print("Travelled distance:",here.Distance);
                            }else {
                                print("Sorry, you cannot travel that far today.");
                                exit;
                                # found: bool = False;
                            } 
                        }
                        # if here.Distance < max_distance_can_travel{}
                        # here.Distance += travelled_distance[0].val;
                        # print("Travelled distance:",here.Distance);
                        # print("Travelled distance:",travelled_distance);
                        break;
                    } 
                } 
            }

            if not found {
                print("Location not found.");
            } 
}
   
    # } else {
    #     print("Sorry, you cannot travel that far today.");
    # }
        



edge a{
    has val:int = 20; #Distance(kilometers)
}


walker Traveller{
    has visited_cities:list = [];
    has Distance:int = 0;
    has max_distance_can_travel:int=0;


    can start_from with `root entry { #start form root node
        visit [-->](`?Place);
    } 

    can log_visit with Place entry { #append the visited node from here
        self.visited_cities.append(here);
        print("Visited cities so far : ", [city.Name for city in self.visited_cities]);
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