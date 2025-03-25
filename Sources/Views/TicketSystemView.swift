import SwiftUI

struct TicketSystemView: View {
    @State private var selectedFilter: TicketFilter = .all
    @State private var showingNewTicket = false
    @State private var searchText = ""
    
    enum TicketFilter: String, CaseIterable {
        case all = "All"
        case open = "Open"
        case inProgress = "In Progress"
        case resolved = "Resolved"
        case closed = "Closed"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(TicketFilter.allCases, id: \.self) { filter in
                            FilterButton(title: filter.rawValue,
                                       isSelected: selectedFilter == filter) {
                                selectedFilter = filter
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // Ticket List
                List {
                    ForEach(0..<10) { _ in
                        TicketRow()
                    }
                }
            }
            .navigationTitle("Tickets")
            .searchable(text: $searchText, prompt: "Search tickets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewTicket = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewTicket) {
                NewTicketView()
            }
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

struct TicketRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Ticket #123")
                    .font(.headline)
                Spacer()
                StatusBadge(status: .open)
            }
            
            Text("Customer reported login issues")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Label("John Doe", systemImage: "person.fill")
                    .font(.caption)
                Spacer()
                Label("2h ago", systemImage: "clock.fill")
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct StatusBadge: View {
    enum Status {
        case open
        case inProgress
        case resolved
        case closed
    }
    
    let status: Status
    
    var body: some View {
        Text(statusText)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(statusColor)
            .cornerRadius(8)
    }
    
    private var statusText: String {
        switch status {
        case .open: return "Open"
        case .inProgress: return "In Progress"
        case .resolved: return "Resolved"
        case .closed: return "Closed"
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .open: return .orange
        case .inProgress: return .blue
        case .resolved: return .green
        case .closed: return .gray
        }
    }
}

struct NewTicketView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var priority = "Medium"
    
    let priorities = ["Low", "Medium", "High", "Urgent"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ticket Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority).tag(priority)
                        }
                    }
                }
            }
            .navigationTitle("New Ticket")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Create") {
                    // TODO: Implement ticket creation
                    dismiss()
                }
                .disabled(title.isEmpty || description.isEmpty)
            )
        }
    }
} 