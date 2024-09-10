//
//  CollectionViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 4/9/24.
//

import Foundation
import SwiftUI
import Alamofire

@Observable
class CollectionManager {
    var collections: [Collection] = []
    var isIniting: Bool = true
    var isLoading: Bool = true
    var page: Int = 1
    var perPage: Int = 20
    var error: AFError? = nil
    
    init(page: Int = 1, perPage: Int = 20) {
        self.page = page
        self.perPage = perPage
    }
    
    func next(){
        self.isLoading = true
        Collection.list(page: page + 1, perPage: perPage) { result in
            switch result {
            case .success(let collections):
                self.collections += collections
                self.page += 1
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
    
    func reload(){
        self.isIniting = true
        Collection.list { result in
            switch result {
            case .success(let collections):
                self.collections = collections
            case .failure(let error):
                self.error = error
            }
            self.isIniting = false
        }
    }
}
