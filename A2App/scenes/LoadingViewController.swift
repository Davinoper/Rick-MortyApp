//
//  LoadingViewController.swift
//  A2App
//
//  Created by Davi Noleto on 18/06/23.
//

import UIKit

class LoadingViewController: UIViewController {

    let loadingView = LoadingView()
    
    override func loadView() {
        self.view = loadingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadingOff() {
        self.dismiss(animated: true, completion: nil)
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
