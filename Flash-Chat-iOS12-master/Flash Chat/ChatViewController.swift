//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    // Declare instance variables here

    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    var messageArray:[Message] = [Message]()
    var keyboardHeight: CGFloat = 0.0
    var textboxActualPosition: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        self.navigationItem.hidesBackButton = true

        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.register(UINib(nibName: "CustomMessageCellSenderTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "senderMessageCell")
        messageTableView.separatorStyle = .none
        
        // Register for getting notified when keyboard is shown.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        configureTableView()
        retrieveMessages()
    }
    
    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message =  messageArray[indexPath.row] as Message?
        var cell: UITableViewCell?
        
        if message?.senderName == Auth.auth().currentUser?.email as String? {
            let customcell = messageTableView.dequeueReusableCell(withIdentifier: "senderMessageCell", for: indexPath) as? CustomMessageCellSenderTableViewCell
            
            let messageObj:Message = messageArray[indexPath.row]
            customcell?.messageSender.text = messageObj.message
            customcell?.nameSender.text = messageObj.senderName
            customcell?.imageView2.image = UIImage(named: "egg")
            cell = customcell
        } else {
            let customcell = messageTableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as? CustomMessageCell
            
            let messageObj:Message = messageArray[indexPath.row]
            customcell?.messageBody.text = messageObj.message
            customcell?.senderUsername.text = messageObj.senderName
            customcell?.avatarImageView.image = UIImage(named: "egg")
            cell = customcell
        }
        
        return cell!
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.estimatedRowHeight = 120.0
        messageTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    ///////////////////////////////////////////
    //MARK:- TextField Delegate Methods
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3) {
//            print(self.keyboardHeight + self.textboxActualPosition)
//            self.heightConstraint.constant = self.keyboardHeight + self.textboxActualPosition
//            self.view.layoutIfNeeded()
//        }
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint.constant = self.textboxActualPosition
            self.view.layoutIfNeeded()
        }
    }

    
    ///////////////////////////////////////////
    //MARK: - Send & Recieve from Firebase
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        sendButton.isEnabled = false
        messageTextfield.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDic = ["Sender": Auth.auth().currentUser?.email,
                          "Message": messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDic) {
            (error, databaseReference) in
            
            if error != nil {
                print("Error sending message")
            } else {
                print("Sent Message")
                self.sendButton.isEnabled = true
                self.messageTextfield.isEnabled = true
                self.messageTextfield.text = ""
                self.retrieveMessages()
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        messageArray.removeAll()
        
        messageDB.observe(.childAdded) {
            (dataSnapshot) in
            
            let snapshotValue = dataSnapshot.value as! Dictionary<String, String>
                        
            let message = Message()
            message.message = snapshotValue["Message"]!
            message.senderName = snapshotValue["Sender"]!
            
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error signing out!")
        }        
    }

    @objc func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        UIView.animate(withDuration: 0.3) {
            print(self.keyboardHeight + self.textboxActualPosition)
            self.heightConstraint.constant = self.keyboardHeight + self.textboxActualPosition
            self.view.layoutIfNeeded()
        }
    }
    }
}
