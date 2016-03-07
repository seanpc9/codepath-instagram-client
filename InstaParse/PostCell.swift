//
//  PostCell.swift
//  InstaParse
//
//  Created by Sean Crenshaw on 3/6/16.
//  Copyright © 2016 Sean Crenshaw. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell
{
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}