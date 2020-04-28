//
//  RecipesViewController.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 27/08/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

@objc class RecipesViewController: UITableViewController{
    
    var recipes: [Recipe] = []
    let getRecipes = GetRecipes.init()
                
        @IBAction func RecipeItem(_ sender: UIButton!) {
           let storyBoard : UIStoryboard = UIStoryboard(name: "RecipeItemViewController", bundle:nil)
                                  let next = storyBoard.instantiateViewController(withIdentifier: "RecipeItemViewController")
                                  present(next, animated: true, completion: nil)
            }
    
   
        override func viewDidLoad() {
        super.viewDidLoad()
         getRecipes.getMore(){(recipesResult, error) in
            self.updateView(recipes:recipesResult, error:error)
            
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.register(UINib.init(nibName: "RecipleCellItem", bundle: nil), forCellReuseIdentifier: "RecipleCellItem")
        tableView.rowHeight =  tableView.frame.width * 0.6
        tableView.register(UINib.init(nibName: "RecipeItemViewController", bundle: nil), forCellReuseIdentifier: "RecipeItemViewController")
            tableView.register(UINib.init(nibName: "RecipeItem", bundle: nil), forCellReuseIdentifier: "RecipeItem")
    }

    
    @IBAction func toggleMenu(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(SWRevealViewController.revealToggle(_:)), to: self.revealViewController(), from: self, for: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //Access the array that you have used to fill the tableViewCell
        print(recipes[indexPath.row])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        if indexPath.row == recipes.count - 1 {
            getRecipes.getMore(){(recipesResult, error) in
                self.updateView(recipes:recipesResult, error:error)
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipleCellItem", for: indexPath) as! RecipeCellItem
        cell.setTitle(recipes[indexPath.row].title)
        if (cell.getTitle() == recipes[indexPath.row].title){ cell.setClassification("1")}
        cell.setClassification(recipes[indexPath.row].classification)
        cell.setBackgroundImage(recipes[indexPath.row].image)
        cell.setClassification(recipes[indexPath.row].classification)
        //cell.title = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    
   
    
    func updateView(recipes:[Recipe]?, error:Error?) {
        if let anyError = error{
            print(anyError)
            return
            //TODO SHOW ERROR
        }
        if let tableViewRecipes = recipes{
            updateTableViewContent(recipes: tableViewRecipes)
        }
    }
    
    func updateTableViewContent(recipes:[Recipe]) {
        self.recipes = recipes
        DispatchQueue.main.async {    // tell the table view to update (at all of the inserted index paths)
           //self.tableView.beginUpdates()
            self.tableView.reloadData()
          //  self.tableView.insertRows(at: indexPaths as [IndexPath], with: .bottom)
         // self.tableView.endUpdates()
        }
        //self.refresher.endRefreshing()
    }
    
}


// -MARK: FUNCAO PARA ACESSAR SITE NO BOTAO XIB

/*   func showSafari(for url: String){
       guard let url = URL(string: url) else {
           return
       }
       let safariVC = SFSafariViewController( url: url)
       safariVC.present(safariVC, animated : true)
   }
   
   */
