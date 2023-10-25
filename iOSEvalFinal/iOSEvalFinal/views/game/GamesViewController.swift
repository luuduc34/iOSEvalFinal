//
//  GamesViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    let apiUrl = "https://store.steampowered.com/api/featured"
    private var gameList: [Featured] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games list"
        
        appelReseau()
    }
    
    
    // MARK: - Connexion à l'api
    @objc func appelReseau() {
        // appel réseau avec query parameters
        
        AF.request(apiUrl, method: .get).response { dataResponse in
            switch dataResponse.result {
            case .success(let data):
                //Data est une optional donc on s'assure qu'elle n'est pas nulle sinon on sort
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let GameResponse = try decoder.decode(GameResponse.self, from: data)
                    //On revient dans main car on modifie l'UI
                    DispatchQueue.main.async {
                        self.gameList = GameResponse.featuredWin // Stocker les données obtenues
                    }
                    // On gère les erreurs
                } catch let error {
                    print("ERROR DETECTED: \(error)")
                }
            case .failure(let error):
                print("ERROR DETECTED: \(error)")
            }
        }
    }
}
