import SwiftUI

struct PreJoinView: View {
    
    //for dev only, to test using Preview
    //@EnvironmentObject private var model: MockCallContainerModel
    
    //prod
    @EnvironmentObject private var model: CallContainerModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image("dailyBot")
                .resizable()
                .frame(width: 64, height: 64)
            Text("Connect to an Daily Bot")
                .font(.headline)
            SecureField("Daily API Key", text: $model.dailyApiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .padding([.horizontal])
            TextField("Server URL", text: $model.backendURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .padding([.bottom, .horizontal])
            Button("Connect") {
                self.model.connect()
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.backgroundApp)
        .toast(message: model.toastMessage, isShowing: model.showToast)
    }
}

#Preview {
    PreJoinView().environmentObject(MockCallContainerModel())
}
