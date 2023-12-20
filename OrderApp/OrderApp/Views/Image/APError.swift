//
//  APError.swift
//  OrderApp
//
//  Created by FDCI on 11/9/23.
//

import Foundation


enum APError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
