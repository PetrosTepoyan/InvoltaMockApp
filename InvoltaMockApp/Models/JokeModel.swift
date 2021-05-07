//
//  JokeModel.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation

class JokeModel: NSObject {
	var jokes: [Joke] = []
	
	var delegate: ContentModelDelegate?
	
	var cache = NSCache<AnyObject, Joke>()
	
	static let shared = JokeModel()
	
	func loadBatchJokes() {
		ContentClient.getJokes { result in
			DispatchQueue.main.async {
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
