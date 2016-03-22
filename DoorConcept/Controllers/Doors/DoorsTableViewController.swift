//
//  BuildingsTableViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell
import DZNEmptyDataSet

class DoorsTableViewController: UITableViewController {

    @IBOutlet weak var btnAdd: UIBarButtonItem!
    let doorInteractor = DoorsInteractor()
    var doors:[Door] = [Door]()
    var building:Building!
    
    override func viewDidLoad() {
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource   = self
    }
    
    override func viewWillAppear(animated: Bool) {
        loadDoors()
    }
    
    /**
     Check if the actual instance contains a building (Detail view), and then load the buildings
     */
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

    /**
     redirect to AddDoorsViewController
     
     - parameter sender: event sender => UIButton
     */
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


// MARK: - SESlideTableViewCellDelegate
// Handle the delete event (dragging left on the cells)
extension DoorsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        doorInteractor.deleteDoor(doors[cell.tag])
        self.loadDoors()
    }
}

// MARK: - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
// Style for empty state
extension DoorsTableViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_doors")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Oops!!"
        let infoStr       = NSMutableAttributedString(string: str)
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(18, weight: 0.7), range: NSMakeRange(0, str.characters.count))
        infoStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.DCThemeColorMain(), range: NSMakeRange(0, str.characters.count))
        return infoStr as NSAttributedString
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "There’s no doors yet, add a new one\nclicking in the + button, only if you're the building's owner."
        let infoStr       = NSMutableAttributedString(string: str)
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14, weight: 0.1), range: NSMakeRange(0, str.characters.count))
        infoStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.DCThemeColorMain(), range: NSMakeRange(0, str.characters.count))
        return infoStr as NSAttributedString
    }
    
    func backgroundColorForEmptyDataSet(scrollView: UIScrollView!) -> UIColor! {
        return UIColor.whiteColor()
    }
    
    func emptyDataSetShouldFadeIn(scrollView: UIScrollView!) -> Bool {
        return true
    }
}