//
//  CacheManager.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 18/04/24.
//

import SwiftUI

//MARK: SINGLETON (Memory Cache Manager)
class CacheManager {
    
    static let instance = CacheManager()
    
    private init() {}
    
    private let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 //Max image store
        cache.totalCostLimit = 1024 * 1024 * 100 //Total images size 100 MB
        return cache
    }()
    
    
    func saveImage(_ image: UIImage, _ name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func getImage(_ name: String) -> UIImage? {
        imageCache.object(forKey: name as NSString)
    }
    
}
