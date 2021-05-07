//
//  JokesTableViewController.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class JokesTableViewController: UITableViewController,
								JokeModelDelegate {
	
	var jokeModel = JokeModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		jokeModel.delegate = self
		jokeModel.loadBatchJokes()
    }
	
	func loadingCompleted() {
		tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return jokeModel.jokes.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.jokeCell, for: indexPath) as! JokeTableViewCell
		cell.configure(joke: jokeModel.jokes[indexPath.row])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		print(indexPath.row, jokeModel.jokes.count)
		guard indexPath.row >= jokeModel.jokes.count - 3 else { return }
		print("loading jokes...")
		jokeModel.loadBatchJokes()
	}


}
