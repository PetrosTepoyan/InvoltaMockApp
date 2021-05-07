//
//  ImagesTableViewModel.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation
import UIKit

class ImagesTableViewModel: NSObject {
	var images: [UIImage] = []

	var reloadData: (() -> ())!
	
	override init() {
		super.init()
	}
	
}

extension ImagesTableViewModel: UITableViewDataSource {
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
}
