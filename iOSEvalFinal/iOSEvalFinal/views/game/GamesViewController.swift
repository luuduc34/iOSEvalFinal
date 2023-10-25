//
//  GamesViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    let apiUrl = "https://store.steampowered.com/api/featured"
    private var gameList: [Featured] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games list"
        
        // Configure le layout de la collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.itemSize = CGSize(width: 110, height: 170)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        // Lie le layout à la collectionView
        gameCollectionView.collectionViewLayout = layout
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.isPagingEnabled = false
        gameCollectionView.register(UINib(nibName: "CustomTrendingCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "CustomTrendingCollectionViewCell")
        
        appelReseau()
    }
    // MARK: - Gestion de la collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
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
