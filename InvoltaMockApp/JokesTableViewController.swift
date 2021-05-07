//
//  JokesTableViewController.swift
//  InvoltaMockApp
//
//  Created by Петрос Тепоян on 5/7/21.
//

import UIKit

class JokesTableViewController: UITableViewController {

	var jokes: [Joke] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		ContentClient.getJokes { result in
			DispatchQueue.main.async {
				switch result {
					case .success(let jokes):
						self.jokes = jokes
						self.tableView.reloadData()
					case .failure(let error):
						debugPrint(error)
				}
			}
		}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return self.jokes.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.jokeCell, for: indexPath) as! JokeTableViewCell
		cell.configure(joke: jokes[indexPath.row])
		return cell
	}


}
