import UIKit
import CoreLocation

class sosController: UIViewController, CLLocationManagerDelegate {
    
    static var currentLocation: String = ""
    var manager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else {
            return
        }
        sosController.currentLocation = "\(first.coordinate.longitude) | \(first.coordinate.latitude)"
    }
}
