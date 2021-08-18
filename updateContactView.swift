import SwiftUI

struct updateContactView: View {
    @State var address: String = ""
    @Binding var id: Int64
    @State var tel: String = ""
    @State var name: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            TextField("Enter tel", text: $tel)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)

            TextField("Enter address", text: $address)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            Button(action: {
                DBConnection.changeContact(idValue: self.id, nameValue: self.name, telValue: self.tel, addressValue: Int64(self.address) ?? 0)
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("SAVE CHANGES")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
        .onAppear(perform: {
            let contactDetailsModel: contactDetailsModel = DBConnection.singleContact(idValue: self.id)
            self.name = contactDetailsModel.name
            self.tel = contactDetailsModel.tel
            self.address = String(contactDetailsModel.address)
        })
    }
}

struct updateContactView_Previews: PreviewProvider {
    @State static var id: Int64 = 0
    static var previews: some View {
        updateContactView(id: $id)
    }
}
