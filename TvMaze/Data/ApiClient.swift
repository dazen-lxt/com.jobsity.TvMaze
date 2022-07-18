//
//  ApiClient.swift
//  TvMaze
//
//  Created by Carlos on 15/07/22.
//

import Foundation
import Alamofire

final class ApiClient: Session {
    private static var privateShared: ApiClient?

    static var shared: ApiClient {
        get {
            guard let uwShared = privateShared else {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.timeoutIntervalForRequest = 30
                configuration.timeoutIntervalForResource = 60
                privateShared = ApiClient(configuration: configuration)
                return privateShared!
            }
            return uwShared
        }
    }

    func doRequest<T: Decodable>(
        req: BaseEndpoint,
        dateFormat: String = "yyyy/MM/dd HH:mm:ss",
        completionHandler: @escaping ((ApiResult<T>) -> Void)
    ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        request(req)
            .responseDecodable(of: T.self) { (response) in
                var output: ApiResult<T>
                let statusCode = response.response?.statusCode

                switch response.result {
                case .success(let value):
                    output = ApiResult.success(value)
                case .failure(let error):
                    output = ApiResult.failure(error, statusCode ?? 0)
                }
                completionHandler(output)
        }
    }
}
