//
//  PlayButtonView.swift
//  Music
//
//  Created by Simone Boni on 22/11/23.
//

import SwiftUI
import AVFoundation

struct PlayButtonView: View {
    @State private var volume: Double = 0.2
    @State private var barprogress: Double = 0
    private let range: ClosedRange<Double> = 0...1
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    private let timerInterval = 0.1

    var body: some View {
        VStack(spacing: 35) {
            HStack {
                Spacer()
                Slider(value: $barprogress, in: range)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let width = UIScreen.main.bounds.width
                            let percent = min(max(value.location.x / width, 0), 1)
                            self.barprogress = percent
                            self.seekTo(seconds: self.barprogress * (audioPlayer?.duration ?? 0))
                        }
                    )
                    .onChange(of: barprogress) { _ in
                        if let player = self.audioPlayer {
                            self.currentTime = player.duration * self.barprogress
                        }
                    }
                Text("\(formatTime(currentTime)) / \(formatTime(audioPlayer?.duration ?? 0))")
                    .foregroundColor(.white)
                    .font(.caption)
                Spacer()
            }

            HStack {
                Spacer()
                Image(systemName: "backward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                Spacer()
                play
                    .tint(.black)
                Spacer()
                Image(systemName: "forward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                Spacer()
            }
            .frame(height: 60)
            .padding(.leading)
            .padding(.trailing)

            HStack {
                Image(systemName: "speaker.fill")
                Slider(value: $volume, in: range)
                Image(systemName: "speaker.wave.3.fill")
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .onAppear {
            guard let url = Bundle.main.url(forResource: "Worth a try", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                self.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
                self.audioPlayer?.volume = Float(volume)

                let timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
                    if let player = self.audioPlayer, !self.isPlaying {
                        self.currentTime = player.currentTime
                        self.barprogress = self.currentTime / player.duration
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            } catch {
                print("Failed to initialize the audio player: \(error.localizedDescription)")
            }
        }
        .onChange(of: volume) {
            audioPlayer?.volume = Float(volume)
        }
    }

    var play: some View {
        VStack {
            Button(action: {
                self.isPlaying.toggle()

                if self.isPlaying {
                    self.audioPlayer?.play()
                } else {
                    self.audioPlayer?.pause()
                }
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func seekTo(seconds: Double) {
        if let player = self.audioPlayer {
            let time = max(0, min(seconds, player.duration))
            player.currentTime = time
            self.currentTime = time
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
