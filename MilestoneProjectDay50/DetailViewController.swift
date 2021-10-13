//
//  DetailViewController.swift
//  MilestoneProjectDay50
//
//  Created by Igor Polousov on 11.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var photoTitle: String?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = photoTitle
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            
        }
    }
    
}
