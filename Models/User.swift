import Foundation

enum UserRole: String, Codable {
    case patient
    case doctor
    case nurse
}

struct User: Identifiable, Codable {
    
    var id: String
    var name: String
    var email: String
    var role: UserRole
    
}
