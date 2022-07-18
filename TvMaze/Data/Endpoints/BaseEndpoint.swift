//
//  BaseEndpoint.swift
//  TvMaze
//
//  Created by Carlos on 15/07/22.
//

import Foundation
import Alamofire

protocol BaseEndpoint: URLRequestConvertible {

    // MARK: - Mandatory Properties -
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    
    // MARK: - Optional Properties -
    var params: Parameters? { get }
    var queryItems: [URLQueryItem]? { get }
    
}

extension BaseEndpoint {
    
    var baseUrl: URL {
        return URL(string: "https://api.tvmaze.com/")!
    }
    
    var params: Parameters? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponent = URLComponents(string: baseUrl.appendingPathComponent(path).absoluteString)!
        urlComponent.queryItems = queryItems
        var urlRequest = URLRequest(url: urlComponent.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
        return urlRequest
    }
}
