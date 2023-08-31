//
//  MealDetailViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 25.04.2022.
//

import UIKit

class MealDetailViewController: UIViewController {
    var counter = 0
    
    
    @IBOutlet var labelProteins: UILabel!
    @IBOutlet var labelFats: UILabel!
    @IBOutlet weak var labelCarbs: UILabel!
    
    @IBOutlet weak var proteinLoader: UIView!
    @IBOutlet weak var fatLoader: UIView!
    @IBOutlet weak var carbohydratesLoader: UIView!
    
    @IBOutlet weak var counterCloud: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var proteinLoadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var fatsLoadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var carbohydratesLoadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    var meal: Meal!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelProteins.text = "Белки: \(meal.protein)"
        labelFats.text = "Жиры: \(meal.fats)"
        labelCarbs.text = "Углеводы: \(meal.carbs)"
        //labelDescription.text = meal.description
        labelPrice.text = "\(meal.price)  тенге"
        self.navigationItem.title = meal.name
        
        proteinLoader.layer.cornerRadius = 8
        fatLoader.layer.cornerRadius = 8
        carbohydratesLoader.layer.cornerRadius = 8
        
        proteinLoadingConstraint.constant = 130.0 * (CGFloat(meal.protein) / 100.0)
        fatsLoadingConstraint.constant = 130.0 * (CGFloat(meal.fats) / 100.0)
        carbohydratesLoadingConstraints.constant = 130.0 * (CGFloat(meal.carbs) / 100.0)
        counterCloud.layer.cornerRadius = 14
        
        plusButton.setTitle(nil, for: .normal)
        minusButton.setTitle(nil, for: .normal)
        minusButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    @IBAction func removeOne(_ sender: Any) {
        counter -= 1
        counterLabel.text = String(counter)
    }
    
    @IBAction func addOne(_ sender: Any) {
        counter += 1
        counterLabel.text = String(counter)
    }
    @IBAction func addToCartButton(_ sender: Any) {
        let service = FoodNetworkingService()
        service.addItemToCart(itemID: meal.id, quantity: counter)
    }
}
