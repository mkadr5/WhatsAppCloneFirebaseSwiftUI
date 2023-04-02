//
//  ChatView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Muhammet Kadir on 2.04.2023.
//

import SwiftUI
import Firebase
struct ChatView: View {
    let db = Firestore.firestore()

    var userToChat : UserModel
    @State var messageToSend = ""
    
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(chatStore.chatArray){chats in
                    ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                }
            }
            
            HStack{
                TextField("Message here ..",text: $messageToSend).frame(minHeight: 30).padding()
                Button(action: sendMessage){
                    Text("Send")
                }.frame(minHeight: 50).padding()
            }
        }
    }
    func sendMessage(){
        if self.messageToSend.isEmpty {
            
        }else{
            var ref : DocumentReference? = nil
            
            let myChatDictionary : [String : Any] = ["chatUserFrom" : Auth.auth().currentUser!.uid, "chatUserTo" : userToChat.userid, "date" : generateDate(),"message" : self.messageToSend]
            
            ref = self.db.collection("Chats").addDocument(data: myChatDictionary, completion: { error in
                if error != nil {
                    print(error!.localizedDescription)
                }else{
                    self.messageToSend = ""
                }
            })
        }
    }
    func generateDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(id: -1, name: "bb", userid: "21313dasd"))
    }
}
