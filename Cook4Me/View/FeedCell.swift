//
//  FeedCell.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/27/21.
//

import UIKit

struct categoryData {
    let image: UIImage
    let name : String?
}

class FeedCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    private let gradient = CAGradientLayer()
    
    let feedImageView : UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.layer.cornerRadius = 12
            return iv
            
        }()
    
//    let categoryIVLabel = CustomLabel(title: "Name", name: Font.Futura, fontSize: 20, color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    
    let categoryIVLabel: CustomLabel = {
        let label = CustomLabel(title: "", name: Font.Futura, fontSize: 25, color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        label.numberOfLines = 2
        label.backgroundColor = .backgroundColor
        return label
    }()
    
    
    
    //Mark: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setCellShadow()
       
    }
    
    
    func setCellShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 5
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 20
    }
    
    func setUp(){

        addSubview(feedImageView)
        feedImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        

        
        addSubview(categoryIVLabel)
        categoryIVLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 10)

    }
    
    
    var data: categoryData? {
        didSet {
            guard  let data = data else {return}
            feedImageView
                .image = data.image
            categoryIVLabel.text = data.name
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
