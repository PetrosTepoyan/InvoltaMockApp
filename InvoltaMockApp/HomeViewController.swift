//
//  HomeViewController.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class HomeViewController: UIViewController {

	@IBOutlet weak var tableOfJokesButton: UIButton!
	@IBOutlet weak var randomJokeButton: UIButton!
	@IBOutlet weak var imagesTableView: UITableView!
	
	let imagesModel = ImagesModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagesTableView.dataSource = imagesModel
		imagesTableView.delegate = imagesModel
		imagesModel.delegate = self
		imagesModel.loadImage()
	}

}

extension HomeViewController : ImagesModelDelegate {
	func loadingCompleted() {
		imagesTableView.reloadData()
	}
}

