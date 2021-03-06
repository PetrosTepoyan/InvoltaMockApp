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

	private static let session = URLSession.shared

	private static let joke_url = URL(string: "https://v2.jokeapi.dev/joke/Any?type=single&amount=10")!
	private static let image_url = URL(string: "https://picsum.photos/500")!

	private static var jokeDataTask: URLSessionDataTask?

	static func getJokes(completionHandler: @escaping (Result<[Joke], ContentError>) -> Void ) {

		guard jokeDataTask == nil || jokeDataTask?.state == .completed else { return }

		jokeDataTask = session.dataTask(with: joke_url) { data, response, error in
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


		}

		jokeDataTask!.resume()

	}

	static func getImage(completionHandler: @escaping (Result<UIImage, ContentError>) -> Void ) {
		DispatchQueue.global(qos: .utility).async {
			guard let data = try? Data(contentsOf: image_url) else {
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


