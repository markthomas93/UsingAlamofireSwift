//
//  RecipeItemViewController.swift
//  zaffaripoc
//
//  Created by Leonardo Malheiros de Mello on 17/12/19.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.


import UIKit
import Foundation

class RecipeItemViewController : UIViewController{

    var recipes: [Recipe] = []
    private var tableView = UITableView()
    let getRecipes = RecipesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib.init(nibName: "RecipleCellItem", bundle: nil), forCellReuseIdentifier: "RecipleCellItem")
           tableView.register(UINib.init(nibName: "RecipeItem", bundle: nil), forCellReuseIdentifier: "RecipeItem")
    }

   required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  
    }

    override func viewWillLayoutSubviews() {

      
        

    }
  
    
    
        @objc func selectorX() { }




//
//        print ( cell )
//              print(path.row)
//              print(recipes[path.row])
//
//    if (cell.getTitle() == recipes[path.row].title){ self.navigationItem.title = "a"}
//    Titulo.getTitle()
//    navigationItem.title = recipes[path.row].title
//    titulo = "\(cell.textLabel?.text)"
//    titulo = "\(cell.textLabel?.text)"






    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }


 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {

           let cell = tableView.dequeueReusableCell(withIdentifier: "RecipleCellItem", for: indexPath) as! RecipeCellItem
           cell.setTitle(recipes[indexPath.row].title)
           if (cell.getTitle() == recipes[indexPath.row].title){ cell.setClassification("1")}
           cell.setClassification(recipes[indexPath.row].classification)
           cell.setBackgroundImage(recipes[indexPath.row].image)
           cell.setClassification(recipes[indexPath.row].classification)
           cell.title = "Section \(indexPath.section) Row \(indexPath.row)"



  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

     let cell = tableView.cellForRow(at: indexPath) as! YourCellType
     let labelContent = cell.labelToAccess.text
 }
    */



}
