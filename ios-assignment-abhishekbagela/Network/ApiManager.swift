//
//  ApiManager.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 17/04/24.
//

import Foundation

//MARK: SINGELTON
final class ApiManager {
  
    private init() {}
    
    static let instance = ApiManager()
    
    func sendRequest<T: Codable>(endpoint: String,
                                 method: HttpMethod,
                                 token: String? = nil,
                                 param: [String:String]? = nil,
                                 requestBody: T? = nil) async -> ApiResponse<T> {
        
        let url = Endpoint.BASE_URL.rawValue + endpoint
        
        guard let url = URL(string: url) else {
            return ApiResponse(error: "Invalid URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if (param?.count != nil) {
            urlRequest.allHTTPHeaderFields = param
        }
        
        if (token?.isEmpty == false) {
            urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        }
        
        if (method == .POST || method == .PUT) {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(requestBody)
            } catch {
                return ApiResponse(error: error.localizedDescription)
            }
        } // end if
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard response is HTTPURLResponse else {
                return ApiResponse(error: "Invalid response")
            }
            
            //MARK: here check if httpResponse.statusCode == 401 then refresh token
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
            return ApiResponse(body: decodedResponse)
        } catch {
            return ApiResponse(error: error.localizedDescription)
        }
        
    } // end sendRequest
    
    
    func downloadImage(_ url: String?, _ completion: @escaping (Data?, String?)->Void) {
        guard let url = url else {
            print("Url nil")
            completion(nil, "Failed to load image")
            return
        }
        
        guard let url = URL(string: url) else {
            print("Invalid url")
            completion(nil, "Failed to load image")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            if let data = data {
                completion(data, nil)
            } else {
                print("xxxx dataTask error \(error?.localizedDescription as Any)")
                completion(nil, "Failed to load image")
            }
        }
        .resume()
    }
}
