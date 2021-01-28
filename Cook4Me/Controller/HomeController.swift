//
//  HomeController.swift
//  Cook4Me
//
//  Created by MICHAEL ADU DARKO on 1/25/21.
//

import UIKit
import MapKit
import CoreLocation

class HomeController: UIViewController {
    
    
lazy var data: [categoryData] = ExampleData.data
    
    //MARK:- Properties
    
    private let mapView = MKMapView()
    
    private let ContainerOne = CustomView()
    
    private let ContainerTwo = CustomView(color: .backgroundColor)
    
    private let titlelabel = CustomLabel(title: Constant.HomeLabel, name: Font.Futura, fontSize: 25, color: .white)
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    fileprivate let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .backgroundColor
        cv.register(FeedCell.self, forCellWithReuseIdentifier: Cell.CellID) 
        return cv
    }()
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureUI()
    }
    
    //MARK:- Helpers
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied, .restricted:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func configureUI(){
        mapView.userTrackingMode = .follow
        let stackView = UIStackView(arrangedSubviews: [ContainerOne, ContainerTwo])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        ContainerOne.addSubview(mapView)
        mapView.anchor(top: ContainerOne.topAnchor, left: ContainerOne.leftAnchor, bottom: ContainerOne.bottomAnchor, right: ContainerOne.rightAnchor)
        
        ContainerTwo.addSubview(titlelabel)
        titlelabel.anchor(top: ContainerTwo.topAnchor, left: ContainerTwo.leftAnchor, paddingTop: 5, paddingLeft: 10)
        
        ContainerTwo.addSubview(feedCollectionView)
        feedCollectionView.anchor(top: titlelabel.bottomAnchor, left: ContainerTwo.leftAnchor, bottom: ContainerTwo.safeAreaLayoutGuide.bottomAnchor, right: ContainerTwo.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
    }

}




//MARK:- Extension

extension HomeController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}



extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 0 , bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        cell.data = data[indexPath.item]
        return cell
    }
}


