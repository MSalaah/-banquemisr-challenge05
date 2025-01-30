//
//  ApiClient.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//

import Foundation

protocol APIProtocol {
    func executeRequest<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T,NetworkError>) -> Void)
    var baseUrl: String {get}
}

class ApiClient: APIProtocol {
    
    var baseUrl: String = Constants.baseUrl
    
    func executeRequest<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T,NetworkError>) -> Void)   {
        print("URL REQUEST PATH IS ", urlRequest.url?.absoluteString ?? "NONE")
        print("URL REQUEST METHOD IS ", urlRequest.httpMethod ?? "NONE")
        print("URL REQUEST HEADERS IS ", urlRequest.allHTTPHeaderFields ?? [:])
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("API Request Failed With Error",error.localizedDescription)
                    completion(.failure(NetworkError.unknownError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
                return
            }
            
            var result: Result<T,NetworkError>?
            result = self.handleResponse(urlRequest: urlRequest,
                                         response: httpResponse,
                                         data: data,
                                         completion: completion)
            if let result = result {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
        task.resume()
    }
    
    private func handleResponse<T: Decodable>(urlRequest: URLRequest,
                                              response: HTTPURLResponse,
                                              data:Data?,
                                              completion: @escaping ((Result<T,NetworkError>) -> Void)) -> Result<T,NetworkError> {
        
        print("Request: \(String(describing: urlRequest.url?.absoluteString)) > status code: ", response.statusCode)
        
        if response.statusCode == 200 {
            if let data = data {
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let requestResult = try decoder.decode(T.self, from: data)
                    print("RESPONSE IS ",data.convertToJson() as Any)
                    return .success(requestResult)
                } catch {
                    print("\(String(describing: urlRequest.url?.absoluteString ?? "")) Decoding Failed With Error: \(error)")
                    return .failure(.decodingFailed)
                }
            }
        } else if response.statusCode == 401 {
            print("API \(String(describing: urlRequest.url?.absoluteString ?? "")) Failed With Authotization Error")
            return .failure(.unauthorized)
        }
        print("API \(String(describing: urlRequest.url?.absoluteString ?? "")) Failed With Unknow Error")
        return .failure(.unknownError)
    }
}

extension Data {
    public func convertToJson() -> [String : Any]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        return json
    }
    
    public func convertToJsonArray() -> [[String : Any]]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [[String : Any]]
        return json
    }
    
    public func convertTo<T: Decodable>(to: T.Type) -> T?{
        let decoder = JSONDecoder()
        return  try? decoder.decode(to.self, from: self)
    }
}
