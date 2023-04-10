//
//  Test.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import SwiftUI

struct LikeView: View {
    var likedDestination: [Destination]
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            List (likedDestination) {
                destination in ListRow(eachDestination: destination, likeOrNot: true, changed: viewModel.dataChanged)
            }
            .navigationTitle("Liked Destination")
        }
        
    }
}

struct HateView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var hatedDestination: [Destination]
    
    var body: some View {
        NavigationView {
            List (hatedDestination) {
                destination in ListRow(eachDestination: destination, likeOrNot: false, changed: viewModel.dataChanged)
            }
            .navigationTitle("Hate Destination")
        }
        
    }
}

struct ListRow: View {
    var eachDestination: Destination
    var likeOrNot: Bool
    var changed: Bool
    
    var body: some View {
        if (eachDestination.liked == likeOrNot && eachDestination.viewed == true) {
            HStack {
                Image(eachDestination.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 80)
                
                Spacer()
                
                VStack (spacing: 20) {
                    Text(eachDestination.place.uppercased())
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    
                    Text(eachDestination.country)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
    }
}

struct Like_Previews: PreviewProvider {
    static var previews: some View {
        HateView(hatedDestination: destinationData)
    }
}
