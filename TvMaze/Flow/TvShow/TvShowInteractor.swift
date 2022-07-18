//
//  TvShowInteractor.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit
import CoreData

class TvShowInteractor {
    
    var managedContext: NSManagedObjectContext
    
    init() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Fail to load App Delegate")
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Internal Properties -
    var presenter: TvShowPresentationLogic?
    
}

// MARK: - TvShowBusinessLogic Implementation -
extension TvShowInteractor: TvShowBusinessLogic {
    
    func getShowDetail(id: Int) {
        let req = Endpoint.ShowDetail(id: id)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<TvShowInfoModel>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentShowDetail(data)
            default:
                break
            }
        }
    }
    
    func getEpisodes(id: Int) {
        let req = Endpoint.Episodes(showId: id)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<[EpisodeModel]>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentEpisodes(data)
            default:
                break
            }
        }
    }
    
    func checkIfIsFavorite(id: Int) {
        let isFavorite: Bool = getShowById(id: id) != nil
        presenter?.presentIsFavorite(isFavorite)
    }
    
    private func getShowById(id: Int) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Show")
        fetchRequest.predicate = NSPredicate(
            format: "id == %d", id
        )
        fetchRequest.fetchLimit = 1
        do {
            let show: NSManagedObject? = try managedContext.fetch(fetchRequest).first
            return show
        } catch let error as NSError {
            fatalError("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func toggleFavorite(show: TvShowViewModel) {
        let managedObject: NSManagedObject? = getShowById(id: show.id)
        if let managedObject = managedObject {
            deleteFavorite(show: managedObject)
        } else {
            saveFavorite(show: show)
        }
    }
    
    private func saveFavorite(show: TvShowViewModel) {
        let entity = NSEntityDescription.entity(
            forEntityName: "Show",
            in: managedContext
        )!
        
        let newShow = NSManagedObject(
            entity: entity,
            insertInto: managedContext)
        
        newShow.setValue(show.id, forKey: "id")
        newShow.setValue(show.name, forKey: "name")
        newShow.setValue(show.genres, forKey: "genres")
        newShow.setValue(show.imageUrl?.absoluteString, forKey: "imageUrl")
        
        do {
            try managedContext.save()
            presenter?.presentIsFavorite(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func deleteFavorite(show: NSManagedObject) {
        managedContext.delete(show)
        do {
            try managedContext.save()
            presenter?.presentIsFavorite(false)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
