//
//  APIState.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 10/9/24.
//

import Foundation
import Alamofire

enum APIState<T> {
    case idle
    case loading
    case success(T)
    case failure(AFError)
}
