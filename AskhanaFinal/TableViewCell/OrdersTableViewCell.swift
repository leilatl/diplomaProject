//
//  OrdersTableViewCell.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 03.06.2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    var viewModel = OrdersTableViewCellViewModel()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(viewmodel: OrdersTableViewCellViewModel) {
        self.viewModel = viewmodel
        priceLabel.text = String(viewmodel.price) + " тенге"
        bodyLabel.text = viewmodel.body
        dateLabel.text = viewmodel.date
    }

}
class OrdersTableViewCellViewModel {
    var date: String
    var body: String
    var price: Int
    
    init(date: String, body: String, price: Int){
        self.date = date
        self.body = body
        self.price = price
        
    }
    init(){
        date = ""
        body = ""
        price = 0
    }
}
