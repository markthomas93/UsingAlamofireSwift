//
//  Rest.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 26/07/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation

class RestManager {
    
    // MARK: - Properties
    
    var requestHttpHeaders : [String: String] = [:]
    
    var urlQueryParameters : [String: String] = [:]
    
    var httpBodyParameters : [String: String] = [:]
    
    var httpBody: Data?
        
    // MARK: - Public Methods
    
    func makeRequest(toURL url: URL, withHttpMethod httpMethod: HttpMethodEnum, completion: @escaping (_ result: Results) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let targetURL = self?.addURLQueryParameters(toURL: url)
            let httpBody = self?.getHttpBody()
            
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
            {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) {
                (data, response, error) in completion(Results(withData: data, response: Response(fromURLResponse: response), error: error))
            }
            task.resume()
        }
    }
    
    // MARK: - Private Methods
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.count <= 0 {
            return url
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        var queryItems = [URLQueryItem]()
        for (key, value) in urlQueryParameters {
            let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(item)
        }
        urlComponents.queryItems = queryItems
        guard let updatedURL = urlComponents.url else { return url }
        return updatedURL
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders["Content-Type"] else { return nil }
        
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters, options: [.prettyPrinted, .sortedKeys])
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethodEnum) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for (header, value) in requestHttpHeaders {
            request.setValue(value, forHTTPHeaderField: header)
        }
        request.httpBody = httpBody
        return request
    }
}

// MARK: - RestManager Custom Types

extension RestManager {    
    enum CustomError: Error {
        case failedToCreateRequest
    }
}


// MARK: - Custom Error Description
extension RestManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
