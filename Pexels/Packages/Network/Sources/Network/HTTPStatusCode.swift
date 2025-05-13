//
//  HTTPStatusCode.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation

/**
 HTTP status code definition
 
 - seeAlso: https://datatracker.ietf.org/doc/html/rfc2616#page-39
 */
public enum HTTPStatusCode: Int {
	case ok = 200
	case unAuthorized = 401
	case forbidden = 403
	case notFound = 404
	case notAcceptable = 406
	case internalServerError = 500
}
