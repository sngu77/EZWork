import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingLogoutAlert = false
    @State private var notificationsEnabled = true
    @State private var emailNotifications = true
    @State private var pushNotifications = true
    @State private var language = "English"
    @State private var showingLanguagePicker = false
    
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.headline)
                            Text("john.doe@example.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Notifications Section
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        Toggle("Email Notifications", isOn: $emailNotifications)
                        Toggle("Push Notifications", isOn: $pushNotifications)
                    }
                }
                
                // Appearance Section
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $appState.isDarkMode)
                    
                    Button(action: { showingLanguagePicker = true }) {
                        HStack {
                            Text("Language")
                            Spacer()
                            Text(language)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // Account Section
                Section(header: Text("Account")) {
                    NavigationLink(destination: Text("Profile Settings")) {
                        Label("Profile Settings", systemImage: "person.fill")
                    }
                    
                    NavigationLink(destination: Text("Security")) {
                        Label("Security", systemImage: "lock.fill")
                    }
                    
                    NavigationLink(destination: Text("Privacy")) {
                        Label("Privacy", systemImage: "hand.raised.fill")
                    }
                }
                
                // Support Section
                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("Help Center")) {
                        Label("Help Center", systemImage: "questionmark.circle.fill")
                    }
                    
                    NavigationLink(destination: Text("Contact Support")) {
                        Label("Contact Support", systemImage: "envelope.fill")
                    }
                    
                    NavigationLink(destination: Text("About")) {
                        Label("About", systemImage: "info.circle.fill")
                    }
                }
                
                // Sign Out Section
                Section {
                    Button(action: { showingLogoutAlert = true }) {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Sign Out", isPresented: $showingLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    appState.isAuthenticated = false
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
            .sheet(isPresented: $showingLanguagePicker) {
                NavigationView {
                    List(languages, id: \.self) { language in
                        Button(action: {
                            self.language = language
                            showingLanguagePicker = false
                        }) {
                            HStack {
                                Text(language)
                                Spacer()
                                if self.language == language {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .navigationTitle("Select Language")
                    .navigationBarItems(trailing: Button("Done") {
                        showingLanguagePicker = false
                    })
                }
            }
        }
    }
} 