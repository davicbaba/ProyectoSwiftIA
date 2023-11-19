//
//  ChatViewModel.swift
//  OpenIaProyecto
//
//  Created by Davis Cruz on 11/18/23.
//

import Foundation
import SwiftOpenAI


class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
       private var openAI = SwiftOpenAI(apiKey: "My_API_KEY")

    func sendMessage(_ content: String) {
        let userMessage = Message(content: content, isFromUser: true)
        messages.append(userMessage)

        Task {
            do {
                
                var chatMessages: [MessageChatGPT] = []
                for message in messages {
                    let role: MessageRoleType = message.isFromUser ? .user : .assistant
                    chatMessages.append(.init(text: message.content, role: role))
                }

                
                let response = try await openAI.createChatCompletions(model: .gpt3_5(.turbo), messages: chatMessages)
                if let responseModel = response, let aiMessageText = responseModel.choices.first?.message.content {
                    DispatchQueue.main.async {
                        let aiMessage = Message(content: aiMessageText, isFromUser: false)
                        self.messages.append(aiMessage)
                    }
                }
            } catch {
                print("Error al obtener respuesta de OpenAI: \(error)")
            }
        }
    }

}
