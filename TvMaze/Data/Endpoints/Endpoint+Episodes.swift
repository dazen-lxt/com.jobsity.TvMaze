//
//  Endpoint+Episodes.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct Episodes {
        var showId: Int
    }
    
}

extension Endpoint.Episodes: BaseEndpoint {
    
    var path: String {
        return "shows/\(showId)/episodes"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
