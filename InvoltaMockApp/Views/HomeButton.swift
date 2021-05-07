//
//  HomeButton.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class HomeButton: UIButton {
	
	func configureLayer() {
		tintColor = .white
		backgroundColor = UIColor(named: "BlueBackground")
		layer.cornerRadius = 20
	}
	
}
