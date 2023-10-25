//
//  DetailViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit
import AlamofireImage
import SafariServices

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
    
    @IBOutlet weak var favIco: UIButton!
    
    var passData: Featured!
    private var isFavorite: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        gameTitleLabel.text = passData.name
        // Utilise AlamofireImage pour télécharger et afficher l'image depuis l'URL
        if let imageURL = URL(string: passData.largeCapsuleImage) {
            gameImageView.af.setImage(withURL: imageURL)
        }
        
        discountPriceLabel.isHidden = !passData.discounted
        let oldPrice = String(format: "%.2f", (passData.originalPrice ?? 8) / 100) + "€"
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
        
        // gère l'affichage des favoris
        if DataService.shared.idExists(id: passData.id) {
            favIco.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFavorite = true
        } else {
            favIco.setImage(UIImage(systemName: "star"), for: .normal)
            isFavorite = false
        }
    }
    
    
    @IBAction func favBtn() {
        isFavorite?.toggle()
        favIco.setImage(isFavorite! ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        if isFavorite! {
            DataService.shared.addFavorite(id: Int32(passData.id), name: passData.name, price: Float(passData.finalPrice ?? 8), imageUrl: passData.largeCapsuleImage)
        } else {
            DataService.shared.deleteFavoriteById(withID: passData.id)
        }
    }
    
    @IBAction func openWebPage(_ sender: UIButton) {
        if let url = URL(string: "https://store.steampowered.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
