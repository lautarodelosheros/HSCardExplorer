//
//  SplashView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import SwiftUI

struct SplashView: View {
    @State var isSetUpDone: Bool = false
    
    var body: some View {
        VStack {
            if self.isSetUpDone {
                MainView()
            } else {
                Text("Splash Screen!")
            }
        }
        .onAppear {
            HearthstoneAPIClient.shared.getToken {
                withAnimation {
                    self.isSetUpDone = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
