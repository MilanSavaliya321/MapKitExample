//
//  ViewController.swift
//  MapKitDemo
//
//  Created by PC on 17/08/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        requestLocationServiceAccess()
    }
    
    private func requestLocationServiceAccess() {
        LocationHelper.shared.requestLocationServiceIfNeed(force: false) { (haspermission) in
            if !haspermission {
                DispatchQueue.main.async {
                    Utility.showAlertForAppSettings(title: "Need to access Location service", message: "Turn on Location services on your device.", allowCancel: true) { (completed) in
                    }
                    return
                }
            } else {
                self.addLocation()
            }
        }
    }
    
    private func addLocation() {
        LocationHelper.shared.startLocationUpdate { letlong, error in
            if error == nil {
                let cordinate = CLLocation(latitude: letlong!.latitude, longitude: letlong!.longitude)
                LocationHelper.shared.getFullAddress(location: cordinate) { address in
                    self.updateLocationOnMap(to: cordinate, with: "Address", with: address)
                }
                LocationHelper.shared.stopLocationUpdate()
            }
        }
    }
    
    // MARK: - Functions
    func updateLocationOnMap(to location: CLLocation, with title: String?, with subTitle: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.subtitle = subTitle
        point.coordinate = location.coordinate
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "SomeCustomIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            
            // Resize image
            let pinImage = UIImage(named: "ic_map_pin")
            let size = CGSize(width: 20, height: 27)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            annotationView?.image = resizedImage
            
            let rightButton: AnyObject! = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
}
