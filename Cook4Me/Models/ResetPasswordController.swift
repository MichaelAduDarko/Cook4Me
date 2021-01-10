//
//  ResetPasswordController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/9/21.
//

import UIKit

class RessetPasswordController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = ResetPasswordViewModel()
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "reset"))
    
    private let emailTextfield =  CustomTextField(placeholder: "Email",autoCorrectionType: .no, secureTextEntry: false)
    
    private let resetPasswordButton: CustomButton = {
        let button = CustomButton(title: "Send Reset Link")
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
   
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
    }
    
    
    //MARK:- Selectors
    
    @objc func handleResetPassword(){
        print("link have been sent to your email ")
    }
    
    @objc func handleDismissal(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        } 
        checkFormStatus()
    }
    
    
    func checkFormStatus(){
        if viewModel.formIsValid {
            resetPasswordButton.isEnabled = true
            resetPasswordButton.backgroundColor = .systemPink
        } else {
            resetPasswordButton.isEnabled = false
            resetPasswordButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    //MARK:- Helpers
    
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func configureUI(){
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 120, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 35)
        
        let stackView = UIStackView(arrangedSubviews:[emailTextfield,resetPasswordButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 15,
                         paddingLeft: 30, paddingRight: 30)
        
        
    }
}



