//
//  ApiManager2.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 13.05.2023.
//

import Foundation

// https://api.spoonacular.com/recipes/complexSearch
// API Key: 43f6d16cffc1409c97fbbb9311653c80
enum ApiType {
    case getReceipeForSoup
    case getReceipeForLaunch
    case getReceipeForDessert
    case getMoreInfoAboutReceipt
    
    var baseURL: String {
        switch self {
        case .getReceipeForLaunch:
            return "https://api.spoonacular.com/recipes/"
        case .getReceipeForDessert:
            return "https://api.spoonacular.com/recipes/"
        case .getReceipeForSoup:
            return "https://api.spoonacular.com/recipes/"
        case .getMoreInfoAboutReceipt:
            return "https://api.spoonacular.com/recipes/"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getReceipeForLaunch:
            return ["x-api-key": "43f6d16cffc1409c97fbbb9311653c80", "type": "breakfast", "fillIngredients": "true"]
        case .getReceipeForDessert:
            return ["x-api-key": "43f6d16cffc1409c97fbbb9311653c80", "type": "dessert", "fillIngredients": "true"]
        case .getReceipeForSoup:
            return ["x-api-key": "43f6d16cffc1409c97fbbb9311653c80", "type": "soup", "fillIngredients": "true"]
        case .getMoreInfoAboutReceipt:
            return ["x-api-key": "43f6d16cffc1409c97fbbb9311653c80", "includeNutrition": "true"]
        }
    }
    
    var path: String {
        switch self {
        case .getReceipeForLaunch: return "complexSearch"
        case .getReceipeForDessert: return "complexSearch"
        case .getReceipeForSoup: return "complexSearch"
        case .getMoreInfoAboutReceipt: return "\(ApiManager.shared.id)/information"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .getReceipeForLaunch:
            request.httpMethod = "GET"
            return request
        case .getReceipeForDessert:
            request.httpMethod = "GET"
            return request
        case .getReceipeForSoup:
            request.httpMethod = "GET"
            return request
        case .getMoreInfoAboutReceipt:
            request.httpMethod = "GET"
            return request
        }
    }
}

class ApiManager { // Реализует запросы
    static let shared = ApiManager()
    
    var id = 0
        
    func getReceipeForBreakfast(completion: @escaping (Receipts) -> Void) {
        let request = ApiType.getReceipeForLaunch.request
        let req =  URLRequest(url: URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=43f6d16cffc1409c97fbbb9311653c80&type=breakfast&fillIngredients=true")!)
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            if let data = data, let receipts = try? JSONDecoder().decode(Receipts.self, from: data) {
                completion(receipts)
            } 
        }
        task.resume()
    }
    
    func getReceipeForSoup(completion: @escaping (Receipts) -> Void) {
        //let request = ApiType.getReceipeForSoup.request
        let req = URLRequest(url: URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=43f6d16cffc1409c97fbbb9311653c80&type=soup&fillIngredients=true")!)
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            if let data = data, let receipts = try? JSONDecoder().decode(Receipts.self, from: data) {
                completion(receipts)
            }
        }
        task.resume()
    }
    
    func getReceipeForDeserts(completion: @escaping (Receipts) -> Void) {
        //let request = ApiType.getReceipeForDessert.request
        let req = URLRequest(url: URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=43f6d16cffc1409c97fbbb9311653c80&type=dessert&fillIngredients=true")!)
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            if let data = data, let receipts = try? JSONDecoder().decode(Receipts.self, from: data) {
                completion(receipts)
            }
        }
        task.resume()
    }
    
    func getMoreInfoAboutReceipt(id: Int, completion: @escaping (MoreInfoAboutReceipt) -> Void) {
        self.id = id
        let request = ApiType.getMoreInfoAboutReceipt.request
        //let req = URLRequest(url: URL(string: "https://api.spoonacular.com/recipes/715415/information?apiKey=43f6d16cffc1409c97fbbb9311653c80&includeNutrition=true")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let receipts = try? JSONDecoder().decode(MoreInfoAboutReceipt.self, from: data) {
                print("Data aaa = \(data)")
                    completion(receipts)
            }
        }
        task.resume()
    }
}
