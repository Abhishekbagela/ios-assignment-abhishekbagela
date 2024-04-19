//
//  ContentViewModel.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 16/04/24.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var loading = false
    @Published var models: [Model]? = nil
    
    func refreshData() async {
        // Simulate asynchronous data refreshing
        Task {
            loading = true
            await getData()
            loading = false
        }
    }
    
    func getImage(url: String?, name: String?, _ completion: @escaping (UIImage?, String?) -> Void) {
        guard let url = url, let name = name else {
            completion(nil, nil)
            return
        }
        
        //Check Memory Cache
        if let image = CacheManager.instance.getImage(name) {
            completion(image, nil)
            return
        }
        
        //Check Disk Cache
        if let image = LocalFileManager.instance.getImage(name) {
            // Store in memory cache
            CacheManager.instance.saveImage(image, name)
            
            completion(image, nil)
            return
        }
        
        //Load from server
        DispatchQueue.global().async {
            
            self.downloadImage(url) { image, error in
                guard let image = image else {
                    completion(nil, error)
                    return
                }
                
                // Store in memory cache
                CacheManager.instance.saveImage(image, name)
                
                // Store in disk cache
                LocalFileManager.instance.saveImage(image, name)
                
                completion(image, error)
                return
            }
            
        }
        
    }
    
}

//MARK: ----------------------------- Api call -------------------------------
extension ContentViewModel {
    
    func getData() async {
        let endpoint = Endpoint.MEDIA_COVERAGES.rawValue + "?limit=100"
        // Simulate asynchronous data loading
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
            
            let res = await ApiManager.instance.sendRequest(endpoint: endpoint, method: .GET, requestBody: models)
            if (res.error?.isEmpty == false) {
                print(res.error as Any)
            } else {
                DispatchQueue.main.async {
                    self.models = res.body
                }
            }
        } catch {
            print("")
        }
        
    }
    
    private func downloadImage(_ url: String?, _ completion: @escaping (UIImage?, String?) -> Void) {
        
        guard let url = url else {
            completion(nil, nil)
            return
        }
        
        ApiManager.instance.downloadImage(url) { data, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            } else {
                completion(nil, error)
            }
        }
        
    }
}
