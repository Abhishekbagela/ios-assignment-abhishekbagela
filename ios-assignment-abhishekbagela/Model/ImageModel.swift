//
//  ImageModel.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 19/04/24.
//

import SwiftUI

struct ImageModel {
    var id = UUID().uuidString
    var image: UIImage?
    var aspectRatio: Int?
    
    init(_ image: UIImage? = nil, _ aspectRatio: Int? = nil) {
        self.image = image
        self.aspectRatio = aspectRatio
    }
}
