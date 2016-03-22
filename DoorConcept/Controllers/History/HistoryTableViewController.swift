//
//  HistoryTableViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/20/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    var historyInteractor:HistoryInteractor = HistoryInteractor()
    var history:[History] = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        historyInteractor.getHistory { (data, error) -> Void in
            if error == nil{
                self.history = data as! [History]
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as! HistoryTableViewCell
        cell.configureCellWithHistory(history[indexPath.row])
        return cell
    }

}
