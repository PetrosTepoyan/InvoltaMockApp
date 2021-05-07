//
//  HomeButton.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class HomeButton: UIButton {
	
	private let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.5, animations: nil)
	
	func configureLayer() {
		tintColor = .white
//		backgroundColor = UIColor(named: "BlueBackground")
		backgroundColor = .white
		setTitleColor(.black, for: .normal)
		layer.cornerRadius = 20
	}
	
	private func squish(identity: Bool = true) {
		let factor: CGFloat = identity ? 1.0 : 0.9
		animator.addAnimations {
			self.transform = CGAffineTransform(scaleX: factor, y: factor)
		}
		animator.startAnimation()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		squish(identity: false)
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		squish()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		squish()
	}
}
