//
//  Joke.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import Foundation

struct JokeResponse: Decodable {
	let jokes: [Joke]
}

class Joke: Decodable {
	let value: String
	
	enum CodingKeys: String, CodingKey {
		case value = "joke"
	}
}
