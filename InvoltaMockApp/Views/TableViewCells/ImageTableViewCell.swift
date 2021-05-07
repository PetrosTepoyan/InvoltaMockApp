//
//  ImageTableViewCell.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
	
	@IBOutlet weak var contentImageView: UIImageView!
	
	func configure(image: UIImage) {
		contentImageView.image = image
		contentImageView.contentMode = .scaleAspectFit
	}
}
