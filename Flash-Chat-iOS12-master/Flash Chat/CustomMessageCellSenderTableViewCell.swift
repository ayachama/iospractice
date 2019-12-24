//
//  CustomMessageCellSenderTableViewCell.swift
//  Flash Chat
//
//  Created by Avinash Yachamaneni on 10/1/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class CustomMessageCellSenderTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBackgroundSender: UIView!
    @IBOutlet weak var messageSender: UILabel!
//    @IBOutlet weak var imageSender: UIImageView!
    @IBOutlet weak var nameSender: UILabel!
    
    @IBOutlet weak var imageView2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
