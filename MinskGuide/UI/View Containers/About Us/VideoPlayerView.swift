import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    let player: AVPlayer
    let didTapFullScreen: ((AVPlayer) -> Void)?
    
    func makeUIView(context: Context) -> VideoPlayerUIView {
        return VideoPlayerUIView(frame: .zero, player: player, didTapFullScreen: didTapFullScreen)
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) {
    }
    
    typealias UIViewType = VideoPlayerUIView
    
    class VideoPlayerUIView: UIView {
        private let playerLayer = AVPlayerLayer()
        private var player: AVPlayer?
        private var isPlaying = false
        private var didTapFullScreen: ((AVPlayer) -> Void)?
        
        init(frame: CGRect, player: AVPlayer, didTapFullScreen: ((AVPlayer) -> Void)?) {
            super.init(frame: frame)
            self.player = player
            self.didTapFullScreen = didTapFullScreen
            backgroundColor = .black
            playerLayer.player = player
            layer.addSublayer(playerLayer)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            addGestureRecognizer(tapGesture)
                        
            player.volume = 1.0
            
            configureAudioSession()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
        
        func play() {
            player?.play()
            isPlaying = true
        }
        
        func pause() {
            player?.pause()
            isPlaying = false
        }
        
        @objc private func handleTap() {
            if isPlaying {
                pause()
            } else {
                if let didTapFullScreen = didTapFullScreen {
                    didTapFullScreen(player!)
                } else {
                    play()
                }
            }
        }
        
        private func configureAudioSession() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set up audio session: \(error)")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            VideoPlayerView(player: loadVideo(), didTapFullScreen: nil)
                .frame(height: 300)
        }
    }
    
    func loadVideo() -> AVPlayer {
        guard let path = Bundle.main.path(forResource: "MinskTravelApp", ofType: "mp4") else {
            fatalError("Video file not found")
        }
        let url = URL(fileURLWithPath: path)
        return AVPlayer(url: url)
    }
}
