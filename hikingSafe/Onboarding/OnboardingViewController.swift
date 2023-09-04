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
    
    var currentPages: String = "0"
        
    var slides: [OnboardingSlide] = []
            
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            currentPageLabel.text = String(currentPage)
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Restart", for: .normal)
            } else {
                nextButton.setTitle("Next Trail", for: .normal)
            }
        }
    }
    
    func getCurrentPage() -> String {
        return currentPageLabel.text!
    }
    
    @IBAction func animalsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Animals"
        currentPages = currentPageLabel.text!
    }
    
    @IBAction func plantsClicked(_ sender: Any) {
        AdditionalInfoViewController.type = "Plants"
        currentPages = currentPageLabel.text!

    }
    
    @IBAction func showNavigation(_ sender: Any) {
        let latitude:CLLocationDegrees = 37.86911286093985
        let longitude:CLLocationDegrees = -119.53606438981882
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
            OnboardingSlide(title: "Yosemite National Park", description: "First Trail.", image: #imageLiteral(resourceName: "yosemite")),
            OnboardingSlide(title: "Appalachain Trail", description: "Second Trail.", image: #imageLiteral(resourceName: "appalachain")),
            OnboardingSlide(title: "Burroughs Mountail Trail", description: "Third Trail.", image: #imageLiteral(resourceName: "burroughs")),
            OnboardingSlide(title: "Kalalau Trail", description: "Fourth Trail.", image: #imageLiteral(resourceName: "kalalau")),
            OnboardingSlide(title: "South Rim Trail", description: "Fifth Trail.", image: #imageLiteral(resourceName: "south"))
        ]
        
        func scrollToCurrent(newPage: Int){
            currentPage = 0
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
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

