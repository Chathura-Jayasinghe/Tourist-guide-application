node Place{
    has Name:str; 
    
    can check with jason entry;
    
}


:node:Place:can:check {
    while here.Distance < 200 {
        available:list = [self--> ];
        # if len(avialable) == 0 {
        #     exit();
        # }
        print(available);

        path = input("Select your path: ");
        
        ed = :edge:[self<--];
        here.Distance += ed[0].val;
        print(here.Distance);

        for item in available {
            if item.Name == path {
                print(f"Now you are going to {item.Name}");
                self = item;
                break;
            } else {
                print("You cannnot go there from here");
            }
        }
        
        
    }
        
}


edge a{
    has val:int = 20; ##Distance(kilometers)
}


walker jason{
    has visited_nodes:list = [];
    has count:int = 0;
    has Distance:int = 0;

    can strat_from with `root entry { #start form root node
        visit [-->](`?Place);
    } 

    can log_visit with Place exit { #append the visited node from here
        print("Visiting node : ", here);
        self.visited_nodes.append(here);
        self.count +=1;
    }

    # can go(destination: Place);

}

# :walker:jason:can:go
# (destination: Place) {
#     visit [here --> destination];
# }



with entry{
    Start = Place("Colombo");   #define the special nodes
    Kandy = Place("Kandy");
    Sigiriya = Place("Sigiriya");
    Galle = Place("Galle");
    Matara = Place("Matara");

    root +:a:+> Start;
    Start +:a:val=60:+> Kandy +:a:val=50:+> Place("Nuwara Eliya");
    Kandy +:a:+> Sigiriya;
    Sigiriya +:a:+> Place("Anuradhapura");
    Sigiriya +:a:val=70:+> Place("Jaffna");

    Start +:a:val=50:+> Galle;
    Galle +:a:+> Place("Hikkaduwa");
    Galle +:a:+> Matara +:a:+> Place("Arugambay");
    Matara +:a:+> Place("Yala");
 
    wlk_obj = root spawn jason();
    print(wlk_obj);
}