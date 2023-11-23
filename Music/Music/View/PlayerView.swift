//
//  PlayerView.swift
//  Music
//
//  Created by Simone Boni on 16/11/23.
//

import SwiftUI


struct PlayerView: View {
    var body: some View {
        VStack {
            HStack {
                Image("Heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44)
                    .cornerRadius(2)
                    .offset(x: -70, y: 0)
                
                VStack(alignment: .leading) {
                    Text("First song")
                        
                        .frame(minWidth: 10,maxWidth: 80)
                        .offset(x: -65, y: -0)
//                    Text("Geolier")
//                        .frame(minWidth: 10,maxWidth: 80)
//                        .offset(x: -65, y: -0)
                    
                }
                .frame(width: 70)
                
                Image(systemName: "play.fill")
                    .font(.title)
                    .offset(x: 50, y: 2)
                
                Image(systemName: "forward.fill")
                .font(.title)
                .offset(x: 60, y: 2)
            }
            
        }
        .frame(maxWidth: 365, maxHeight: 40)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 365)
                .shadow(radius: 10)
                .blur(radius: 1)
                
            
        )
    }
    
    
}

#Preview {
    PlayerView()
}
