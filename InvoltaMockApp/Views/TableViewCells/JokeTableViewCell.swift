//
//  JokeTableViewCell.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class JokeTableViewCell: UITableViewCell {

	@IBOutlet weak var jokeLabel: UILabel!
	
	func configure(joke: Joke) {
		jokeLabel.text = joke.value
		
	}
}
