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
	
	let imagesModel = ImagesTableViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagesTableView.dataSource = imagesModel
		imagesTableView.delegate = imagesModel
		imagesModel.reloadData = imagesTableView.reloadData
		imagesModel.loadImage()
	}

}

