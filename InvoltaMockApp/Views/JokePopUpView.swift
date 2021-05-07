//
//  JokePopUpView.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

protocol JokePopUpViewDelegate {
	func dismissPopUp()
}

class JokePopUpView: UIView {

	let label = UILabel()
	let closeButtonImageView = UIImageView()
	
	var delegate: JokePopUpViewDelegate?
	
	init() {
		super.init(frame: .zero)
		
		setupLayer()
		setupLabel()
		setupCloseButtonImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func displayJoke(joke: Joke) {
		self.label.text = joke.value
	}
	
	private func setupLayer() {
		backgroundColor = UIColor(named: "BlueBackground")
		layer.cornerRadius = 20
	}
 
	private func setupLabel() {
		addSubview(label)
		setupLabelConstraints()
		setupLabelAppearance()
		
	}
	
	private func setupLabelAppearance() {
		label.numberOfLines = 5
		label.font = UIFont(name: "Avenir", size: 19)!
		label.lineBreakMode = .byWordWrapping
		label.lineBreakStrategy = .standard
	}
	
	private func setupLabelConstraints() {
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			label.topAnchor.constraint(equalTo: topAnchor),
			label.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	private func setupCloseButtonImageView() {
		addSubview(closeButtonImageView)
		
		setupCloseButtonImageViewConstraints()
		setupCloseButtonImageViewAppearance()
		setupCloseButtonTapGesture()
	}
	
	private func setupCloseButtonImageViewAppearance() {
		closeButtonImageView.image = UIImage(systemName: "arrow.down.circle.fill")
		closeButtonImageView.isUserInteractionEnabled = true
		closeButtonImageView.tintColor = .gray
	}
	
	private func setupCloseButtonImageViewConstraints() {
		closeButtonImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			closeButtonImageView.heightAnchor.constraint(equalToConstant: 44),
			closeButtonImageView.widthAnchor.constraint(equalToConstant: 44),
			closeButtonImageView.topAnchor.constraint(equalTo: topAnchor),
			closeButtonImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	private func setupCloseButtonTapGesture() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(closeButtonImageViewTouchUpInside))
		closeButtonImageView.addGestureRecognizer(tap)
	}
	
	@objc private func closeButtonImageViewTouchUpInside(sender: UITapGestureRecognizer) {
		delegate?.dismissPopUp()
	}
}
