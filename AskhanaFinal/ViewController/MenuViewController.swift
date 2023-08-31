//
//  MenuViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 25.04.2022.
//

import Foundation
import UIKit


class MenuViewController: UIViewController{
    @IBOutlet weak var btnZavtrak: UIButton!
    @IBOutlet weak var btnFirstMeal: UIButton!
    @IBOutlet weak var buttonSecondMeal: UIButton!
    @IBOutlet weak var buttonSalads: UIButton!
    @IBOutlet weak var buttonDessrets: UIButton!
    @IBOutlet weak var buttonDrinks: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(btnZavtrak)
        view.bringSubviewToFront(btnFirstMeal)
        view.bringSubviewToFront(buttonSecondMeal)
        view.bringSubviewToFront(buttonDessrets)
        view.bringSubviewToFront(buttonSalads)
        view.bringSubviewToFront(buttonDrinks)
    }
    
    @IBAction func didSelectDishType(_ sender: UIButton) {
        performSegue(withIdentifier: "showMenuDetails", sender: sender)
        
    }
    
    func buttonToMessage(button: UIButton) -> String {
        var message = ""
        switch button {
        case btnZavtrak:
            message = "zavtrak"
        case btnFirstMeal:
            message = "pervoe"
        case buttonSecondMeal:
            message = "vtoroe"
        case buttonSalads:
            message = "salat"
        case buttonDessrets:
            message = "desert"
        case buttonDrinks:
            message = "napitki"
        default:
            break
        }
        return message
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? FoodDetailViewController,
            let button = sender as? UIButton else {
            return
        }
        
        vc.message = buttonToMessage(button: button)
        
        
    }
    
}
