import SwiftUI
import RTVIClientIOS
import RTVIClientIOSDaily

struct CameraButtonView: View {
    var trackId: MediaTrackId? // Current audio level
    var isMuted: Bool // Muted state

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let circleSize = width * 0.9
            let innerCircleSize = width * 0.82

            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: circleSize)
                
                if (!isMuted){
                    DailyVideoView(voiceClientTrack: trackId, videoScaleMode: .fill)
                        .aspectRatio(1, contentMode: .fit)
                } else {
                    Circle()
                        .fill(Color.disabledVision)
                        .frame(width: innerCircleSize)
                    Image("vision")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.3)
                        .foregroundColor(.green)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the ZStack is centered
        }
    }
}

#Preview {
    CameraButtonView(trackId: nil, isMuted: true)
}
