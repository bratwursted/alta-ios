//
//  DataFetcher.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
  case apiError(reason: String)
  case badRequest
  case badResponse
  case networkError(from: URLError)
  case unknown

  static func error(withCode statusCode: Int) -> NetworkError {
    switch statusCode {
    case 401:
      return .apiError(reason: "Unauthorized")
    case 403:
      return .apiError(reason: "Resource forbidden")
    case 404:
      return .apiError(reason: "Resource not found")
    case 405..<500:
      return .apiError(reason: "Client error")
    case 500..<600:
      return .apiError(reason: "Server error")
    default:
      return .unknown
    }
  }
}

struct DataFetcher {
  private let session = URLSession.shared

  func fetch(_ request: URLRequest) -> AnyPublisher<Data, NetworkError> {

    return session.dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.badResponse
        }
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 300 else {
          throw NetworkError.error(withCode: httpResponse.statusCode)
        }

        return data
    }
    .mapError { error in
      if let networkError = error as? NetworkError {
        return networkError
      }
      if let urlError = error as? URLError {
        return NetworkError.networkError(from: urlError)
      }

      return NetworkError.unknown
    }
    .eraseToAnyPublisher()
  }
}
