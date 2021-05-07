//
//  ImagesModel.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation
import UIKit

class ImagesModel: NSObject {
	var images: [UIImage] = []
	
	weak var delegate: ContentModelDelegate?
	
	var cache = NSCache<AnyObject, UIImage>()
	
	static let shared = ImagesModel()
	
	override init() {
		super.init()
	}
	
	func loadImage() {
		ContentClient.getImage { result in
			DispatchQueue.main.async {
				switch result {
					case .success(let image):
						self.cache.setObject(image, forKey: self.images.count as AnyObject)
						self.images.append(image)
						self.delegate?.loadingCompleted()
					case .failure(let error):
						debugPrint(error)
				}
			}
		}
	}
}

extension ImagesModel: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return images.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.imageCell, for: indexPath) as! ImageTableViewCell
		let image = images[indexPath.row]
		cell.configure(image: image)
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		// Decided to do prefetching here, its simply faster to implement
		guard indexPath.row >= images.count - 4 else { return }
		let nextIndex = indexPath.row + 1
		if cache.object(forKey: nextIndex as AnyObject) == nil {
//			print("loading new image...")
			loadImage()
		} else{
//			print("getting image from cache...")
		}
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.frame.width + 20
	}
}
