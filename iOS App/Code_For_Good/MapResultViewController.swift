//
//  MapResultViewController.swift
//  Yelp
//
//  Created by Nicholas Miller.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapResultViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    
    var businesses: [Business]?
    
    var lastSearched: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        
        let centerLocation = CLLocation(latitude: latitude, longitude: longitude)
        goToLocation(centerLocation)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let storedSearch = defaults.objectForKey("storedSearch") as? String {
            lastSearched = storedSearch
        }
        else {
            lastSearched = "Popular"
        }
        
        callYelpAPI(lastSearched!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callYelpAPI(input: String) {
        lastSearched = input
        Business.searchWithTerm(input, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                if (business.address != nil && business.name != nil) {
                    self.addByAddress(business)
                }
            }
        })

        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(input, forKey: "storedSearch")
        defaults.synchronize()
        
        /* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
        self.businesses = businesses
        
        for business in businesses {
        print(business.name!)
        print(business.address!)
        }
        }
        */
    }
    
    func addByAddress(business: Business) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(business.address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if let placemark = (placemarks![0]) as? CLPlacemark {
                
//                var place = MKPlacemark(placemark: placemark)
//                var place2D = CLLocationCoordinate2D.init(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//                self.addAnnotationAtCoordinateCLL("My annotation", place: place2D)
//                
                self.addAnnotationAtCoordinate(business.name!, place: MKPlacemark(placemark: placemark))
            }
        })
    }

    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
            
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
            
//            var place = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
//            addAnnotationAtCoordinateCLL("My annotation", place: place)
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let circleOverlay: MKCircle = MKCircle(centerCoordinate: coordinate, radius: 400)
            mapView.addOverlay(circleOverlay)
        }
    }
    
    func addAnnotationAtCoordinateCLL(name: String, place: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = place
        mapView.addAnnotation(annotation)
    }
    
    func addAnnotationAtCoordinate(name: String, place: MKPlacemark) {
        let placeLat = place.coordinate.latitude
        let placeLong = place.coordinate.longitude
        
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate.latitude = placeLat
        annotation.coordinate.longitude = placeLong
        mapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
        // custom pin annotation
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if (annotation.coordinate.latitude != self.latitude && annotation.coordinate.longitude != self.longitude) {
            if (annotationView == nil) {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            else {
                annotationView!.annotation = annotation
            }
            
            if #available(iOS 9.0, *) {
                annotationView!.pinTintColor = UIColor.redColor()
            } else {
                // Fallback on earlier versions
            }
            
            // annotationView!.image = UIImage(named: "customAnnotationImage")

        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = UIColor.redColor()
        circleView.lineWidth = 1
        return circleView
    }
    
}
