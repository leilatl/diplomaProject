//
//  ProfileViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 02.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let service = FoodNetworkingService()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getProfile(){ [weak self] user in
            DispatchQueue.main.async {
                self?.nameLabel.text = user.first_name + " " + user.last_name
                self?.emailLabel.text = user.email
                self?.phoneLabel.text = "Номер телефона: \n"+user.phone
                self?.balanceLabel.text = "Баланс: " + String(user.balance) + " тенге"
             
            }
            
        }

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        service.getProfile(){ [weak self] user in
            DispatchQueue.main.async {
                self?.nameLabel.text = user.first_name + " " + user.last_name
                self?.emailLabel.text = user.email
                self?.phoneLabel.text = "Номер телефона: \n"+user.phone
                self?.balanceLabel.text = "Баланс: " + String(user.balance) + " тенге"
             
            }
            
        }
    }
    
    
    @IBAction func balanceButton(_ sender: Any) {
        var dialogMessage = UIAlertController(title: "Пополнение баланса", message: "Сделайте перевод на каспи счет: +7(777)777-77-77.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        guard let vc = self.presentingViewController else { return }

           while (vc.presentingViewController != nil) {
               vc.dismiss(animated: true, completion: nil)
           }
    }
    
   

}
