//
//  LoginController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/8/21.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Properties
    private var viewModel = LoginViewModel()

    private let titlelabel = CustomLabel(title: "Welcome\nTo\nCook4Me", name: "Futura-Bold", fontSize: 35, color: .white)
    
    private let signInLabel = CustomLabel(title: "Sign In", name: "Futura-Bold", fontSize: 35, color: .systemPink)
    
    
    private let emailTextfield =  CustomTextField(placeholder: "Email",autoCorrectionType: .no, secureTextEntry: false)
    
    private let passwordTextField = CustomTextField(placeholder: "Password", secureTextEntry: true)
    
    private let loginButton: CustomButton = {
        let button = CustomButton(title: "Log In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: "Don't have an account?", secondtitle: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK:- Selectors
    @objc func handleLogin(){
     print("12334")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func handleShowSignUp(){
        
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
        tapOutsideToDimissKeyboard()
        emailTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK:- Helpers
    
    func checkFormStatus(){
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    
    
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    private func configureUI(){
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 40, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(signInLabel)
        signInLabel.anchor(top: titlelabel.bottomAnchor,left: view.leftAnchor,
                           paddingTop: 100, paddingLeft: 30)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,passwordTextField, loginButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        
        view.addSubview(stackView)
        stackView.anchor(top: signInLabel.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 20,
                         paddingLeft: 30, paddingRight: 30)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func tapOutsideToDimissKeyboard(){
        let tapOutside: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
