//
//  ApiManager.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import Foundation
// https://api.edamam.com/api/recipes/v2?type=public&app_id=fa3279c1&app_key=2f0efe84a8fc56bc5471b12c6ec8bacb&diet=balanced&mealType=Breakfast&imageSize=REGULAR

enum ApiType {
    case getRecipes
    
    
    
    var baseUrl: String {
//        var type = "public"
//        var app_id = "fa3279c1"
//        var app_key = "2f0efe84a8fc56bc5471b12c6ec8bacb"
//        var diet = "balanced"
//        var mealType = "Breakfast"
//        var imageSize = "REGULAR"
        
        return  "https://api.edamam.com/api/recipes/v2?type=public&app_id=fa3279c1&app_key=2f0efe84a8fc56bc5471b12c6ec8bacb&diet=balanced&mealType=Breakfast&imageSize=REGULAR"
        
        
        //"https://api.edamam.com/api/recipes/v2?type=public&app_id=fa3279c1&app_key=2f0efe84a8fc56bc5471b12c6ec8bacb&diet=balanced&mealType=Breakfast&imageSize=REGULAR"
        //return "https://api.edamam.com/api/recipes/v2?type=\(type)&app_id=\(app_id)&app_key=\(app_key)&diet=\(diet)&Breakfast=\(mealType)&imageSize=\(imageSize)"
    }
    
//    var headers: [String: String] {
//
//        switch self {
//        case .get:
//            return ["type": "public", "app_id": "fa3279c1", "app_key": "2f0efe84a8fc56bc5471b12c6ec8bacb", "diet": "balanced", "mealType": "Breakfast", "imageSize": "REGULAR"]
//        }
//
//    }
    
//    var path: String {
//        switch self {
//        case .get: return "type"
//        }
//    }
    
    var url: URL {
        guard let url = URL(string: baseUrl) else { return URL(string: "baseUrl")!}
        
//        var request = URLRequest(url: гкд)
//        //request.allHTTPHeaderFields = headers
//
//        switch self {
//        case .getRecipes:
//            request.httpMethod = "GET"
//            return request
//        }
        return url
    }
}

class ApiManager {
    
    static let shared = ApiManager()
    var model = ModelOfDataForCollectionViewRecipes()
    
    func getInfo(completion: @escaping (Recipes) -> Void) {
        let url = ApiType.getRecipes.url
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            
            do {
                let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                completion(recipes)
            } catch let error {
                print(error)
            }

        }.resume()
    }
}