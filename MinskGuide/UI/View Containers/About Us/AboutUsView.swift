import SwiftUI
import AVKit

struct AboutUsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Minsk Travel App")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                    .navigationTitle("About Us")
                
                HStack {
                    if let videoURL = Bundle.main.url(forResource: "MinskTravelApp", withExtension: "mp4") {
                        let player = AVPlayer(url: videoURL)
                        VideoPlayerView(player: player, didTapFullScreen: { player in
                            let playerViewController = AVPlayerViewController()
                            playerViewController.player = player
                            
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let window = windowScene.windows.first else {
                                return
                            }
                            
                            window.rootViewController?.present(playerViewController, animated: true) {
                                player.play()
                            }
                        })
                        .frame(width: 300, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onAppear {
                            player.play()
                        }
                    } else {
                        Text("Video not found")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    AboutUsView()
}
