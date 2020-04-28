//
//  RecipesService.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 26/07/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation

class RecipesService{
    let rest = RestManager()

    func getRecipes(_ page : Int = 1 , completion: @escaping (_ result: RecipesResult?, _ error: Error?) -> Void) {
        guard let url = URL(string: "http://www2.zaffari.com.br/ZFRest/ReceitasJson.php") else { return }
        rest.requestHttpHeaders["Authorization"] = "Basic WkZSZWNlaXRhczpaRkAyMDE4"
        rest.urlQueryParameters["CurrentPage"] = "\(page)"
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            let error = results.error
            print("\n\nResponse HTTP Headers:\n")
            if let response = results.response {
                for (key, value) in response.headers {
                    print("\(key):", value)
                }
            }
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Formatter.ZaffariDataFormat)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userData = try! decoder.decode(RecipesResult.self, from: data)
                completion(userData, error)
                print(userData.description)
            }
        }
    }
    
    
}
