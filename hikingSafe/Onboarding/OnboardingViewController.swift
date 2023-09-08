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
                
    let trail0 = objectTrail(name: "Yosemite National Park", latitude: 37.86911286093985, longitude: -119.53606438981882, page: "0", desc: "Trail 0", image: #imageLiteral(resourceName: "yosemite"))
    let trail1 = objectTrail(name: "Appalachain Trail", latitude: 42.289580011600975, longitude: -73.15701486156591, page: "1", desc: "Trail 1", image: #imageLiteral(resourceName: "appalachain"))
    let trail2 = objectTrail(name: "Burroughs Mountail Trail", latitude: 46.905987670323675, longitude: -121.68963696130662, page: "2", desc: "Trail 2", image: #imageLiteral(resourceName: "burroughs"))
    let trail3 = objectTrail(name: "Kalalau Trail", latitude: 22.19609578950994, longitude: -159.62040994889966, page: "3", desc: "Trail 3", image: #imageLiteral(resourceName: "kalalau"))
    let trail4 = objectTrail(name: "South Rim Trail", latitude: 36.058369426516386, longitude: -112.1272768600295, page: "4", desc: "Trail 4", image: #imageLiteral(resourceName: "south"))
    
    var currentPage = 0 {
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
    
    @IBAction func animalsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Animals"
        InfoController.page = currentPageLabel.text!
    }
    
    @IBAction func plantsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Plants"
        InfoController.page = currentPageLabel.text!
    }
    
    @IBAction func showNavigation(_ sender: Any) {
        
        var pagey = currentPageLabel.text!
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

