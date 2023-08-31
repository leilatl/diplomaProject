//
//  CartViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 01.06.2022.
//

import UIKit

class CartViewController: UIViewController {
    let service = FoodNetworkingService()
    var cart: [ShowCartItems] = []
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        service.getCartItems(){ [weak self] cartItems in
            DispatchQueue.main.async {
                self?.cart = cartItems.cart_items
                
                self?.tableView.reloadData()
                
                self?.itemsCountLabel.text = "Продуктов из столовой: "+String((self?.countItems())!)
                self?.priceLabel.text = "ИТОГО: "+String((self?.countPrice())!)
            }
            
        }
    
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        let service = FoodNetworkingService()
        service.postOrder()
        var dialogMessage = UIAlertController(title: "Оплата прошла успешно", message: "Заказ будет ждать в столовой", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        service.getCartItems(){ [weak self] cartItems in
            DispatchQueue.main.async {
                self?.cart = cartItems.cart_items
                print(cartItems.cart_items)
                print(cartItems)
                self?.tableView.reloadData()
                
                self?.itemsCountLabel.text = "Продуктов из столовой: "+String((self?.countItems())!)
                self?.priceLabel.text = "ИТОГО: "+String((self?.countPrice())!)
            }
            
        }
        
    }
    func countItems()->Int{
        var count = 0
        for each in cart{
            count = count + each.quantity
        }
        return count
    }
    func countPrice()->Int{
        var count = 0
        for each in cart{
            count = count + (each.meals.price*each.quantity)
        }
        return count
    }
}


extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell",
                                                 for: indexPath) as! CartTableViewCell
        let cartItem = cart[indexPath.row]
       
        let viewmodel = CartTableViewCellViewModel(name: cartItem.meals.name, quantity: cartItem.quantity, price: cartItem.meals.price, itemID: cartItem.id)
        cell.configure(viewmodel: viewmodel)
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let service = FoodNetworkingService()
            service.deleteCartItem(id: cart[indexPath.row].meals.id)
            cart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.itemsCountLabel.text = "Продуктов из столовой: "+String((self.countItems()))
            self.priceLabel.text = "ИТОГО: "+String((self.countPrice()))
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
