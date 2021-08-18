import SwiftUI

struct contentView: View {
    @State var contactId: Int64 = 0
    @State var contactDetailsModels: [contactDetailsModel] = []
    @State var selectedContact: Bool = false
var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink (destination: createContactView(), label: {
                        Text("+ NEW CONTACT")
                    })
                }
                NavigationLink (destination: updateContactView(id: self.$contactId), isActive: self.$selectedContact) {
                    EmptyView()
                }
                List (self.contactDetailsModels) { (model) in
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.tel)
                        Spacer()
                        Text("\(model.address)")
                        Spacer()
                 
                    Button(action: {
                            self.contactId = model.id
                            self.selectedContact = true
                        },label: {
                            Text("UPDATE").foregroundColor(Color.pink)
                            }).buttonStyle(PlainButtonStyle())
                 Button(action: {
                 let DBConnection: DBConnection = DBConnection()
                 DBConnection.removeContact(idValue: model.id)
                 self.contactDetailsModels = DBConnection.showContacts()
                        },label: {
                            Text("REMOVE").foregroundColor(Color.yellow)
                        }).buttonStyle(PlainButtonStyle())
                    }
                }
         
            }.padding().navigationBarTitle("--CONTACT APP --").onAppear(perform: {
                self.contactDetailsModels = DBConnection().showContacts()
            })
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        contentView()
    }
}
