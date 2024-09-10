//
//  HomeViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 31/8/24.
//

import Foundation
import SwiftUI

@Observable
class PhotoViewModel {
    var latest = PhotoManager(orderBy: .lastest)
    var oldest = PhotoManager(orderBy: .oldest)
    var popular = PhotoManager(orderBy: .popular)
    var collection = CollectionManager()
    var topic = TopicManager()
    
    var isIniting: Bool {
        latest.isIniting || collection.isIniting || topic.isIniting
    }
    
    func initData(){
        latest.reload()
        collection.reload()
        topic.reload()
    }
}

