//
//  ReusableView.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {

    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionReusableView: ReusableView {}
