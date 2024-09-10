//
//  TopicDetailsViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 7/9/24.
//

import Foundation
import Alamofire

@Observable
class TopicDetailsViewModel {
    let topic: Topic
    var photos: [Photo] = []
    var isLoading: Bool = false
    var error: AFError? = nil
    var page: Int = 0
    let perPage: Int
    let orientation: Orientation?
    let orderBy: OrderBy?
    
    init(topic: Topic, perPage: Int = 20, orientation: Orientation? = nil, orderBy: OrderBy? = nil) {
        self.topic = topic
        self.perPage = perPage
        self.orientation = orientation
        self.orderBy = orderBy
    }
    
    private var loadable: Bool {
        !isLoading || photos.count < topic.totalPhotos
    }
    
    func load(){
        if(!self.loadable) { return }
        self.isLoading = true
        topic.listPhoto(page: page + 1, orientation: orientation, orderBy: orderBy){ result in
            switch result {
            case .success(let photos):
                self.photos += photos
                self.page += 1
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
    
    func reload(){
        if(!self.loadable) { return }
        self.isLoading = true
        topic.listPhoto{ result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.page = 1
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
}
