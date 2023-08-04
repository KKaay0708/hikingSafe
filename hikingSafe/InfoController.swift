//
//  InfoController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/3/23.
//

import Foundation
import Firebase

class InfoController {
    
    static func getDatabaseInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref =  Database.database().reference()
        let defaults = UserDefaults.standard
        
        for i in 0...4 {
            ref.child("trail\(OnboardingViewController().getCurrentPage())").child("animals").child("animal\(i)").observe(.value, with: { snapshot in
                
                var animalLabel = "animal\(i)Label"
                var imageLabel = "animal\(i)Image"
                
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    animalLabel = dictionary["a\(i)Label"] as! String
                    imageLabel = dictionary["a\(i)Danger"] as! String

                    defaults.set(animalLabel, forKey: "animal\(i)LabelKey")
                    defaults.set(imageLabel, forKey: "animal\(i)DangerKey")
                    onSuccess()
                }
            }) { (error) in
                onError(error)
            }
        }
    }
}
