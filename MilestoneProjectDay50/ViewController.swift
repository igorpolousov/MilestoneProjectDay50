//
//  ViewController.swift
//  MilestoneProjectDay50
//
//  Created by Igor Polousov on 11.10.2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    
    // Функция получения картинки с камеры или фотогалереи
    @objc func addNewphoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
       if let jpegData = image.jpegData(compressionQuality: 0.7) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(image: imageName, caption: "Unknown")
        
        pictures.append(picture)
        print(pictures)
        tableView.reloadData()
        dismiss(animated: true)
        
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let path = getDocumentDirectory().appendingPathComponent(pictures[indexPath.row].image)
           
            vc.selectedImage = path.path
          
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

