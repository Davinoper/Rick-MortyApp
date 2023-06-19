import UIKit

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characters = CharactersDataSource()
    var posts: [ImageItem]!
    let loadingViewController = LoadingViewController()
    var currentPage = 1
    var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadItems()
        
        loadingViewController.modalTransitionStyle = .coverVertical
        loadingViewController.modalPresentationStyle = .fullScreen
        self.present(loadingViewController, animated: true, completion: nil)
        setupInfiniteScroll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
    }
    
    func setupInfiniteScroll() {
            tableView.tableFooterView = createTableFooterView()
        }
        
    func createTableFooterView() -> UIView {
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = tableFooterView.center
        tableFooterView.addSubview(indicator)
        
        return tableFooterView
    }
    
    func showTableFooterView() {
        tableView.tableFooterView?.isHidden = false
        (tableView.tableFooterView?.subviews.first as? UIActivityIndicatorView)?.startAnimating()
    }
    
    func hideTableFooterView() {
        tableView.tableFooterView?.isHidden = true
        (tableView.tableFooterView?.subviews.first as? UIActivityIndicatorView)?.stopAnimating()
    }

    
    
    func loadItems() {
        characters.loadItems(url: "https://rickandmortyapi.com/api/character?page=\(currentPage)",
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
    
    func loadNextPage() {
            currentPage += 1
            isLoadingData = true
            
            characters.loadItems(url: "https://rickandmortyapi.com/api/character?page=\(currentPage)",
                                 success: { (items: [ImageItem]) in
                                    self.posts.append(contentsOf: items)
                
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        self.isLoadingData = false
                                    }
                                 },
                                 error: {
                                    print("Erro")
                                 })
        }
    
    
    
}


extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let tableHeight = scrollView.bounds.size.height
            
            if offsetY > contentHeight - tableHeight {
                if !isLoadingData {
                    showTableFooterView()
                    loadNextPage()
                }
            }
        }
    
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
        controller.characters = characters
        controller.item = item
        
    }
}
