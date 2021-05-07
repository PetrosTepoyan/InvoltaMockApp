//
//  JokeModel.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation

class JokeModel: NSObject {
	var jokes: [Joke] = []
	
	weak var delegate: ContentModelDelegate?
	
	var cache = NSCache<AnyObject, Joke>()
	
	static let shared = JokeModel()
	
	func loadBatchJokes() {
		ContentClient.getJokes { result in
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				// Below, we are accessing the attributes, especially the delegate with self. Although I think we do not need [weak self], it will not harm if we have it. 
				switch result {
					case .success(let jokes):
						
						for joke in jokes {
							self.cache.setObject(joke, forKey: self.jokes.count as AnyObject)
						}
						
						self.jokes.append(contentsOf: jokes)
						self.delegate?.loadingCompleted()
					case .failure(let error):
						debugPrint(error)
				}
			}
		}
	}
}
