//
//  ImageTableViewCell.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
	
	@IBOutlet weak var contentImageView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(image: UIImage) {
		contentImageView.image = image
		contentImageView.contentMode = .scaleAspectFit
	}
	
	

}
