//
//  PhotoDetailViewModel.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Foundation
import Alamofire

@Observable
class PhotoDetailViewModel {
    var photo: Photo
    var fullPhoto: PhotoFull? = nil
    var isLoading: Bool = true
    var error: AFError? = nil
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func load(){
        Photo.get(id: photo.id){ result in
            switch result {
            case .success(let photoFull):
                self.fullPhoto = photoFull
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func like(onSuccess: @escaping (Photo) -> Void){
//        photo.likedByUser = true
        photo.like { result in
            switch result {
            case .success(let result):
                onSuccess(result.photo)
            case .failure(let error):
                print(error)
//                self.photo.likedByUser = false
            }
        }
    }
    
    func unLike(onSuccess: @escaping (Photo) -> Void){
//        photo.likedByUser = false
        photo.like { result in
            switch result {
            case .success(let result):
                onSuccess(result.photo)
            case .failure(let error):
//                self.photo.likedByUser = true
                print(error)
            }
        }
    }
}
