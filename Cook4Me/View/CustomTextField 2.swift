//
//  CustomTextField.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/8/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, autoCorrectionType: UITextAutocorrectionType = .default, secureTextEntry:Bool) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 12).isActive = true
        leftView = spacer
        leftViewMode = .always
        layer.cornerRadius = 15.0
        layer.shadowRadius = 15
        layer.borderWidth = 3
        layer.masksToBounds = true
        borderStyle = .none
        layer.borderColor = #colorLiteral(red: 0.2213829578, green: 0.6727860964, blue: 0.9729384217, alpha: 1)
        textColor = .white
        isSecureTextEntry = secureTextEntry
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 1.9)])
        autocorrectionType = autoCorrectionType
        textContentType = .oneTimeCode
        
        checkIfAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

