//
//  FoodDetailTableViewCell.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 25.04.2022.
//

import UIKit
class FoodDetailTableViewCellViewModel {
    var name: String
    var description: String
    var weight: Int
    var price: Int
    var counter = 0
    var itemID = 0
    var available: Bool
    
    
    init(name: String, description: String, weight: Int, price: Int, itemID: Int, available: Bool) {
        self.name = name
        self.description = description
        self.weight = weight
        self.price = price
        self.itemID = itemID
        self.available = available
    }
    
    init() {
        name = ""
        description = ""
        weight = 0
        price = 0
        available = true
    }
}

class FoodDetailTableViewCell: UITableViewCell {
    var viewModel = FoodDetailTableViewCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var cartLbelOutlet: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var cartButtonOutlet: UIButton!
    @IBOutlet weak var plusBtnImage: UIImageView!
    @IBOutlet weak var plusBtnOutlet: UIButton!
    @IBOutlet weak var minusBtnOutletReal: UIButton!
    @IBOutlet weak var minusBtnOutlet: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusPressed(_ sender: Any) {
        quantityLabel.text = String(Int(quantityLabel.text!)!+1)
    }
    @IBAction func minusPressed(_ sender: Any) {
        if quantityLabel.text != "0"{
            quantityLabel.text = String(Int(quantityLabel.text!)!-1)
        }else{
            
        }
        
    }
    @IBAction func addToCart(_ sender: Any) {
        let service = FoodNetworkingService()
        let quantity = Int(quantityLabel.text!)!
        service.addItemToCart(itemID: viewModel.itemID, quantity: quantity)
        cartButtonOutlet.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 9)
    }
    
    func configure(viewmodel: FoodDetailTableViewCellViewModel) {
        self.viewModel = viewmodel
        foodNameLabel.text = viewmodel.name
        foodDescriptionLabel.text = viewmodel.description
        //weightLabel.text = "\(viewmodel.weight) грамм"
        priceLabel.text = "\(viewmodel.price) тенге"
        quantityLabel.text = String(viewmodel.counter)
        cartButtonOutlet.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 9)
        if !viewmodel.available {
            foodNameLabel.textColor = UIColor(named: "Grey")
            foodDescriptionLabel.textColor = UIColor(named: "Grey")
            priceLabel.textColor = UIColor(named: "Grey")
            quantityLabel.textColor = UIColor(named: "Grey")
            cartLbelOutlet.alpha = 0
            cartButtonOutlet.alpha = 0
            
            plusBtnOutlet.alpha = 0
            minusBtnOutletReal.alpha = 0
            
            
        }else{
            
        }
        
    }
    
}
