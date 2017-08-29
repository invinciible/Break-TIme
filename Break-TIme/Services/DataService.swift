//
//  DataService.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 29/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS : DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED : DatabaseReference{
        return _REF_FEED
    }
    
    func createDbUser(uid : String,userData : Dictionary<String,Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message : String , forUid uid : String,withGroupKey groupKey : String?, sendComplete : @escaping (_ status :Bool)->()){
        
        if groupKey != nil {
            // send this to group ref
        } else {
            REF_FEED.childByAutoId().updateChildValues(["senderId" : uid,"contents" : message])
            sendComplete(true)
        }
    }
    func getAllFeedMessage(handler : @escaping (_ message : [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "contents").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
            }
        }
    
}










