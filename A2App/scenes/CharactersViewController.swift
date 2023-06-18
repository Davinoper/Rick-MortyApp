import UIKit

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characters = CharactersDataSource()
    var posts: [ImageItem]!
    let loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadItems()
        loadingViewController.modalTransitionStyle = .coverVertical
        loadingViewController.modalPresentationStyle = .fullScreen
        self.present(loadingViewController, animated: true, completion: nil)
    }
    
    func loadItems() {
        characters.loadItems(url: "https://rickandmortyapi.com/api/character?page=1",
                             success: { (items: [ImageItem]) in
                                self.posts = items
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    self.loadingViewController.loadingOff()
                                }
                             },
                             error: {
                                print("Erro")
                             })
    }
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if posts == nil {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Personagens"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts == nil {
            return 0
        }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyCell {
            cell.characterName.text = item.name
            cell.characterIcon.downloaded(from: item.image)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CharacterDetailsViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        let item = posts[indexPath.row]
        controller.strName = item.name
        controller.strFirstLocation = item.location.name
        controller.strStatus = item.status
        controller.strImage = item.image
        controller.strLastLocation = item.location.name
        
    }
}
