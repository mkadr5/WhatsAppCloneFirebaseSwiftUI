//
//  ChatRow.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Muhammet Kadir on 2.04.2023.
//

import SwiftUI
import Firebase

struct ChatRow: View {
    
    var chatMessage : ChatModel
    var userToChatFromChatView : UserModel
    
    var body: some View {
        
        Group {
            
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.userid{
                HStack{
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(.green).cornerRadius(10)
                }.padding(.horizontal, 1)
            }else if chatMessage.messageFrom == userToChatFromChatView.userid && chatMessage.messageTo == Auth.auth().currentUser!.uid{
                HStack{
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(.green).cornerRadius(10)
                    Spacer()
                }.padding(.horizontal, 1)
            }else{
                //
            }
            
        }.frame(width: 95.w)
        
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(id: 0, message: "", uidFromFirebase: "", messageFrom: "", messageTo: "", messageDate: Date(), messageFromMe: true), userToChatFromChatView: UserModel(id: 0, name: "", userid: ""))
    }
}
