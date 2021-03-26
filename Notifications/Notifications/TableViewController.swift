//
//  TableViewController.swift
//  Notifications
//
//  Created by Edgar on 03.03.21.
//

import UIKit

class TableViewController: UITableViewController {
    
    let notificationTypes = ["Local Notification",
                         "Local Notification with Action",
                         "Local Notification with Content",
                         "Push Notification with APNs",
                         "Push Notification with Firebase",
                         "Push Notification with Content"]
    
    let notification = Notification()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationTypes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = notificationTypes[indexPath.row]
        cell.textLabel?.textColor = .white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = .red
        
        let alertTitle = notificationTypes[indexPath.row]
        let alertController = UIAlertController(title: alertTitle,
                                                 message: "After 5 seconds \(alertTitle) will appear",
                                                 preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.notification.scheduleNotification(withType: alertTitle)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = .white
    }

}
