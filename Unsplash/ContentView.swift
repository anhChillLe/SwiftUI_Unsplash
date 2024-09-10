//
//  ContentView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 23/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm = PhotoViewModel()
    @State var authorization = Authorization()
    @State var currentUserViewModel = CurrentUserViewModel()
    
    func deepLinkHandler(url: URL){
        guard let code = AuthorizeAction.urlCodeHandler(url: url) else {return}
        authorization.login(code: code)
    }
    
    var body: some View {
        if vm.isIniting {
            SplashView().onAppear(perform: vm.initData)
        } else {
            RootStack()
                .environment(vm)
                .environment(authorization)
                .environment(currentUserViewModel)
                .onOpenURL(perform: deepLinkHandler)
        }
    }
}

#Preview {
    ContentView()
}
