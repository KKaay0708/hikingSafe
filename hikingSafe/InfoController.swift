//
//  InfoController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/3/23.
//

import Foundation
import Firebase

class InfoController {
    static func getAnimalDatabaseInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref =  Database.database().reference()
        let defaults = UserDefaults.standard
        for i in 0...4 {
            ref.child("trail\(String(OnboardingViewController().currentPages))").child("animals").child("animal\(i)").observe(.value, with: { snapshot in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    let animalLabel = dictionary["label"] as! String
                    let imageLabel = dictionary["danger"] as! Bool
                    
                    defaults.set(animalLabel, forKey: "animal\(i)LabelKey")
                    defaults.set(imageLabel, forKey: "animal\(i)DangerKey")
                    onSuccess()
                }
            }) { (error) in
                onError(error)
            }
        }
    }
    
    static func getPlantDatabaseInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref =  Database.database().reference()
        let defaults = UserDefaults.standard
        
        for i in 0...4 {
            ref.child("trail\(String(OnboardingViewController().getCurrentPage()))").child("plants").child("plant\(i)").observe(.value, with: { snapshot in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    let animalLabel = dictionary["label"] as! String
                    let imageLabel = dictionary["danger"] as! Bool
                    
                    defaults.set(animalLabel, forKey: "plant\(i)LabelKey")
                    defaults.set(imageLabel, forKey: "plant\(i)DangerKey")
                    onSuccess()
                }
            }) { (error) in
                onError(error)
            }
        }
    }
}
