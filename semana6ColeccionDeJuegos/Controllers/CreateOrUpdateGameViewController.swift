import UIKit

class CreateOrUpdateGameViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var btnCameraOrGalery: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var album:Album?=nil
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnCameraOrGalery.image = UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal)
        btnUpdate.layer.cornerRadius = 10
        btnDelete.layer.cornerRadius = 10
        
        if album != nil {
            imageView.image = UIImage(data: (album!.imagen!) as Data)
            tituloTextField.text = album!.titulo
            btnUpdate.setTitle("Actualizar", for: .normal)
            btnUpdate.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }else{
            btnDelete.isHidden = true
        }
    }
    
    @IBAction func onClickAlertCameraOrGalery(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Semana 06", message: "Quieres acceder a la cámara o galería?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: {
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
        
        if album != nil {
            album!.titulo = tituloTextField.text
            album!.imagen = imageView.image!.pngData()! as NSData? as Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let album = Album(context: context)
            album.titulo = tituloTextField.text
            album.imagen = imageView.image!.pngData()! as NSData? as Data?
        }
       
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(album!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
