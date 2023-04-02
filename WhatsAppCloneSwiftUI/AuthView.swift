//
//  ContentView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Muhammet Kadir on 2.04.2023.
//

import SwiftUI
import Firebase
struct AuthView: View {
    let db = Firestore.firestore()
    @ObservedObject var userStore = UserStore()
    //@EnvironmentObject var userStore : UserStore
    @State var useremail = ""
    @State var password = ""
    @State var username = ""
    @State var showAuthView = true
    
    var body: some View {
        
        NavigationStack{
            if showAuthView{
                VStack{
                    VStack{
                        Image("wpicon")
                            .resizable()
                            .frame(width: 80,height: 80)
                        Text("WhatsApp")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        
                    }.frame(width: 100.w, height: 35.h).background(.green)
                    VStack(alignment: .center){
                        Spacer()
                        CustomTextField(placeholder: "Email" , param: $useremail).padding(.bottom,20)
                        CustomSecureField(placeholder: "Password" , param: $password).padding(.bottom,20)
                        CustomTextField(placeholder: "User Name" , param: $username).padding(.bottom,20)
                        
                        //login
                        Button(action:{
                            Auth.auth().signIn(withEmail: self.useremail, password: self.password) { Result, error in
                                if error != nil{
                                    print(error?.localizedDescription)
                                }else{
                                    self.showAuthView = false
                                }
                            }
                        }){
                            Text("Login").foregroundColor(.white)
                        }.frame(width: 80.w,height: 50).background(.green)
                            .cornerRadius(10).padding(.bottom,20)
                        
                        //sign up
                        Button(action:{
                            Auth.auth().createUser(withEmail: self.useremail, password: self.password) { result, error in
                                if error != nil {
                                    print("error : \(error!.localizedDescription)")
                                }else{
                                    // user screen
                                    var ref : DocumentReference? = nil
                                    
                                    let userDictionary : [String : Any] = ["username" : self.username,"useremail" : self.useremail, "userid" : result!.user.uid]
                                    ref = self.db.collection("Users").addDocument(data: userDictionary, completion: { error in
                                        if error != nil{
                                            print(error?.localizedDescription)
                                        }else{
                                            self.showAuthView = false
                                        }
                                    })
                                }
                            }
                        }){
                            Text("Sign Up").foregroundColor(.green)
                        }
                        Spacer()
                    }.frame(width: 100.w, height: 65.h).background(.white)
                }
            }else{
                NavigationView{
                    List(userStore.userArray){ user in
                        NavigationLink(destination: ChatView(userToChat: user)){
                            Text(user.name)
                        }
                    }
                }.navigationBarItems(leading: Button(action:{
                    do{
                        try Auth.auth().signOut()
                    }catch{
                        print("error")
                    }
                    self.showAuthView = true
                }){Text("Log Out")})
                .navigationBarTitle(Text("Chat with users!"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

struct CustomTextField : View {
    var placeholder : String
    @Binding var param : String
    
    var body: some View{
        return VStack(alignment: .leading){
            Text(placeholder).font(.callout).bold()
            TextField(placeholder, text: $param)
                .autocapitalization(.none)
                .frame(width:80.w)
                .padding(.bottom,8)
                .overlay(Rectangle()
                    .frame(width: 80.w,height: 1.5)
                    .foregroundColor(.green)
                    .padding(.top, 10), alignment: .bottom)
        }
    }
    
}

struct CustomSecureField : View {
    var placeholder : String
    @Binding var param : String
    
    var body: some View{
        return VStack(alignment: .leading){
            Text(placeholder).font(.callout).bold()
            SecureField(placeholder, text: $param)
                .autocapitalization(.none)
                .frame(width:80.w)
                .padding(.bottom,15)
                .overlay(Rectangle()
                    .frame(width: 80.w,height: 1.5)
                    .foregroundColor(.green)
                    .padding(.top, 10), alignment: .bottom)
        }
    }
    
}
