import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let role: UserRole
    
    static let testUser = User(
        id: "1",
        email: "john.doe@example.com",
        name: "John Doe",
        role: .user
    )
}

enum UserRole: String, Codable {
    case admin
    case user
    case manager
} 