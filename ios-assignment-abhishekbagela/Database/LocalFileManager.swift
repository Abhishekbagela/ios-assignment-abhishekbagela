//
//  FileManager.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 20/04/24.
//

import Foundation
import SwiftUI

//MARK: SINGLETON (Disk Cache Manager)
final class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    
    func saveImage(_ image: UIImage?, _ name: String?) {
        guard let image = image, let name = name else {
            return
        }
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
                let url = getImagePath(name) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("error \(error)")
        }
        
    }
    
    func getImage(_ name: String?) -> UIImage? {
        guard let name = name else {
            return nil
        }
        
        guard let path = getImagePath(name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    //MARK: ---------- Private ------------
    
    private func getImagePath(_ name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg", conformingTo: .image) else {
            return nil
        }
        
        return path
    }
    
}
