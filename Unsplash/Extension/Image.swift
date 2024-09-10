//
//  Image.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 4/9/24.
//

import Foundation
import Kingfisher
import SwiftUI

extension KFImage {
    func placeholder(blurHash: String? = nil, color: String? = nil) -> KFImage {
        placeholder {
            if let blurHash {
                Image(blurHash: blurHash)?
                    .resizable()
            } else if let color {
                Color(hex: color)
            } else {
                Color.gray
            }
        }
    }
}
