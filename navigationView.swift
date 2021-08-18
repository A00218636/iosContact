//create main thread/win
NavigationView {
    VStack {
        HStack {
            Spacer()
            NavigationLink (destination: createContactView(), label: {
            Text("Create New Contact") }) 
        } 
    }.padding().navigationBarTitle("--CONTACT APP ASSIGNMENT--") 

}