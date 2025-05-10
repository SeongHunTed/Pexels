//
//  HTTPMethod.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation

/**
 HTTP method definition
 
 - seeAlso: https://datatracker.ietf.org/doc/html/rfc2616#page-36
 */
enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}
