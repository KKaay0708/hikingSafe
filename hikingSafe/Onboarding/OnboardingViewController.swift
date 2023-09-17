//
//  OnboardingViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/1/23.
//

import UIKit
import MapKit
import Firebase


class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentPageLabel: UILabel!
    
    var slides: [OnboardingSlide] = []
    
    static var pagee: Int = 0
    
    //descriptions from national park service and department of land and natural resources
    
    let trail0 = objectTrail(name: "Yosemite National Park", latitude: 37.86911286093985, longitude: -119.53606438981882, page: "0", desc: "The park is noted for its outstanding scenery—including peaks, canyons, cliffs, domes, rivers, lakes, immense waterfalls, lush green meadows, wildlife, and forests.", image: #imageLiteral(resourceName: "yosemite"), length: 10.0, clothes: "Waterproof Jacket\nLong Sleeve Shirt\nT-Shirt")
    let trail1 = objectTrail(name: "Appalachain Trail", latitude: 42.289580011600975, longitude: -73.15701486156591, page: "1", desc: "The Appalachian Trail is a 2,190+ mile long public footpath that traverses the scenic, wooded, pastoral, wild, and culturally resonant lands of the Appalachian Mountains.", image: #imageLiteral(resourceName: "appalachain"), length: 8.0, clothes: "Light Puffy Jacket\nRaingear\nHiking Shoes\nSocks")
    let trail2 = objectTrail(name: "Burroughs Mountain Trail", latitude: 46.905987670323675, longitude: -121.68963696130662, page: "2", desc: "Traveling in a clockwise direction, the trail passes Shadow Lake on a level grade then climbs sharply to an overlook on the White River and Emmons Glacier. Beyond the overlook the route continues up and onto the wide, flat plateau of First Burroughs Mountain.", image: #imageLiteral(resourceName: "burroughs"), length: 4.0, clothes: "Soft Jacket\nPuffy Jacket\nHiking Shorts\n Winter Hat\nGloves")
    let trail3 = objectTrail(name: "Kalalau Trail", latitude: 22.19609578950994, longitude: -159.62040994889966, page: "3", desc: "The trail traverses five valleys before ending at Kalalau Beach where it is blocked by sheer, fluted cliffs. The 11-mile trail is graded but almost never level as it crosses above towering sea cliffs and through lush tropical valleys. The trail drops to sea level at the beaches of Hanakapi'ai and Kalalau.", image: #imageLiteral(resourceName: "kalalau"), length: 10.0, clothes: "Sun Shirt\nWater Shoes\nSocks\nRunning Shorts")
    let trail4 = objectTrail(name: "South Rim Trail", latitude: 36.058369426516386, longitude: -112.1272768600295, page: "4", desc: "South Rim Day Hikes. The Rim Trail extends from the village area to Hermits Rest. Begin from any viewpoint in the Village or along Hermit Road. The Rim Trail offers excellent walking for quiet views of the inner canyon and for visitors who desire an easy hike.", image: #imageLiteral(resourceName: "south"), length: 10.0, clothes: "Shorts\nLong Sleeves\nJacket\nActive Wear\nT-Shirt")
    
    lazy var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            currentPageLabel.text = String(currentPage)
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Restart", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    func getCurrentPage() -> objectTrail{
        let pagey:Int = currentPage
        var trailNumber:objectTrail = trail0
        if(pagey == Int(trail1.getPage())){
            trailNumber = trail1
        }
        if(pagey == Int(trail2.getPage())){
            trailNumber = trail2
        }
        if(pagey == Int(trail3.getPage())){
            trailNumber = trail3
        }
        if(pagey == Int(trail4.getPage())){
            trailNumber = trail4
        }
        return trailNumber
    }
    
    func showWater() -> Double {
        let trailNumber = self.getCurrentPage()
        return trailNumber.getLength()*1.5
    }
    func showClothes() -> String {
        let trailNumber = self.getCurrentPage()
        return trailNumber.getClothes()
    }
    
    @IBAction func animalsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Animals"
        InfoController.page = currentPageLabel.text!
    }
    
    @IBAction func plantsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Plants"
        InfoController.page = currentPageLabel.text!
    }
    
    @IBAction func showNavigation(_ sender: Any) {
        
        let pagey = currentPageLabel.text!
        var trailNumber:objectTrail = trail0
        if(pagey == trail1.getPage()){
            trailNumber = trail1
        }
        if(pagey == trail2.getPage()){
            trailNumber = trail2
        }
        if(pagey == trail3.getPage()){
            trailNumber = trail3
        }
        if(pagey == trail4.getPage()){
            trailNumber = trail4
        }
        
        let latitude:CLLocationDegrees = trailNumber.getLatitude()
        let longitude:CLLocationDegrees = trailNumber.getLongitutde()
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan:regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Selected Trail"
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [
            OnboardingSlide(title: trail0.getName() , description: trail0.getDescription(), image: trail0.getImage()),
            OnboardingSlide(title: trail1.getName() , description: trail1.getDescription(), image: trail1.getImage()),
            OnboardingSlide(title: trail2.getName() , description: trail2.getDescription(), image: trail2.getImage()),
            OnboardingSlide(title: trail3.getName() , description: trail3.getDescription(), image: trail3.getImage()),
            OnboardingSlide(title: trail4.getName() , description: trail4.getDescription(), image: trail4.getImage())
        ]
        
        let indexPath = IndexPath(item: OnboardingViewController.pagee, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    @IBAction func notifyStartPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["Starting my hike!  I will notify you when I'm done."], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func notifyEndPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["Just finished my hike!  Thank you!"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
        
    @IBAction func nextButtonClicked(_ sender: UIButton){
        if currentPage ==  slides.count - 1{
            currentPage = 0
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl.currentPage = currentPage
    }
    

}
