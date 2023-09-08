//
//  objectTrail.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 9/7/23.
//

import UIKit
import CoreLocation

class objectTrail: NSObject {
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var page: String
    var desc: String
    var image: UIImage
    
    init(name:String, latitude:CLLocationDegrees, longitude:CLLocationDegrees, page:String, desc:String, image:UIImage){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.page = page
        self.desc = desc
        self.image = image
    }
    
    
                                   
    func getName() -> String {
        return self.name
    }
    func getLatitude() -> CLLocationDegrees {
        return self.latitude
    }
    func getLongitutde() -> CLLocationDegrees {
        return self.longitude
    }
    func getPage() -> String {
        return self.page
    }
    func getDescription() -> String {
        return self.desc
    }
    func getImage() -> UIImage {
        return self.image
    }
    
}
