//
//  TabControllerView.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import SwiftUI

struct TabControllerView: View {
    @State private var selection = 1
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        TabView (selection: $selection) {
            HateView(hatedDestination: destinationData)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Hate", systemImage: "xmark.circle")
                }
                .tag(0)
            ContentView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Destination", systemImage: "magazine")
                }
                .tag(1)
            LikeView(likedDestination: destinationData)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Like", systemImage: "heart.circle")
                }
                .tag(2)
            
        }
        .onAppear {
            selection = 1
        }
    }
}

struct TabControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView()
    }
}
