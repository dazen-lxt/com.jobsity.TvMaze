//
//  Endpoint+CastCredit.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct CastCredit {
        var idPerson: Int
    }
    
}

extension Endpoint.CastCredit: BaseEndpoint {
    
    var path: String {
        return "people/\(idPerson)/castcredits"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "embed", value: "show")
        ]
    }
}
