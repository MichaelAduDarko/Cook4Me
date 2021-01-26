//
//  MainTabController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/21/21.
//

import UIKit


class MainTabController: UITabBarController {
    
    
    //MARK:- Properties
    
    
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //MARK:- Selectors
    
    
    
    
    
    
    //MARK:- ConfigureUI
    
    
    private func configureUI(){
        
        let home = HomeController()
        home.tabBarItem.image = #imageLiteral(resourceName: "Home")
        
        let post = PostController()
        post.tabBarItem.image = #imageLiteral(resourceName: "icons8-plus-50")
        
        let profile = ProfileController()
        profile.tabBarItem.image = #imageLiteral(resourceName: "icons8-account-50")
        
        
        viewControllers = [home, post, profile]
        
        guard  let items = tabBar.items else { return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        }
        
      
        
    }
    
}
