//
//  CharacterDetailsViewController.swift
//  A2App
//
//  Created by Davi Noleto on 18/06/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var strName: String?
    var strStatus: String?
    var strLastLocation: String?
    var strFirstLocation: String?
    var strImage: String?
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterStatus: UILabel!
    
    @IBOutlet weak var characterFirstLocation: UILabel!
    @IBOutlet weak var characterLastLocation: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterName.text = strName!
        characterStatus.text = strStatus!
        characterLastLocation.text = strLastLocation!
        characterFirstLocation.text = strFirstLocation
        characterImage.downloaded(from: strImage!)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
