//
//  Endpoint+People.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct People {
        var name: String
    }
    
}

extension Endpoint.People: BaseEndpoint {
    
    var path: String {
        return "search/people"
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
