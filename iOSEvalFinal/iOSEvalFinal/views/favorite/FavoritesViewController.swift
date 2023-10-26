//
//  FavoritesViewController.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import UIKit
import CoreData
import Alamofire
import AlamofireImage

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let context = DataService.shared.context
    var resultsController: NSFetchedResultsController<Favorite>!
    var gameList: [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites list"
        navigationController?.navigationBar.tintColor = .white
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        // lier le nib avec la customCell
        favoriteTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CustomTableViewCell")
        //favoriteTableView.reloadData()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Mettez ici le code pour rafraîchir votre tableau
        fetchData()
        favoriteTableView.reloadData() // Par exemple, pour un UITableView
    }
    // MARK: - Data fetch
    func fetchData() {

        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.sortDescriptors = [
            // query: filtre par nom
            NSSortDescriptor(key: "name", ascending: true)
        ]
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil
        )
        do {
            try resultsController.performFetch()
        } catch {
            print("Could not fetch receipes : ", error)
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = resultsController?.object(at: indexPath)
        
        let customCell = favoriteTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        // Utilise AlamofireImage pour télécharger et afficher l'image depuis l'URL
        if let imageURL = URL(string: game?.imageUrl ?? "https://www.usbforwindows.com/storage/img/images_3/function_set_default_image_when_image_not_present.png") {
            customCell.gameImage.af.setImage(withURL: imageURL)
        }
        customCell.gameName.text = game?.name
        if !(game?.price == 0) {
            customCell.gamePrice.text = String(format: "%.2f", Float(game!.price) / 100) + "€"
        } else {
            customCell.gamePrice.textColor = .green
            customCell.gamePrice.font = UIFont.systemFont(ofSize: 30)
            customCell.gamePrice.font = UIFont.boldSystemFont(ofSize: 20)
            customCell.gamePrice.text = "Free"
        }
        
        return customCell
    }
    // ajout de la fonction "slide, effacer"
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let game = resultsController.object(at: indexPath)
            DataService.shared.deleteFavorite(favorite: game)
            fetchData()
            favoriteTableView.reloadData()
        }
    }
}
