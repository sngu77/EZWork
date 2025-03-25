import SwiftUI

struct AuthenticationView: View {
    @State private var isShowingLogin = true
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo and Title
                Image(systemName: "building.2.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Business App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Form Fields
                VStack(spacing: 15) {
                    if !isShowingLogin {
                        TextField("Full Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.words)
                    }
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                // Action Button
                Button(action: handleAuthentication) {
                    Text(isShowingLogin ? "Login" : "Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Social Login Options
                VStack(spacing: 15) {
                    Text("Or continue with")
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 20) {
                        SocialLoginButton(image: "apple.logo", action: {})
                        SocialLoginButton(image: "g.circle.fill", action: {})
                        SocialLoginButton(image: "f.circle.fill", action: {})
                    }
                }
                .padding(.top)
                
                // Toggle between Login and Register
                Button(action: { isShowingLogin.toggle() }) {
                    Text(isShowingLogin ? "Don't have an account? Register" : "Already have an account? Login")
                        .foregroundColor(.blue)
                }
                .padding(.top)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func handleAuthentication() {
        // TODO: Implement actual authentication
        // For now, we'll just simulate a successful login
        appState.isAuthenticated = true
    }
}

struct SocialLoginButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
        }
    }
} 