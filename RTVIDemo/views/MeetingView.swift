import SwiftUI

struct MeetingView: View {
    
    //for dev only, to test using Preview
    //@EnvironmentObject private var model: MockCallContainerModel
    
    //prod
    @EnvironmentObject private var model: CallContainerModel
    
    var body: some View {
        VStack {
            // Header Toolbar
            HStack {
                Image("dailyBot")
                    .resizable()
                    .frame(width: 48, height: 48)
                Spacer()
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(timerString(from: self.model.timerCount))
                        .font(.headline)
                }.padding()
                    .background(Color.timer)
                    .cornerRadius(12)
            }
            .padding()
            
            // Main Panel
            VStack {
                VStack {
                    WaveformView(audioLevel: model.remoteAudioLevel, isConnected: model.isConnected, voiceClientStatus: model.voiceClientStatus)
                }
                .frame(maxHeight: .infinity)
                VStack {
                    MicrophoneView(audioLevel: model.localAudioLevel, isMuted: !self.model.isMicEnabled)
                        .frame(width: 120, height: 120)
                        .padding()
                        .onTapGesture {
                            self.model.toggleMicInput()
                        }
                }
                .frame(height: 120)
            }
            .frame(maxHeight: .infinity)
            .padding()
            
            // Bottom Panel
            VStack {
                // TODO: leaving it disabled for now, since we have not implemented it yet
                /**
                HStack {
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "chevron.right.square")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Commands")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .border(Color.buttonsBorder, width: 1)
                    .cornerRadius(12)
                    
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Settings")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .border(Color.buttonsBorder, width: 1)
                    .cornerRadius(12)
                }
                .foregroundColor(.black)
                .padding([.top, .horizontal])
                .disabled(true)
                 */
                
                Button(action: {
                    self.model.disconnect()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("End")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(12)
                .padding([.bottom, .horizontal])
            }
        }
        .background(Color.backgroundApp)
        .toast(message: model.toastMessage, isShowing: model.showToast)
    }
    
    func timerString(from count: Int) -> String {
        let minutes = count / 60
        let seconds = count % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    let mockModel = MockCallContainerModel()
    let result = MeetingView().environmentObject(mockModel)
    mockModel.startAudioLevelSimulation()
    return result
}
