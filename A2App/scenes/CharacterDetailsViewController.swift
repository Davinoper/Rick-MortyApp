//
//  CharacterDetailsViewController.swift
//  A2App
//
//  Created by Davi Noleto on 18/06/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var characters: CharactersDataSource!
    var item: ImageItem!
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterStatus: UILabel!
    
    @IBOutlet weak var characterFirstLocation: UILabel!
    @IBOutlet weak var characterLastLocation: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterSpecies: UILabel!
    
    
    @IBOutlet weak var characterEpisodes: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterName.text = item.name
        characterStatus.text = item.status
        characterLastLocation.text = item.location.name
        characterFirstLocation.text = item.origin.name
        characterSpecies.text = item.species
        characterImage.downloaded(from: item.image)
        
        decoration()
        // Do any additional setup after loading the view.
    }

    
    func decoration(){
        if(characterStatus.text == "Dead"){
            characterStatus.textColor = .red
        } else if (characterStatus.text == "unknown"){
            characterStatus.textColor = .yellow
        }else{
            characterStatus.textColor = .green
        }
    }
    
    @IBAction func favoriteChar(_ sender: Any) {
        characters.setData()
        characters.addItem(character: item)
        
        if let encodedData = try? JSONEncoder().encode(characters.favoriteCharacter) {
            // Salvar os dados JSON no UserDefaults
            UserDefaults.standard.set(encodedData, forKey: "favorites")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
