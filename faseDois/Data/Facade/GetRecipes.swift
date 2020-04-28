//
//  GetRecipes.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 19/08/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation
class GetRecipes {
    let recipesService = RecipesService()
    var page = 0
    var nextPage = 1
    var recipes:[Recipe] = []
    
    
    init(){
        
    }
    
    func getMore(completion: @escaping ([Recipe]?, Error?) -> Void) {
        if (page == nextPage){
            return;
        }
        page = nextPage
        recipesService.getRecipes(nextPage) { (recipesResult, error) in
            if let recipes = recipesResult   {
                self.recipes.append(contentsOf: recipes.recipes)
                completion(self.recipes, error)
                self.page = recipes.page
                if (recipes.totalPages > recipes.page ){
                    self.nextPage = self.page + 1
                } else {
                    self.nextPage = self.page
                }
            }
        }
    }
}
