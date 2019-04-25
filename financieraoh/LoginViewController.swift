//
//  LoginViewController.swift
//  financieraoh
//
//  Created by Alexis Arroyo Diaz on 24/04/19.
//  Copyright © 2019 Alexis Arroyo Diaz. All rights reserved.
//

import Foundation


class LoginViewController : UIViewController  {
    
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnAcceder: UIButton!
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.addSubview(loginButton)
        //loginButton.center = view.center
        //loginButton.contentVerticalAlignment = view. //UIControlContentVerticalAlignment.bottom
        
        setupSubViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupSubViews(){
        txtPassword.isSecureTextEntry = true
    }
    
    
}
