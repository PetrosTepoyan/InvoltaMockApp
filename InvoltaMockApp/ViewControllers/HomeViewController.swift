//
//  HomeViewController.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class HomeViewController: UIViewController {

	@IBOutlet weak var tableOfJokesButton: HomeButton!
	@IBOutlet weak var randomJokeButton: HomeButton!
	@IBOutlet weak var imagesTableView: UITableView!
	@IBOutlet weak var hStackView: UIStackView!
	private var jokePopUp: JokePopUpView!
	private var blurView: UIVisualEffectView!
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	let viewModel = HomeViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		activityIndicator.startAnimating()
		
		imagesTableView.dataSource = viewModel.imagesModel
		imagesTableView.delegate = viewModel.imagesModel
		viewModel.imagesModel.delegate = self
		viewModel.imagesModel.loadImage()
		setupBlurStackViewBackground()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		setupButtons()
	}
	
	@IBAction func randomJokeButtonTouchUpInside(_ sender: Any) {
		
		guard viewModel.isReadyForAnimation else { return }
		viewModel.abortCurrentAnimation()
		
		prepareBlurViewForAnimation()
		prepareJokePopUpForAnimation()
		
		viewModel.animator.addAnimations {
			self.jokePopUp.center = self.view.center
			self.jokePopUp.transform = .identity
			self.blurView.alpha = 1.0
		}
		
		viewModel.animator.startAnimation()
	}
	
	private func setupButtons() {
		
		view.bringSubviewToFront(hStackView)
		
		randomJokeButton.configureLayer()
		self.randomJokeButton.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
		self.randomJokeButton.alpha = 0.0
		
		tableOfJokesButton.configureLayer()
		self.tableOfJokesButton.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
		self.tableOfJokesButton.alpha = 0.0
		
		viewModel.animator.addAnimations {
			self.randomJokeButton.transform = .identity
			self.tableOfJokesButton.transform = .identity
			
			self.randomJokeButton.alpha = 1.0
			self.tableOfJokesButton.alpha = 1.0
		}
		
		viewModel.animator.startAnimation(afterDelay: 0.2)
	}
	
	private func setupBlurStackViewBackground() {
		let blurView = UIBlurEffect(style: .systemUltraThinMaterial)
		let blurLayer = UIVisualEffectView(effect: blurView)
		view.insertSubview(blurLayer, at: 1)
		
		blurLayer.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			blurLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			blurLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			blurLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			blurLayer.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: -10)
		])
	}
	
	private func prepareBlurViewForAnimation() {
		blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark) )
		view.addSubview(blurView)
		blurView.frame = view.frame
		blurView.alpha = 0.0
	}
	
	private func prepareJokePopUpForAnimation() {
		jokePopUp = viewModel.getPopUp()
		jokePopUp.delegate = self
		view.addSubview(jokePopUp)
		
		jokePopUp.frame.size = CGSize(width: view.frame.width - 20, height: 200)
		jokePopUp.center = view.center
		jokePopUp.center.y += view.frame.height
		jokePopUp.transform = CGAffineTransform(rotationAngle: -0.5)
	}

}

extension HomeViewController : ContentModelDelegate {
	func loadingCompleted() {
		imagesTableView.reloadData()
		activityIndicator.stopAnimating()
	}
}

extension HomeViewController : JokePopUpViewDelegate {
	func dismissPopUp() {
		viewModel.animator.addAnimations {
			self.jokePopUp.center.y += self.view.frame.height
			self.jokePopUp.transform = CGAffineTransform(rotationAngle: -0.5)
			self.blurView.alpha = 0.0
		}
		
		viewModel.animator.addCompletion { position in
			self.jokePopUp.removeFromSuperview()
			self.jokePopUp = nil
			
			self.blurView.removeFromSuperview()
			self.blurView = nil
		}
		
		
		viewModel.animator.startAnimation()
	}
}

