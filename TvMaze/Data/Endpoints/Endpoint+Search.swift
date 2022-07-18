//
//  Endpoint+Search.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct Search {
        var name: String
    }
    
}

extension Endpoint.Search: BaseEndpoint {
    
    var path: String {
        return "search/shows"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "q", value: name)
        ]
    }
}
