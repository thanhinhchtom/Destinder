//
//  final_projApp.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import UIKit
import SwiftUI
import Firebase

@main
struct final_projApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            LoginPrompt()
                .environmentObject(viewModel)
            //            AlertLogin()
            //            ContentView()
            //                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("finish configure db")
        return true
    }
}
