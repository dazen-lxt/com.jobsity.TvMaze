//
//  FavoriteListContract.swift
//  TvMaze
//
//  Created by Carlos on 17/07/22.
//

import Foundation
import CoreData

protocol FavoriteListBusinessLogic: AnyObject {
    func listFavorites()
    func deleteFavorite(id: Int) 
}

protocol FavoriteListPresentationLogic: AnyObject {
    func presentShows(_ shows: [NSManagedObject])
}

protocol FavoriteListDisplayLogic: AnyObject {
    func displayShows(_ shows: [TvShowViewModel])
}
