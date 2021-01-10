//
//  LoginController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/8/21.
//

import UIKit
import Lottie

class LoginController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Properties
    private let animationView = AnimationView()
    
    private var viewModel = LoginViewModel()

    private let titlelabel = CustomLabel(title: "Welcome\nTo\nCook4Me", name: "Futura-Bold", fontSize: 30, color: .white)
    
    private let logInLabel = CustomLabel(title: "Log In", name: "Futura-Bold", fontSize: 25, color: .systemPink)
    
    
    private let emailTextfield =  CustomTextField(placeholder: "Email",autoCorrectionType: .no, secureTextEntry: false)
    
    private let passwordTextField = CustomTextField(placeholder: "Password", secureTextEntry: true)
    
    private let loginButton: CustomButton = {
        let button = CustomButton(title: "Log In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: "Forgot your password?", secondtitle: "Reset")
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: "Don't have an account?", secondtitle: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let dividerView = DividerView()
    
    //MARK:- Selectors
    @objc func handleLogin(){
     print("12334")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleForgotPassword(){
     
        print("Forgot password button tapped")
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
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.play()
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
        
        animationView.animation = Animation.named("cooker")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.8
        animationView.play()
        
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(animationView)
        animationView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left:  view.leftAnchor, right:  view.rightAnchor,
                             paddingRight: -250, width: 200, height: 200)
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(logInLabel)
        logInLabel.anchor(top: titlelabel.bottomAnchor,left: view.leftAnchor,
                           paddingTop: 70, paddingLeft: 30)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,passwordTextField, loginButton, forgotPasswordButton, dividerView])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
        stackView.anchor(top: logInLabel.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 15,
                         paddingLeft: 30, paddingRight: 30)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    ///Tap outside to dimiss keyboard
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
