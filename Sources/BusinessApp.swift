import SwiftUI

@main
struct BusinessApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isDarkMode = false
    @Published var isOffline = false
    
    // Add more app-wide state management here
}

struct User: Codable {
    let id: String
    let email: String
    let name: String
    let role: UserRole
}

enum UserRole: String, Codable {
    case admin
    case user
    case manager
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isAuthenticated {
                MainTabView()
            } else {
                AuthenticationView()
            }
        }
        .preferredColorScheme(appState.isDarkMode ? .dark : .light)
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
            
            TicketSystemView()
                .tabItem {
                    Label("Tickets", systemImage: "ticket.fill")
                }
            
            CRMView()
                .tabItem {
                    Label("CRM", systemImage: "person.2.fill")
                }
            
            ExpensesView()
                .tabItem {
                    Label("Expenses", systemImage: "dollarsign.circle.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
} 