//
//  FoodDetailViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 25.04.2022.
//

import UIKit

class FoodDetailViewController: UIViewController {
    var currentSelected = 0
    @IBOutlet weak var searchButtonOutlet: UIButton!
    let service = FoodNetworkingService()
    var meals: [Meal] = []
    var categories = ["завтраки", "первое", "второе", "салаты", "выпечка", "напитки"]
    var urls = ["zavtrak", "pervoe", "vtoroe", "salat", "vipechka", "napitki"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        //registerNib()

       
        tableView.dataSource = self
        tableView.delegate = self
        service.getMeals(category: urls[currentSelected]) { [weak self] apiMeals in
            DispatchQueue.main.async {
                self?.meals = apiMeals
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchTF: UITextField!
    @IBAction func searchPressed(_ sender: Any) {
        if searchTF.text != ""{
            let query = searchTF.text
            print(query!)
            service.searchMeals(query: query!){
                [weak self] searchData in
                    DispatchQueue.main.async {
                        self?.meals = searchData
                        self?.tableView.reloadData()
                    }
            }
            
        }else{
            print("no text")
            
        }
        
        
    }
    func registerNib() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
}
extension FoodDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelected = indexPath.row
        service.getMeals(category: urls[currentSelected]) { [weak self] apiMeals in
            DispatchQueue.main.async {
                self?.meals = apiMeals
                self?.tableView.reloadData()
            }
        }
        collectionView.reloadData()
    }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell",
                                                             for: indexPath) as? CategoryCollectionViewCell {
                let name = categories[indexPath.row]
                cell.configureCell(category: name)
                if currentSelected == indexPath.row{
                    cell.cellSelected()
                }else{
                    cell.cellUnselected()
                }
                return cell
            }
            return UICollectionViewCell()
        }
    

    
}

extension FoodDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodDetailTableViewCell",
                                                 for: indexPath) as! FoodDetailTableViewCell
        let meal = meals[indexPath.row]
        var availability = true
        if meal.available_inventory == 0{
            availability = false
        }
        let viemodel = FoodDetailTableViewCellViewModel(name: meal.name,description: meal.description, weight: 0, price: meal.price, itemID: meal.id, available: availability)
        cell.configure(viewmodel: viemodel)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = meals[indexPath.row]
        performSegue(withIdentifier: "showMealDeatails", sender: meal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MealDetailViewController,
            let meal = sender as? Meal else {
            return
        }
        vc.meal = meal
    
    }
    
}

class FoodGroup{
    var name: String = ""
    var url: String
    init(){
        self.name = ""
        self.url = ""
    }
}
