//
//  DetailViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit
import AlamofireImage

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

        gameTitleLabel.text = passData.name
        // Utilise AlamofireImage pour télécharger et afficher l'image depuis l'URL
        if let imageURL = URL(string: passData.largeCapsuleImage) {
            gameImageView.af.setImage(withURL: imageURL)
        }
        
        discountPriceLabel.isHidden = !passData.discounted
        let oldPrice = String(format: "%.2f", passData.originalPrice! / 100) + "€"
        let attributedText = NSAttributedString(
            string: oldPrice,
            attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )

        oldPriceLabel.attributedText = attributedText

        oldPriceLabel.isHidden = !passData.discounted
        discountPriceLabel.text = "\(passData.discountPercent) %"
        if passData.discounted {
            newPriceLabel.textColor = UIColor.green
        } else {
            newPriceLabel.textColor = UIColor.white
        }
        newPriceLabel.text = String(format: "%.2f", passData.finalPrice! / 100) + "€"
        
        windowsImage.image = UIImage(named: "windows")
        windowsImage.isHidden = !passData.windowsAvailable
        macImage.image = UIImage(named: "mac")
        macImage.isHidden = !passData.macAvailable
        linuxImage.image = UIImage(named: "linux")
        linuxImage.isHidden = !passData.linuxAvailable
        
        gamepadImage.isHidden = !(passData.controllerSupport == "full")
    }
    

    /*
    // MARK: - Navigation

   
    */

}
