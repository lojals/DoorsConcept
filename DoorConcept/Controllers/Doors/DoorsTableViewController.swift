//
//  BuildingsTableViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell

class DoorsTableViewController: UITableViewController {

    @IBOutlet weak var btnAdd: UIBarButtonItem!
    let doorInteractor = DoorsInteractor()
    var doors:[Door] = [Door]()
    var building:Building!
    
    override func viewWillAppear(animated: Bool) {
        loadDoors()
    }
    
    func loadDoors(){
        if building != nil{
            doorInteractor.getDoorsByBuilding(building) { (data, error) -> Void in
                if error == nil{
                    self.doors = data as! [Door]
                    self.tableView.reloadData()
                }else{
                    print(error)
                }
            }
            
            if building.owner == UserService.sharedInstance.currentUser{
                btnAdd.enabled = true
            }else{
                btnAdd.enabled = false
            }
            
        }else{
            doorInteractor.getDoors({ (data, error) -> Void in
                if error == nil{
                    self.doors = data as! [Door]
                    self.tableView.reloadData()
                }else{
                    print(error)
                }
            })
            btnAdd.enabled = false
        }
    }

    @IBAction func AddDoor(sender: AnyObject) {
        let addDoorView      = self.storyboard?.instantiateViewControllerWithIdentifier("AddDoorsViewController") as! AddDoorsViewController
        addDoorView.building = self.building
        self.navigationController?.pushViewController(addDoorView, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell      = tableView.dequeueReusableCellWithIdentifier("DoorCell", forIndexPath: indexPath) as! DoorsTableViewCell
        cell.delegate = self
        cell.tag      = indexPath.row
        cell.configureCellWithDoor(doors[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let doorDefault  = DoorDetailViewController()
        doorDefault.door = doors[indexPath.row]
        self.navigationController?.showViewController(doorDefault, sender: self)
    }
}


extension DoorsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        doorInteractor.deleteDoor(doors[cell.tag])
        self.loadDoors()
    }
}