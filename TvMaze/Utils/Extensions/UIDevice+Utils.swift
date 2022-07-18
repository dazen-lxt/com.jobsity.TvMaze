//
//  UIDevice+Utils.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation
import UIKit

extension UIDevice {
    
    var typeScreen: UIDevice.typeScreenEnum {
        get {
            if self.userInterfaceIdiom == .phone {
                switch UIScreen.main.bounds.height {
                case 400:
                    return typeScreenEnum.iphone4
                case 568:
                    return typeScreenEnum.iphone5
                case 667:
                    return typeScreenEnum.iphone6
                case 736:
                    return typeScreenEnum.iphonePlus
                case 812:
                    return typeScreenEnum.iphoneX
                case 896:
                    return typeScreenEnum.iphoneXSMax
                default:
                    return typeScreenEnum.unknown
                }
            }
            return typeScreenEnum.unknown
        }
    }
    
    enum typeScreenEnum {
        case iphone4
        case iphone5
        case iphone6
        case iphonePlus
        case iphoneX
        case iphoneXSMax
        case unknown
    }
    
    var faceID: Bool {
        get {
            return typeScreen != .iphone4
            && typeScreen != .iphone5
            && typeScreen != .iphone6
            && typeScreen != .iphonePlus

        }
    }
}
