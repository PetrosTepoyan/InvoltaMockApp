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
	private var jokePopUp: JokePopUpView!
	private var blurView: UIVisualEffectView!
	
	let viewModel = HomeViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagesTableView.dataSource = viewModel.imagesModel
		imagesTableView.delegate = viewModel.imagesModel
		viewModel.imagesModel.delegate = self
		viewModel.imagesModel.loadImage()
	}
	
	@IBAction func randomJokeButtonTouchUpInside(_ sender: Any) {
		blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark) )
		view.addSubview(blurView)
		blurView.frame = view.frame
		blurView.alpha = 0.0
		
		jokePopUp = viewModel.getPopUp()
		view.addSubview(jokePopUp)
		
		jokePopUp.frame.size = CGSize(width: view.frame.width - 20, height: 200)
		jokePopUp.center = view.center
		jokePopUp.center.y += view.frame.height
		jokePopUp.transform = CGAffineTransform(rotationAngle: -0.5)
		viewModel.animator.addAnimations {
			self.jokePopUp.center = self.view.center
			self.jokePopUp.transform = .identity
			self.blurView.alpha = 1.0
		}
		
		viewModel.animator.startAnimation()
	}

}

extension HomeViewController : ImagesModelDelegate {
	func loadingCompleted() {
		imagesTableView.reloadData()
	}
}

