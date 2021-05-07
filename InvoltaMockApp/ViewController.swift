//
//  ViewController.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableOfJokesButton: UIButton!
	@IBOutlet weak var randomJokeButton: UIButton!
	@IBOutlet weak var imagesTableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		ContentClient.getJokes { result in
			switch result {
				case .success(let jokes):
					print(jokes)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
		
		ContentClient.getImage { result in
			switch result {
				case .success(let image):
					print(image)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}


}

