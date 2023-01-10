//
//  ApiManager.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import CoreData

enum ApiType {
    case getRecipes
    
    var baseUrl: String {
        return  "https://api.edamam.com/api/recipes/v2?type=public&app_id=fa3279c1&app_key=2f0efe84a8fc56bc5471b12c6ec8bacb&diet=balanced&mealType=Breakfast&imageSize=REGULAR"
    }
    
    var url: URL {
        guard let url = URL(string: baseUrl) else { return URL(string: "baseUrl")!}
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
