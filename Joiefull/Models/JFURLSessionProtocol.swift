//
//  JFURLSessionProtocol.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import Foundation



protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
