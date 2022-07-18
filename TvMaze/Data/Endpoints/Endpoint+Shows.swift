//
//  Shows.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct Shows {
        var page: Int
    }
    
}

extension Endpoint.Shows: BaseEndpoint {
    
    var path: String {
        return "shows"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
}
