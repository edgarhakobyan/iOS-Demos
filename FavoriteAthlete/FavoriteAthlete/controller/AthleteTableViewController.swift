//
//  AthleteTableViewController.swift
//  FavoriteAthlete
//
//  Created by Edgar on 13.04.22.
//

import UIKit

class AthleteTableViewController: UITableViewController {
    var athletes: [Athlete] = [
        Athlete(name: "test", age: 2, league: "premier", team: "barca"),
        Athlete(name: "test1", age: 4, league: "premier", team: "barca"),
        Athlete(name: "test2", age: 5, league: "premier", team: "barca"),
        Athlete(name: "test3", age: 8, league: "premier", team: "barca")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteCell", for: indexPath)

        let athlete = athletes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = athlete.name
        content.secondaryText = athlete.description
        cell.contentConfiguration = content

        return cell
    }
    
    @IBSegueAction func editSegue(_ coder: NSCoder, sender: Any?) -> AthleteFormViewController? {
        let athlete: Athlete?
        if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            athlete = athletes[indexPath.row]
        } else {
            athlete = nil
        }
        
        return AthleteFormViewController(coder: coder, athlete: athlete)
    }
    
    @IBAction func unwindToAthleteTableView(sender: UIStoryboardSegue) {
        guard let athleteViewController = sender.source as? AthleteFormViewController,
              let athlete = athleteViewController.athlete
        else {
            return
        }
        if let selectedIndex = tableView.indexPathForSelectedRow {
            athletes[selectedIndex.row] = athlete
        } else {
            athletes.append(athlete)
        }
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let vc = segue.destination as? AthleteFormViewController,
//              let cell = sender as? UITableViewCell,
//              let indexPath = tableView.indexPath(for: cell)
//        else {
//            return
//        }
//        vc.athlete = athletes[indexPath.row]
//    }
    

}
