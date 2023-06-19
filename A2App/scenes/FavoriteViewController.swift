//
//  FavoriteViewController.swift
//  A2App
//
//  Created by Davi Noleto on 18/06/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites: [ImageItem] = []
    var holder: [ImageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let favoritesData = UserDefaults.standard.data(forKey: "favorites") {
            favorites = try! JSONDecoder().decode([ImageItem].self, from: favoritesData)
        }
        
        for item in favorites {
            if let imageItem = item as? ImageItem {
                holder.append(imageItem)
            }
        }
        
        self.tableView.reloadData()
    }
  

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if holder == nil{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favoritados"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if holder == nil{
            return 0
        }
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.holder[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Celula", for: indexPath) as? FavCell {
            cell.characterName.text = item.name
            cell.characterIcon.downloaded(from: item.image)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
