//
//  RegistrationController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/8/21.
//

import UIKit

class RegistrationController: UIViewController, UITextFieldDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Properties
    private var viewModel = RegistrationViewModel()
    
    private let signUpLabel = CustomLabel(title: "Sign Up", name: "Futura-Bold", fontSize: 40, color: .systemPink)
    
    private let emailTextfield =  CustomTextField(placeholder: "Email",autoCorrectionType: .no, secureTextEntry: false)
    
    private let fullNameTextfield =  CustomTextField(placeholder: "FullName",autoCorrectionType: .no, secureTextEntry: false)
    
    private let passwordTextField = CustomTextField (placeholder: "Password", secureTextEntry: true)
    
    private let SignUpButton: CustomButton = {
        let button = CustomButton(title: "Log In")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: "Already have an account?", secondtitle: "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Selectors
    
    @objc func handleSignUp(){
        print("12356830")
    }
    
    @objc func handleShowLogin(){
        //Takes user back to login View after signing up
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Form Validation
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        } else if sender == fullNameTextfield{
            viewModel.fullname = sender.text
        } else {
            viewModel.password = sender.text
        }
       checkFormStatus()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldObservers()
        tapOutsideToDimissKeyboard()
        configureUI()
        emailTextfield.delegate = self
        fullNameTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    /// Checks if form is valid to enable the button for click
    func checkFormStatus(){
        if viewModel.formIsValid {
            SignUpButton.isEnabled = true
            SignUpButton.backgroundColor = .systemPink
        } else {
            SignUpButton.isEnabled = false
            SignUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    
    
    /// Alerts observers when the text in a text field changes
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    private func configureUI(){
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(signUpLabel)
        signUpLabel.anchor(top: view.topAnchor, left: view.leftAnchor,
                           paddingTop: 150, paddingLeft: 30)
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,fullNameTextfield,passwordTextField, SignUpButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        
        view.addSubview(stackView)
        stackView.anchor(top: signUpLabel.bottomAnchor, left: view.leftAnchor,
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
