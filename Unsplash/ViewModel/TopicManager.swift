import Foundation
import SwiftUI
import Alamofire

@Observable
class TopicManager {
    var topics: [Topic] = []
    var isIniting: Bool = true
    var isLoading: Bool = true
    var ids: [String]? = nil
    var page: Int = 1
    var perPage: Int = 20
    var orderBy: OrderBy = .lastest
    var error: AFError? = nil
    
    init(ids: [String]? = nil, page: Int = 1, perPage: Int = 20, orderBy: OrderBy = .lastest) {
        self.ids = ids
        self.page = page
        self.perPage = perPage
        self.orderBy = orderBy
    }
    
    func next(){
        self.isLoading = true
        Topic.list(ids: ids, page: page + 1, perPage: perPage, orderBy: orderBy) { result in
            switch result {
            case .success(let topics):
                self.topics += topics
                self.page += 1
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
    
    func reload(){
        self.isIniting = true
        Topic.list { result in
            switch result {
            case .success(let topics):
                self.topics = topics
            case .failure(let error):
                self.error = error
            }
            self.isIniting = false
        }
    }
}
