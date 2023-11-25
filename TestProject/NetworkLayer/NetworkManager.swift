//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
#warning("დავამატე static. Singleton დიზაინ პატერნში გვინდა, რომ კონკრეტული კლასის ერთი ინსტანსი გვქონდეს. static ქივორდის დახმარებით კი მხოლოდ ერთი ინსტანსი გვაქვს. ინიტიც უნდა იყოს private")
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
#warning("უნდა ჩავწეროთ url")
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
#warning("DispatchQueue.main.async წავშალე, ოღონდ არ ვარ დარწმუნებული რამდენად სწორია")
                
                completion(.failure(error))
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
#warning("აქ სჯობს, რომ გვქონდეს DispatchQueue და აქედანვე გავუშვათ მეინ სრედზე. კონტროლერში აღარ მოგვიწევს დახატვის ლოგიკების წერა.")
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
#warning("resume-ის დაწერა გვჭირდება, რომ თასქი დაიწყოს.")
    }
}


