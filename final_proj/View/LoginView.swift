//
//  LoginView.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    //create auth
    let auth = Auth.auth()
    @Published var signedIn = false
    @Published var signInFail = false
    @Published var signUpFail = false
    @Published var dataChanged = false
    @Published var signOutSure = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //Log in button
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                print("fail log in")
                self?.signInFail = true
                return
            }
            //            success
            DispatchQueue.main.async {
                self?.signedIn = true
                return
            }
        }
    }
    
    //sign up button
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                print("fail sign up")
                self?.signUpFail = true
                return
            }
            
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            //            self?.signedIn = true
            
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        self.signOutSure = false
    }
}

struct AlertLogin: View {
    @State public var showingAlert = true
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Button("") {
            showingAlert = true
            
        }
        .alert("Invalid email or password!!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                viewModel.signInFail = false
            }
        }
    }
}

struct AlertSignUp: View {
    @State public var showingAlert = true
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Button("") {
            showingAlert = true
        }
        .alert("Username already exist", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                viewModel.signUpFail = false
            }
        }
    }
}

struct LoginPrompt: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                TabControllerView()
                    .environmentObject(viewModel)
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            //logo of the app
            Image("newLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack {
                TextField("Username", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                //button to sign in
                Button {
                action: do {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    //call sign in method in viewmodel
                    viewModel.signIn(email: email + "@gmail.com", password: password)
                }
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink("Create account", destination: SignUpView())
                    .padding()
                
            }
            .padding()
            
            //alert if login error
            if (viewModel.signInFail) {
                AlertLogin()
            }
            
            Spacer()
        }
        //        .font(.headline)
        //        .navigationTitle("Sign In")
        //        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            //logo of the app
            Image("newLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack {
                //2 field to get username and password
                TextField("Username", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                //sign up button
                Button {
                action: do {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    //call sign up function in viewModel
                    viewModel.signUp(email: (email + "@gmail.com"), password: password)
                }
                } label: {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                //button down the sign up to back to sign in page
                Button("Already have account!") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .padding()
            
            // show alert about the problem
            if (viewModel.signUpFail) {
                AlertSignUp()
            }
            
            Spacer()
        }
        //        .navigationTitle("Create Account")
        //        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPrompt()
    }
}
