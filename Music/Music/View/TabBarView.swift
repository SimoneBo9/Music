//
//  TabBarView.swift
//  Music
//
//  Created by Simone Boni on 15/11/23.
//

import SwiftUI

struct TabBarView: View {
    @State var tabSelection = 4

    var body: some View {
        TabView(selection: $tabSelection)
        {
            SecondView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Listen Now")
                }
                
                .tag(1)

            SecondView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Browse")
                }
                .tag(2)
            
            SecondView()
                .tabItem {
                    Image(systemName:"dot.radiowaves.left.and.right" )
                    Text("Radio")
                }
                .tag(3)
            
            ContentView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Library")
                }
                .tag(4)
            
            
            SecondView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(5)
        }
        .tint(.red)
        
    }
}


#Preview {
    TabBarView()
}
