//
//  CreateOrUpdateGameViewController.swift
//  semana6ColeccionDeJuegos
//
//  Created by mbtec22 on 4/15/21.
//

import UIKit

class CreateOrUpdateGameViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var btnCameraOrGalery: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    var album:Album?=nil
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnCameraOrGalery.image = UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    @IBAction func onClickAlertCameraOrGalery(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Semana 06", message: "Quieres acceder a la camara o galería?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camara", style: .default, handler: {
            _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: {
            _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let album = Album(context: context)
        album.titulo = tituloTextField.text
        album.imagen = imageView.image!.pngData()! as NSData as Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
