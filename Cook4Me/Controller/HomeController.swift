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
    
    //MARK:- Properties
    
    private let mapView = MKMapView()
    
    private let ContainerOne = CustomView()
    
    private let ContainerTwo = CustomView(color: .backgroundColor)
    
    private let titlelabel = CustomLabel(title: Constant.HomeLabel, name: Font.Futura, fontSize: 25, color: .white)
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 20000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureUI()
    }
    
    
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
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
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
        
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        ContainerOne.addSubview(mapView)
        mapView.anchor(top: ContainerOne.topAnchor, left: ContainerOne.leftAnchor, bottom: ContainerOne.bottomAnchor, right: ContainerOne.rightAnchor)
        
        ContainerTwo.addSubview(titlelabel)
        titlelabel.anchor(top: ContainerTwo.topAnchor, left: ContainerTwo.leftAnchor, paddingTop: 5, paddingLeft: 10)
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

