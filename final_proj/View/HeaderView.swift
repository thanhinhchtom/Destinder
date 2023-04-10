//
//  HeaderView.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import SwiftUI

struct AlertSignOut: View {
    @State public var showingAlert = true
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Button("") {
            showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            
            Alert(title: Text(""), message: Text("Are you sure?"), primaryButton: .destructive(Text("Cancel")), secondaryButton: .default(Text("Sign out")) {
                // code to execute when "Sign out" button is tapped
                viewModel.signOut()
            })
        }
    }
}

struct HeaderView: View {
    // MARK: - PROPERTIES
    @Binding var showLogoutView: Bool
    @Binding var showInfoView: Bool
    @EnvironmentObject var viewModel: AppViewModel
    
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack (spacing: 30) {
            
            Spacer()
            //information button
            Button(action: {
                // ACTION
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showInfoView.toggle()
            }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            .sheet(isPresented: $showInfoView) {
                InfoView()
            }
            
            Spacer()
            
            //application name
//            Image("logo-honeymoon-pink")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 28)
            Text("Final Project")
                .font(.system(size: 20))
                .foregroundColor(.red)
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            //guide button
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                //sign out
                viewModel.signOutSure = !viewModel.signOutSure
            })
            {
                Image(systemName: "rectangle.portrait.and.arrow.right").font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            
            if (viewModel.signOutSure == true) {
                AlertSignOut()
            }
            Spacer()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showLogout: Bool = false
    @State static var showInfo: Bool = false
    
    static var previews: some View {
        HeaderView(showLogoutView: $showLogout, showInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}

