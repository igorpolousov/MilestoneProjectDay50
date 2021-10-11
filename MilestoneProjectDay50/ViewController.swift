//
//  ViewController.swift
//  MilestoneProjectDay50
//
//  Created by Igor Polousov on 11.10.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var pictures = [Picture]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewphoto))
        
        
    }
    // Количество строк в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    // Описание ячейки в таблице
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture.caption
        return cell
    }
    
    // Функция получения картинки с фотоаппарата
    @objc func addNewphoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
    }
    
}

