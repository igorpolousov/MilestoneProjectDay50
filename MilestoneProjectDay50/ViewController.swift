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
        
        loadData()
        
        
    }
    // Количество строк в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    // Описание ячейки в таблице
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let picture = pictures[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
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
        var picture = Picture(image: imageName, caption: "")
    
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let newCaption = ac?.textFields?[0].text else { return }
            picture.caption = newCaption
            self?.pictures.append(picture)
            self?.save()
            self?.tableView.reloadData()
        })
        present(ac, animated: true)
    
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let path = getDocumentDirectory().appendingPathComponent(pictures[indexPath.row].image)
           
            vc.selectedImage = path.path
            vc.photoTitle = pictures[indexPath.row].caption
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures){
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: "pictures")
        } else {
            print("Failed to save pictures")
        }
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                try pictures = jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch  {
                print("Failed to load data")
            }
        }
    }
    
}

