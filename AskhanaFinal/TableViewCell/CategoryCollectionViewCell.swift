//
//  CategoryCollectionViewCell.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 03.06.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var labelOutlet: UILabel!
    func configureCell(category: String) {
        self.labelOutlet.text = category
        self.viewOutlet.layer.cornerRadius = 20
    }
    func cellSelected(){
        self.viewOutlet.backgroundColor = UIColor(named: "Yellow")
        self.labelOutlet.textColor = UIColor(named: "White")
    }
    func cellUnselected(){
        self.viewOutlet.backgroundColor = UIColor(named: "Unselected")
        self.labelOutlet.textColor = UIColor(named: "Yellow")
    }

}
