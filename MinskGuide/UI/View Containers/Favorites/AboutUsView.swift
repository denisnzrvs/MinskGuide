import SwiftUI
import AVKit

struct AboutUsView: View {
    var body: some View {
        NavigationStack() {
            Text("Minsk Travel App")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding()
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)

                .navigationTitle("About Us")
            HStack {
                VideoPlayerView(player: AVPlayer()) { player in
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let window = windowScene.windows.first else {
                        return
                    }
                    
                    window.rootViewController?.present(playerViewController, animated: true, completion: {
                        player.play()
                    })
                }
                .frame(width: 125, height: 125)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
        }
    }
}

#Preview {
    AboutUsView()
}
