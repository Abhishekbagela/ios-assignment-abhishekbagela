//
//  ApiResponse.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 17/04/24.
//

import Foundation

struct ApiResponse<T: Codable> {
    var body: T?
    var error: String?
}
