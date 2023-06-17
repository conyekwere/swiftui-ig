//
//  FeedCellViewModel.swift
//  swiftUIInstagram
//
//  Created by Chima onyekwere on 6/16/23.
//

import SwiftUI

class FeedCellViewModel:ObservableObject {
    @Published var post : Post
    //Cannot assign value of type "self.post = post" to type '[Post]' because when you are init a model as a arg you can only call an instance
    
    
    
    var likeString: String {
        let label =  post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    init(post:Post) {
        self.post = post
    }
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = self.post.id else {return}
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).setData([:]){ _ in
            COLLECTION_USERS.document(uid).collection("user-likes")
                .document(postId).setData([:]){ _ in
                    COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes + 1])
                    
                    self.post.didLike = true
                    self.post.likes += 1
                }
        }
        print("Liked Post")
        
    }
    
    func unlike() {  print("Like Post")}
    
    func checkIfUserLikedPost() {}
}
