//
//  BarView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 17/10/25.
//

import SwiftUI

struct BarView: View {
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [.green, .white], startPoint: .top , endPoint: .bottom).ignoresSafeArea()
            TabView() {
                ProfileView().tabItem {
                    Image(systemName: "person")
                    Text("profile")
                        .font(.title)
                }.tag(1)
                EventsView().tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                        .font(.title)
                }.tag(2)
            }
            
        }
    }
}

#Preview {
    BarView()
}
