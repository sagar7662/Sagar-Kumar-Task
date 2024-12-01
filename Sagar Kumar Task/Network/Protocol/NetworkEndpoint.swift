//
//  NetworkEndpoint.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation

protocol NetworkEndpoint {
    var baseURL: URL? { get }
    var path: String { get }
    var url: URL? { get }
    var method: String { get }
    var queryParameters: [URLQueryItem]? { get }
}
