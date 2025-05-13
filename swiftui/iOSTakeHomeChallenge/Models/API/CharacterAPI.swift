//
//  CharacterAPI.swift
//  iOSTakeHomeChallenge
//
//  Created by Hashim Akhtar on 13/05/2025.
//

import Foundation

class CharacterAPI {
    static func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        var request = URLRequest(url: URL(string: Constants.WEB_SERVER_URL)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            Constants.AUTHORIZATION_HEADER: Constants.AUTHORIZATION_VALUE
        ]
        let task = URLSession(configuration: config)
            .dataTask(with: request, completionHandler: { data, response, error in
                if error != nil {
                    print(error!)
                    completion(nil)
                    return
                }

                let characters = try! JSONDecoder().decode([Character].self, from: data!)
                completion(characters)
            })
        task.resume()
    }
}
