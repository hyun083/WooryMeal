//
//  TableManager.swift
//  wooryMeal
//
//  Created by Hyun on 12/23/24.
//

import Foundation

class TableManager{
    static let shared = TableManager()
    private let serviceURL = "https://meal-api-server.fly.dev"
    
    func fetchMenuData(completion: @escaping (Result<[Table], Error>) -> Void){
        print("fetchMenuData...")
        guard let url = URL(string: serviceURL + "/menu") else{
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print("error")
                completion(.failure(error))
                return
            }
            
            guard let data else{
                print("NoData")
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase     //반환받은 키를 snakeCase 형태로 자동 변환.
                let menus = try decoder.decode([Table].self, from: data)
                completion(.success(menus))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMenuData(on date: String, completion: @escaping (Result<[Table], Error>) -> Void){
        print("fetchMenuData...")
        guard let url = URL(string: serviceURL + "/menu/\(date)") else{
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print("error")
                completion(.failure(error))
                return
            }
            
            guard let data else{
                print("NoData")
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase     //반환받은 키를 snakeCase 형태로 자동 변환.
                let menus = try decoder.decode([Table].self, from: data)
                completion(.success(menus))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
