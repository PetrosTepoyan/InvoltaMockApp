//
//  ContentClient.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation
import UIKit

final class ContentClient {
	
	enum ContentError: Error {
		case sessionError, emptyData, decodingError
	}
	
	static let session = URLSession.shared
	static let shared = ContentClient()
	
	private let joke_url = URL(string: "https://v2.jokeapi.dev/joke/Any?type=single&amount=10")!
	private let image_url = URL(string: "https://picsum.photos/500")!
	
	static func getJokes(completionHandler: @escaping (Result<[Joke], ContentError>) -> Void ) {
		var request = URLRequest(url: shared.joke_url)
		request.httpMethod = "GET"
		
		session.dataTask(with: request) { data, response, error in
			guard error == nil else {
				completionHandler(.failure(.sessionError))
				return
			}
			
			guard let data = data else {
				completionHandler(.failure(.emptyData))
				return
			}
			
			guard let jokeResponse = try? JSONDecoder().decode(JokeResponse.self, from: data) else {
				completionHandler(.failure(.decodingError))
				return
			}
			
			completionHandler(.success(jokeResponse.jokes))
			
			
		}.resume()
	}
	
	static func getImage(completionHandler: @escaping (Result<UIImage, ContentError>) -> Void ) {
		DispatchQueue.global(qos: .utility).async {
			guard let data = try? Data(contentsOf: shared.image_url) else {
				completionHandler(.failure(.emptyData))
				return
			}
			
			guard let image = UIImage(data: data) else {
				completionHandler(.failure(.decodingError))
				return
			}
			
			completionHandler(.success(image))
		}
	}
}
