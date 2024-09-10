//
//  AppRoute.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Foundation
import SwiftUI

@Observable
class AppRoute {
    enum Route: Hashable {
        case photo(photo: Photo)
        case collection(collection: Collection)
        case topic(topic: Topic)
        case user(user: User)
        case listPhoto
        case listCollection
        case listTopic
    }
    
    var path: [Route] = []
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func back(){
        path.removeLast()
    }
}
