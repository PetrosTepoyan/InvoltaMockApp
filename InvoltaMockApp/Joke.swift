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

struct Joke: Decodable {
	let joke: String
}
