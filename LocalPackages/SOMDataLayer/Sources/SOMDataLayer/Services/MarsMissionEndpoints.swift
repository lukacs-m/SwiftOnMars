//
//  MarsMissionEndpoints.swift
//
//
//  Created by Martin Lukacs on 12/04/2023.
//

import Foundation
import SimpleNetwork

struct RequestParams: Codable, Hashable {
    let roverId: String
    let sol: Int?
    let date: String?
    let camera: String?
    let page: Int?

    enum CodingKeys: String, CodingKey {
        case roverId, sol, camera, page
        case date = "earth_date"
    }
}

enum MarsMissionEndpoint {
    case rover(id: String)
    case manifest(id: String)
    case photoWithSol(request: RequestParams)
    case photoFromDate(request: RequestParams)
}

extension MarsMissionEndpoint: Endpoint {
    var baseUrl: String? {
        APIConfiguration.baseUrl
    }

    var path: String {
        switch self {
        case let .rover(id):
            return "rovers/\(id)"
        case let .manifest(id):
            return "manifests/\(id)"
        case let .photoFromDate(params),
             let .photoWithSol(params):
            return "rovers/\(params.roverId)/photos"
        }
    }

    var method: CRUDRequestMethod {
        .get
    }

    var header: [String: String]? {
        nil
    }

    var body: [String: Any]? {
        var params: [String: Any] = ["api_key": APIConfiguration.apiKey]
        switch self {
        case let .photoFromDate(param), let .photoWithSol(param):
            guard let dict = param.convertToDictionary else {
                return params
            }
            params = params.merging(dict) { current, _ in current }
            return params
        default:
            return params
        }
    }
}
