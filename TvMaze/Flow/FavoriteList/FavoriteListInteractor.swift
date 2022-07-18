//
//  FavoriteListInteractor.swift
//  TvMaze
//
//  Created by Carlos on 17/07/22.
//

import UIKit
import CoreData

class FavoriteListInteractor {
    
    var managedContext: NSManagedObjectContext
    
    init() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Fail to load App Delegate")
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Internal Properties -
    var presenter: FavoriteListPresentationLogic?
    
    // MARK: - Private Properties -
    var shows: [NSManagedObject] = []
}


// MARK: - FavoriteListBusinessLogic Implementation -
extension FavoriteListInteractor: FavoriteListBusinessLogic {
    
    func listFavorites() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Show")
        do {
            shows = try managedContext.fetch(fetchRequest)
            presenter?.presentShows(shows)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFavorite(id: Int) {
        let showToDelete = shows.filter { managedObject in
            return (managedObject.value(forKey: "id") as? Int) == id
        }.first
        
        guard let showToDelete = showToDelete else { return }
        do {
            managedContext.delete(showToDelete)
            try managedContext.save()
        } catch let error as NSError {
            fatalError("Could not fetch. \(error), \(error.userInfo)")
        }
        let index = shows.firstIndex(of: showToDelete)
        guard let index = index else { return }
        shows.remove(at: index)
        presenter?.presentShows(shows)
    }
    
}
