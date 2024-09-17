//
//  MovieTableViewCell.swift
//  Practice
//
//  Created by iApple Basement on 09/05/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
