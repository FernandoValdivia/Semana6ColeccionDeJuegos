//
//  ViewController.swift
//  semana6ColeccionDeJuegos
//
//  Created by mbtec22 on 4/15/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var albums : [Album] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try albums = context.fetch(Album.fetchRequest())
            tableView.reloadData()
        }
        catch{
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.titulo
        cell.imageView?.image = UIImage(data: (album.imagen!) as! Data)
        return cell
    }


}

