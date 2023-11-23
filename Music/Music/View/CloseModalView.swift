//
//  CloseModalView.swift
//  Music
//
//  Created by Simone Boni on 19/11/23.
//

import SwiftUI
import AVFoundation

struct CloseModalView: View {
    let colorHelper = ColorHelper()
    @State private var currentTime : TimeInterval = 0.0
    @State private var totalTime : TimeInterval = 0.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(uiColor: colorHelper.dominantColor(from: UIImage(named: "Heart") ?? .dolphin) ?? .black)
                .blur(radius: 15, opaque: true)
                .opacity(0.8)
                .brightness(0.1)
                .ignoresSafeArea()

            GeometryReader { screen in
                VStack {
                    header
                        .padding(.top, screen.size.height/8)
                    Spacer()
                    player
                    PlayButtonView()
                        .foregroundStyle(.white)
                        Spacer()
                    buttons
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    private func timeString(time: TimeInterval) -> String{
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    var header: some View {
        VStack {
            Image("Heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 280, height: 280)
                .cornerRadius(13)
                .padding(.bottom)
                .onTapGesture {
                    dismiss()
                }
        }
    }
    
    var player: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("First song")
                        .bold()
                        .font(.title2)
//                    Text("Geolier")
//                        .opacity(0.8)
//                        .font(.callout)
                }
                Spacer()
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            .frame(height: 60)
        }
    }
    
    var buttons: some View {
        HStack {
            Spacer()
            Image(systemName: "quote.bubble")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            Spacer()
            Image(systemName: "airplayaudio")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            
            Spacer()
            Image(systemName: "list.bullet")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            Spacer()
        }
    }
    
}


#Preview {
    CloseModalView()
}
