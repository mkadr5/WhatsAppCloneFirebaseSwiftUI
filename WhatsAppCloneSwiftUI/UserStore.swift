//
//  UserStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Muhammet Kadir on 2.04.2023.
//

import SwiftUI
import Firebase
import Combine

class UserStore : ObservableObject {
    let db = Firestore.firestore()
    var userArray : [UserModel] = []
    
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        db.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                self.userArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents{
                    if let userid = document.get("userid") as? String {
                        if let username = document.get("username") as? String{
                            let currentIndex = self.userArray.last?.id
                            let createdUser = UserModel(id: (currentIndex ?? -1) + 1, name: username, userid: userid)
                            print("created userid : \(createdUser.userid) currentid : \(Auth.auth().currentUser?.uid) ")
                            self.userArray.append(createdUser)
                            
                        }
                    }
                }
                self.didChange.send(self.userArray)
            }
        }
    }
}
