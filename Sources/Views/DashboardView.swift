import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTimeRange: TimeRange = .week
    
    enum TimeRange: String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Time Range Picker
                    Picker("Time Range", selection: $selectedTimeRange) {
                        ForEach(TimeRange.allCases, id: \.self) { range in
                            Text(range.rawValue).tag(range)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Key Metrics
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        MetricCard(title: "Total Revenue", value: "$12,345", trend: "+12%", icon: "dollarsign.circle.fill")
                        MetricCard(title: "Active Users", value: "1,234", trend: "+8%", icon: "person.2.fill")
                        MetricCard(title: "Open Tickets", value: "45", trend: "-5%", icon: "ticket.fill")
                        MetricCard(title: "Conversion Rate", value: "24%", trend: "+3%", icon: "chart.line.uptrend.xyaxis")
                    }
                    .padding(.horizontal)
                    
                    // Revenue Chart
                    VStack(alignment: .leading) {
                        Text("Revenue Overview")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(0..<7) { index in
                                LineMark(
                                    x: .value("Day", "Day \(index + 1)"),
                                    y: .value("Revenue", Double.random(in: 1000...5000))
                                )
                                .foregroundStyle(Color.blue)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Recent Activities
                    VStack(alignment: .leading) {
                        Text("Recent Activities")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(0..<5) { _ in
                            ActivityRow()
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Dashboard")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let trend: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(trend)
                .font(.caption)
                .foregroundColor(trend.hasPrefix("+") ? .green : .red)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct ActivityRow: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading) {
                Text("John Doe")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text("Updated ticket #123")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("2m ago")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
    }
} 