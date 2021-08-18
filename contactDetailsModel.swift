//importing the core library
import Foundation
 
class contactDetailsModel: Identifiable {
//predefining variables... to be used with this model
//id as the unique identifier
    public var id: Int64 = 0
    //name - will be a string
    public var name: String = ""
    public var tel: String = ""
    public var address: String = ""
}