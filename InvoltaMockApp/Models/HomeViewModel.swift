//
//  HomeViewModel.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation
import UIKit

struct HomeViewModel {
	
	let animationDuration: Double = 0.5
	
	let animator: UIViewPropertyAnimator!
	
	let imagesModel = ImagesModel.shared
	
	var isReadyForAnimation: Bool {
		return animator.state == .inactive ||
				animator.fractionComplete > 0.85
	}
	
	func abortCurrentAnimation() {
		if animator.isRunning {
			animator.stopAnimation(true)
			animator.finishAnimation(at: .current)
		}
	}
	
	init() {
		animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.83, animations: nil)
	}
	
	func getPopUp() -> JokePopUpView {
		let jokePopUp = JokePopUpView()
		ContentClient.getJokes { result in
			DispatchQueue.main.async {
				switch result {
					case .success(let jokes):
						guard let joke = jokes.first else { return }
						jokePopUp.displayJoke(joke: joke)
					case .failure(let error):
						print(error)
				}
			}
		}
		return jokePopUp
	}
}
