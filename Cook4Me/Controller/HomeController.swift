//
//  HomeController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/25/21.
//

import UIKit
import MapKit

class HomeController: UIViewController {
    
    
    //MARK:- Properties
    
    private let mapView = MKMapView()
    
    private let ContainerOne = CustomView()
    
    private let ContainerTwo = CustomView(color: .backgroundColor)
    
    private let titlelabel = CustomLabel(title: Constant.HomeLabel, name: Font.Futura, fontSize: 30, color: .white)
    
    
    
    //MARK:- Lifecycle
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI(){
        view.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [ContainerOne, ContainerTwo])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        ContainerOne.addSubview(mapView)
        mapView.anchor(top: ContainerOne.topAnchor, left: ContainerOne.leftAnchor, bottom: ContainerOne.bottomAnchor, right: ContainerOne.rightAnchor)
        
        ContainerTwo.addSubview(titlelabel)
        titlelabel.anchor(top: ContainerTwo.topAnchor, left: ContainerTwo.leftAnchor, paddingTop: 5, paddingLeft: 10)
    }
}

