//
//  DetailViewController.swift
//  MilestoneProjectDay50
//
//  Created by Igor Polousov on 11.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
}
