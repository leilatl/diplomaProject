//
//  CartTableViewCell.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 01.06.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    var viewModel = CartTableViewCellViewModel()

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func configure(viewmodel: CartTableViewCellViewModel) {
        self.viewModel = viewmodel
        priceLabel.text = String(viewmodel.quantity) + " * " + String(viewmodel.price) + "тенге"
        itemNameLabel.text = viewmodel.name
    }

}

class CartTableViewCellViewModel {
    var name: String
    var quantity: Int
    var price: Int
    var itemID: Int
    
    init(name: String, quantity: Int, price: Int, itemID: Int){
        self.name = name
        self.quantity = quantity
        self.price = price
        self.itemID = itemID
    }
    init(){
        name = ""
        quantity = 0
        price = 0
        itemID = 0
    }
}
