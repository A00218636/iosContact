import SwiftUI
 
struct createContactView: View {
    @State var name: String = ""
    @State var tel: String = ""
    @State var address: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode> //return home when a new contact is created...
     
    var body: some View {
         
    VStack {

    //name field
    
    TextField("Enter name", text: $name).padding(10).background(Color(.systemGray6)).cornerRadius(5).disableAutocorrection(true)
    //tel no field
    TextField("Enter tel", text: $tel).padding(10).background(Color(.systemGray6)).cornerRadius(5).keyboardType(.telAddress).autocapitalization(.none).disableAutocorrection(true)
    //address field
    TextField("Enter address", text: $address).padding(10).background(Color(.systemGray6)).cornerRadius(5).keyboardType(.numberPad).disableAutocorrection(true)
             
            // a submit button to save contact info into the contacts DB
    Button(action: {
                DBConnection().saveContact(nameValue: self.name, telValue: self.tel, addressValue: Int64(self.address) ?? 0)
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("SAVE CONTACT DETAILS")
            }).frame(maxWidth: .infinity, alignment: .trailing).padding(.top, 10).padding(.bottom, 10)
        }.padding()
         
    }
}