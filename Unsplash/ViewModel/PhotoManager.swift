import Foundation
import Alamofire
import SwiftUI

@Observable
class PhotoManager {
    var photos: [Photo] = []
    var isIniting: Bool = true
    var isLoading: Bool = true
    var page: Int = 1
    var perPage: Int = 20
    var orderBy: OrderBy = .lastest
    var error: AFError? = nil
    
    init(page: Int = 1, perPage: Int = 20, orderBy: OrderBy = .lastest) {
        self.page = page
        self.perPage = perPage
        self.orderBy = orderBy
    }
    
    func next(){
        self.isLoading = true
        Photo.list(page: page + 1, perPage: perPage, orderBy: orderBy) { result in
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
        self.isIniting = true
        Photo.list { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.page = 1
            case .failure(let error):
                self.error = error
            }
            self.isIniting = false
        }
    }
}
