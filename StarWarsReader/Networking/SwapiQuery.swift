//
//  SwapiQuery.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/12/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation

struct SwapiQuery {

  private let queryFile: String

  private let resourceId: String?

  private let components: URLComponents = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "swapi.graph.cool"
    return components
  }()

  init(
    _ file: String,
    resourceId: String? = nil
  ) {
    queryFile = file
    self.resourceId = resourceId
  }

  var urlRequest: URLRequest? {
    guard let bundleUrl = Bundle.main.url(forResource: queryFile, withExtension: ".graphql") else {
      assertionFailure("Expected to find query file \(queryFile)")
      return nil
    }

    guard let queryUrl = components.url else {
      assertionFailure("Expected to get URL from components")
      return nil
    }

    var urlRequest = URLRequest(url: queryUrl)
    urlRequest.httpMethod = "POST"
    let headerFields = ["content-type": "application/json"]

    urlRequest.allHTTPHeaderFields = headerFields

    do {
      let queryString = try String(contentsOf: bundleUrl)
      var requestBody: [String: Any] = ["query": queryString]
      if let resourceId = resourceId {
        let queryVariables = ["id": resourceId]
        requestBody["variables"] = queryVariables
      }
      let postData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
      urlRequest.httpBody = postData

      return urlRequest

    } catch {
      assertionFailure("An error occured while initializing query request \(error)")
      return nil
    }

  }
}
