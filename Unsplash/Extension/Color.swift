//
//  Extension.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 6/9/24.
//

import Foundation
import SwiftUI

extension Color {
    static func textColor(for background: Color) -> Color {
        let uiColor = UIColor(background) // Chuyển đổi Color sang UIColor
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        // Công thức tính độ sáng (luminance) theo tiêu chuẩn WCAG
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue

        // Nếu độ sáng cao, dùng màu đen, ngược lại dùng màu trắng
        return luminance > 0.5 ? .black : .white
    }
    
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
