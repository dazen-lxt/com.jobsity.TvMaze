//
//  MainTabViewController.swift
//  TvMaze
//
//  Created by Carlos on 14/07/22.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewControllers() {
        let tvListViewController = UINavigationController(
            rootViewController: TvListTableViewController.assembleModule()
        )
        tvListViewController.tabBarItem = UITabBarItem(title: "Tv Shows", image: UIImage(systemName: "tv"), tag: 0)
        
        let peopleViewController = UINavigationController(
            rootViewController: PeopleTableViewController.assembleModule()
        )
        peopleViewController.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person"), tag: 1)
        
        let favoriteListViewController = UINavigationController(
            rootViewController: FavoriteListTableViewController.assembleModule()
        )
        favoriteListViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)
        
        viewControllers =  [tvListViewController, peopleViewController, favoriteListViewController]
    }

}
