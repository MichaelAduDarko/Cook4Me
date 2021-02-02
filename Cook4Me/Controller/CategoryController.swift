//
//  CategoryController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/31/21.
//

import UIKit


class CategoryController: UIViewController {
    
    lazy var data: [categoryData] = ExampleData.data
    
    //Mark:- Properties
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .backgroundColor
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    override func viewDidLoad() {
        configureCategoryVC()
        searchController()
        view.addSubview(collectionView)
        
        configureNavigationBar(withTitle: "Categories", prefersLargeTitles: true)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func configureCategoryVC(){
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationController?.navigationBar.backgroundColor = .black
    }
    
    private func searchController(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension CategoryController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 20
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.data = data[indexPath.item]
        return cell
    }
}




