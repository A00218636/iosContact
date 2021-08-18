import SQLite //import sqlite swift library 
 
class DBConnection {
    private var dbcon: Connection!
    private var contacts: Table! //the table name
    private var name: Expression<String>! //name of the person who owns this contact
    private var id: Expression<Int64>! //unique identifier
    private var address: Expression<Int64>! 
    private var tel: Expression<String>!

//-----------------------------------------------------------------------

    init () {
            let db_path: String =NSSearchdb_pathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            dbcon= try Connection("\(db_path)/my_contacts.sqlite3")
            contacts = Table("contacts")
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            tel = Expression<String>("tel")
            address = Expression<Int64>("address")
            //end initializing required columns
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                // create the table if it doesn't exist..
                try db.run(contacts.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(tel, unique: true)
                    t.column(address)
                })
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
       
         
    }


//-----------------------------------------------------------------------

    public func showContacts() -> [contactDetailsModel] {
        var contatDetailsModels: [contatDetailsModel] = [] //initialize blank array
        contacts = contacts.order(id.desc)
            for contact in try db_con.prepare(contacts) {
                let contatDetailsModel: contatDetailsModel = contatDetailsModel()
                contatDetailsModel.id = contact[id]
                contatDetailsModel.name = contact[name]
                contatDetailsModel.tel = contact[tel]
                contatDetailsModel.address = contact[address]
                contatDetailsModels.append(contatDetailsModel)
            }
        

        return contatDetailsModels
    }


public func removeContact(idValue: Int64) { //removes a contact record from the database
        do {
            let contact: Table = contacts.filter(id == idValue)
            try db.run(contact.delete())
        } catch {
            print(error.localizedDescription)
        }
    }

//-----------------------------------------------------------------------
    public func saveContact(nameValue: String, telValue: String, addressValue: Int64) {
    do {
        try db_con.run(contacts.insert(name <- nameValue, tel <- telValue, address <- addressValue))
    } catch {
        print(error.localizedDescription)
    }
}
//-----------------------------------------------------------------------

public func changeContact(idValue: Int64, nameValue: String, telValue: String, addressValue: Int64) {
        do {
            let contact: Table = contacts.filter(id == idValue)
            try db.run(contact.update(name <- nameValue, tel <- telValue, address <- addressValue))
        } catch {
            print(error.localizedDescription)
        }
    }
//-----------------------------------------------------------------------

public func singleContact(idValue: Int64) -> contactDetailsModel {
        let contactDetailsModel: contactDetailsModel = contactDetailsModel()
        do {
            let contact: AnySequence<Row> = try db.prepare(contacts.filter(id == idValue))
            try contact.forEach({ (singleVal) in
                contactDetailsModel.id = try singleVal.get(id)
                contactDetailsModel.name = try singleVal.get(name)
                contactDetailsModel.tel = try singleVal.get(tel)
                contactDetailsModel.address = try singleVal.get(address)
            })
        } catch {
            print(error.localizedDescription)
        }
        return contactDetailsModel
    }
//-----------------------------------------------------------------------

}