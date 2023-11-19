import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText: String = ""
    @Namespace private var messageNamespace

    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: viewModel.messages.count) { _ in

                        if let lastMessage = viewModel.messages.last {
                            withAnimation {
                                scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }

            HStack {
                TextField("Escribe un mensaje...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    viewModel.sendMessage(messageText)
                    messageText = ""
                }) {
                    Text("Enviar")
                }
                .padding()
            }
        }
    }
}

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
