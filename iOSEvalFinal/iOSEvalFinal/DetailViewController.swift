//
//  DetailViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    
    @IBOutlet weak var windowsImage: UIImageView!
    @IBOutlet weak var macImage: UIImageView!
    @IBOutlet weak var linuxImage: UIImageView!
    
    @IBOutlet weak var keyboardImage: UIImageView!
    @IBOutlet weak var mouseImage: UIImageView!
    @IBOutlet weak var gamepadImage: UIImageView!
    
    var passData: Featured!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
