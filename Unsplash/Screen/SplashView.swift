//
//  SplashView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { length, _ in length * 0.3 }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 2) {
                Text("Unsplash")
                    .font(.title2)
                    .bold()
                Text("By chillle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }.offset(y: -32)
        }
    }
}

#Preview {
    SplashView()
}
