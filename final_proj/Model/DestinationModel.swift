//
//  DestinationModel.swift
//  final_proj
//
//  Created by Chí Thành Lê on 4/2/23.
//

import SwiftUI

struct Destination: Identifiable {
    var id: Int
    var place: String
    var country: String
    var image: String
    var liked: Bool
    var viewed: Bool
}
