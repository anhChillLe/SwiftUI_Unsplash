//
//  CollectionDetailViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Alamofire
import Foundation
import SwiftUI

@Observable
class CollectionDetailViewModel {
    var collection: Collection
    var photos: [Photo] = []
    var isLoading: Bool = false
    var error: AFError? = nil

    init(collection: Collection) {
        self.collection = collection
    }

    func loadPhoto() {
        self.isLoading = true
        collection.listPhoto() { result in
            switch result {
            case .success(let photos):
                self.photos = photos
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
        
    }
}
