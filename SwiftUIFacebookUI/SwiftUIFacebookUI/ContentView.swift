//
//  ContentView.swift
//  SwiftUIFacebookUI
//
//  Created by wesley s favarin on 06/07/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct Post {
    let id: Int
    let username, text, profileImageName,imageName,hour: String
    
    static let samplePosts: [Post] = [
        .init(id: 1, username: "ToN", text: "Passeio muito legal em uma praia na asia.", profileImageName: "dog1", imageName: "Asia", hour:"Postado 15 minutos atrás"),
        .init(id: 2, username: "Flokinho", text: "Viagem de férias em Vancouver, inesquecivel.", profileImageName: "cat1", imageName: "Vancouver", hour:"Postado 5 horas atrás"),
        .init(id: 3, username: "Mel", text: "Todo mundo passando frio ai no Brasil e eu aqui em miami nesse calor.", profileImageName: "cat2", imageName: "miami1", hour:"Postado 8 horas atrás"),
        .init(id: 4, username: "Mark", text: "Olá pessoal a Disney é um sonho", profileImageName: "mark", imageName: "disney1", hour:"Postado 1 minuto atrás"),
        .init(id: 5, username: "ToN", text: "Passeio muito legal em uma praia na asia.", profileImageName: "dog1", imageName: "Asia", hour:"Postado 3 minutos atrás")
        
    ]
}

struct Group {
    let id: Int
    let name, imageName: String
    
    static let sampleGroups: [Group] = [
        .init(id: 1, name: "ToN", imageName: "miami1"),
        .init(id: 2, name: "Flokinho", imageName: "Asia"),
        .init(id: 3, name: "Mel", imageName: "Vancouver"),
        .init(id: 4, name: "Cherri", imageName: "disney1"),
        .init(id: 5, name: "Bibinha", imageName: "miami1"),
        .init(id: 6, name: "Tarzan", imageName: "Asia"),
        .init(id: 7, name: "Falcão", imageName: "Vancouver"),
        .init(id: 8, name: "Nina", imageName: "miami1")
       
    ]
}

struct ContentView : View {
    
    let posts = Post.samplePosts
    
    var body: some View {
        NavigationView {
            List {
                VStack (alignment: .leading) {
                    Text("Historias").font(.headline).padding(.leading, 16).padding(.bottom, 4)
                    ScrollView (showsHorizontalIndicator: false) {
                        HStack {
                            ForEach(Group.sampleGroups.identified(by: \.imageName)) { group in
                                
                                NavigationButton(destination: GroupDetailView(group: group)) {
                                    GroupView(group: group).padding(.trailing, 8)
                                }
                                
                            }
                            }.padding(.leading, 16).padding(.trailing, 8)
                        }.frame(height: 180)
                    }.padding(.top, 8).padding(.leading, -20).padding(.trailing, -20)
                
                ForEach(posts.identified(by: \.id)) { post in
                    PostView(post: post).padding(.bottom)
                }
            }.navigationBarTitle(Text("Facebook"), displayMode: .automatic)
        }
    }
}

struct GroupDetailView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName)
            Text(group.name)
        }.navigationBarTitle(Text(group.name))
    }
}

struct GroupView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName).renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(5).clipped()
            Text(group.name).color(.primary).lineLimit(2).frame(width: 100, height: 50, alignment: .leading).font(.headline)
        }
    }
}

struct PostView: View {
    let post: Post
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Image(post.profileImageName).resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped().scaledToFit()
                VStack (alignment: .leading) {
                    Text(post.username).font(.headline)
                    Text(post.hour).font(.body)
                    }.padding(.leading, 8)
                }.padding(.leading, 16)
            Text(post.text).padding(.leading, 16).padding(.trailing, 36).lineLimit(nil)
            
            Image(post.imageName, bundle: nil)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
        }.padding(.leading, -20).padding(.trailing, -20).padding(.top, 12).padding(.bottom, -26)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .dark)
    }
}
#endif
