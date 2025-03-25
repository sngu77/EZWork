import Foundation

struct Ticket: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let status: TicketStatus
    let priority: TicketPriority
    let createdAt: Date
    let updatedAt: Date
    let assignedTo: User
    
    static let testTickets = [
        Ticket(
            id: "1",
            title: "Login Issue",
            description: "User unable to login with correct credentials",
            status: .open,
            priority: .high,
            createdAt: Date(),
            updatedAt: Date(),
            assignedTo: User.testUser
        ),
        Ticket(
            id: "2",
            title: "Dashboard Loading Slow",
            description: "Dashboard takes more than 5 seconds to load",
            status: .inProgress,
            priority: .medium,
            createdAt: Date().addingTimeInterval(-3600),
            updatedAt: Date(),
            assignedTo: User.testUser
        )
    ]
}

enum TicketStatus: String, Codable {
    case open
    case inProgress
    case resolved
    case closed
}

enum TicketPriority: String, Codable {
    case low
    case medium
    case high
    case urgent
} 