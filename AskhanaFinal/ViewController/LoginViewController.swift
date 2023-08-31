//
//  ViewController.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 24.04.2022.
//

import UIKit
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

    @IBOutlet weak var registrationBtnOutlet: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        registrationBtnOutlet.layer.opacity = 0.56
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if emailTextField.hasText && passwordTextField.hasText{
            let email = emailTextField.text
            let password = passwordTextField.text!
            
            let url = URL(string: "https://ashana-app-dproj.herokuapp.com/login")
            guard let requestURL = url else {fatalError()}
            var request = URLRequest(url: requestURL)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            let credentials = LogInCredentials(email: email!, password: password)
            let jsonData = try! JSONEncoder().encode(credentials)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    //status = false
                    //self.errorLabel.text = "email или пароль не подходят"
                    return
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8){
                    print("Response: \n \(dataString)")
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = json{
                            if let accessToken = parseJSON["access_token"] as? String{
                                let tokenType = parseJSON["token_type"] as? String
                                print(accessToken)
                                //print(tokenType!)
                                //status = true
                                DispatchQueue.main.async {
                                    let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! TabController
                                     tabController.modalPresentationStyle = .fullScreen
                                    self.present(tabController, animated: true)
                                }
                                
                                
                                let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken, forKey: "access_token")
                                let saveTokenType: Bool = KeychainWrapper.standard.set(tokenType!, forKey: "token_type")
                            }
                            
                        }else{
                            print("ERRORRR")
                            self.errorLabel.text = "email или пароль не подходят"
                            //status = false
                        }
                    }catch{
                        
                    }
                    
                    
                }
                    
                
            }
            task.resume()
            
        }else{
            errorLabel.text = "Введите email и пароль"
        }
        
        
        
        
    }
    @IBAction func registerPressed(_ sender: Any) {
        
    }
    

}

