//
//  CustomDontHaveAccountButton.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/8/21.
//

import UIKit

class CustomDontHaveAccountButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, secondtitle: String) {
        super.init(frame: .zero)

        let attributedTitle = NSMutableAttributedString(string: title,
                                                        attributes: [ .font: UIFont.systemFont(ofSize: 20),.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondtitle,
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 20),.foregroundColor: UIColor.systemPink]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
