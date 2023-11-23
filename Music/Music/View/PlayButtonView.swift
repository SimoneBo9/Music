//
//  PlayButtonView.swift
//  Music
//
//  Created by Simone Boni on 22/11/23.
//

import SwiftUI
import Combine
import AVFoundation

class PlayerViewModel: NSObject, ObservableObject {
    @Published var barprogress: Double = 0
    @Published var currentTime: TimeInterval = 0
    @Published var isPlaying: Bool = false
    var audioPlayer: AVAudioPlayer?

    private var cancellables: Set<AnyCancellable> = []

    override init() {
        super.init()
        setupAudioPlayer()
        setupTimerPublisher()
    }

    internal func setupAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "WorthATry", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.volume = 0.2 // Initial volume
            self.audioPlayer?.delegate = self
        } catch {
            print("Failed to initialize the audio player: \(error.localizedDescription)")
        }
    }

    private func setupTimerPublisher() {
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let player = self.audioPlayer, !self.isPlaying else { return }
                self.currentTime = player.currentTime
                self.barprogress = self.currentTime / player.duration

                // Forza l'aggiornamento della vista
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
            .store(in: &cancellables)
    }

    func playPause() {
        isPlaying.toggle()

        if isPlaying {
            audioPlayer?.play()
        } else {
            audioPlayer?.pause()
        }
    }

    func seekTo(seconds: TimeInterval) {
        audioPlayer?.currentTime = seconds
    }

    deinit {
        audioPlayer?.delegate = nil
        audioPlayer = nil
    }
}

extension PlayerViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            // Playback finished successfully
            // Implement any logic you need here
        } else {
            // Playback finished with an error
            print("Playback finished with an error.")
        }
    }
}

struct PlayButtonView: View {
    @StateObject private var viewModel = PlayerViewModel()
    @State private var volume: Double = 0.2
    private let range: ClosedRange<Double> = 0...1

    var body: some View {
        VStack(spacing: 35) {
            // ... (Rest of your UI code)

            HStack {
                // ... (Previous and next buttons)

                playButton
                    .tint(.black)
                    .onTapGesture {
                        viewModel.playPause()
                    }

                // ... (Forward button)
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
            if viewModel.audioPlayer == nil {
                viewModel.setupAudioPlayer()
            }
        }
        .onChange(of: volume) {
            viewModel.audioPlayer?.volume = Float($0)
        }
    }

    var playButton: some View {
        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
            .resizable()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    PlayButtonView()
}
