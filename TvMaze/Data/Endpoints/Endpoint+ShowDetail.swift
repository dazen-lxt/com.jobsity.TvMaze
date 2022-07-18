//
//  Endpoint+ShowDetail.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Alamofire

extension Endpoint {
    
    struct ShowDetail {
        var id: Int
    }
    
}

extension Endpoint.ShowDetail: BaseEndpoint {
    
    var path: String {
        return "shows/\(id)"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
