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
    
    // to upload the new post
    func uploadPost(withMessage message : String , forUid uid : String,withGroupKey groupKey : String?, sendComplete : @escaping (_ status :Bool)->()){
        
        if groupKey != nil {
            // send this to group ref
        } else {
            REF_FEED.childByAutoId().updateChildValues(["senderId" : uid,"contents" : message])
            sendComplete(true)
        }
    }
    
    // get messaged for feed
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
    func getUserName(forUid uid : String , handler : @escaping (_ username : String)-> () ) {
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(forSearchQuery query : String, handler : @escaping (_ email : [String])-> ()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (usersSnapshot) in
            
            guard let userSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIdForUserName(forUsernames userNames : [String], handler : @escaping (_ uidArray : [String])->() ) {
        
        REF_USERS.observeSingleEvent(of: .value) { (users) in
           var idArray = [String]()
            guard let userSnapshot = users.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if userNames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createGroup(withTitle title : String ,andDescription description : String,forIds uid :[String], handler : @escaping(_ groupCreated : Bool)-> ()) {
        
        REF_GROUPS.childByAutoId().updateChildValues(["title" : title,"description" : description,"members":uid])
        REF_GROUPS.observeSingleEvent(of: .childAdded) { (groupSnapshot) in
            
        }
        handler(true)
    }
    
    func getAllGroups(handler : @escaping (_ groupsArray : [Group])->()) {
        var groupArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for groups in groupSnapshot {
                let memberArray = groups.childSnapshot(forPath: "members").value as? [String]
                
                if memberArray!.contains((Auth.auth().currentUser?.uid)!) {
                    let description = groups.childSnapshot(forPath: "description").value as? String
                    let title = groups.childSnapshot(forPath: "title").value as? String
                    let group = Group(title: title!, description: description!, members: memberArray!, key: groups.key, membersCount: memberArray!.count)
                    groupArray.append(group)
                    
                }
                
            }
            handler(groupArray)
        }
    }
    
    func getEmail(forGroup group: Group, handler : @escaping (_ emailArray : [String])->()) {
        
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
            
        }
    }
}










