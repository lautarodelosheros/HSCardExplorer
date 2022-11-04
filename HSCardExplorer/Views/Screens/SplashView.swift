//
//  SplashView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import SwiftUI

struct SplashView: View {
    @State var isSetUpDone = false
    @State var isOnError = false
    
    func initializeSession() {
        HearthstoneAPIClient.shared.initializeSession { error in
            guard !error else {
                isOnError.toggle()
                return
            }
            withAnimation {
                self.isSetUpDone = true
            }
        }
    }
    
    var body: some View {
        VStack {
            if self.isSetUpDone {
                MainView()
            } else {
                Text("Splash Screen!")
            }
        }
        .alert("There was an error", isPresented: $isOnError) {
            Button("Retry") {
                initializeSession()
            }
        }
        message: {
            Text("Care to try again?")
        }
        .onAppear {
            initializeSession()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
