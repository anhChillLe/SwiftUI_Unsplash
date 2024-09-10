//
//  UserLikedViewModel\.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 9/9/24.
//

import Foundation
import SwiftUI

@Observable
class CurrentUserViewModel {
    var profile: CurrentUser? = nil
    var likeds: Set<Photo> = []
    var collections: [Collection] = []
    var photos: [Photo] = []
}
