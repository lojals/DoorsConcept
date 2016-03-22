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

class BuildingsTableViewController: UITableViewController {
    let buildingInteractor = BuildingsInteractor()
    var buildings:[Building] = [Building]()
    
    override func viewDidLoad() {
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource   = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadBuildings()
    }
    
    func loadBuildings(){
        buildingInteractor.getBuildings { (data, error) -> Void in
            if error == nil{
                self.buildings = data as! [Building]
                self.tableView.reloadData()
            }else{
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell      = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as! BuildingsTableViewCell
        cell.delegate = self
        cell.tag      = indexPath.row
        cell.configureCellWithBuilding(buildings[indexPath.row])
        return cell
    }
}

// MARK: - SESlideTableViewCellDelegate
extension BuildingsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        buildingInteractor.deleteBuilding(buildings[cell.tag])
        self.loadBuildings()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let doorView      = self.storyboard?.instantiateViewControllerWithIdentifier("DoorsTableViewController") as! DoorsTableViewController
        doorView.building = buildings[indexPath.row]
        self.navigationController?.pushViewController(doorView, animated: true)
    }
}

// MARK: - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
// Handle the empty state
extension BuildingsTableViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_buildings")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Oops!!"
        let infoStr       = NSMutableAttributedString(string: str)
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(18, weight: 0.7), range: NSMakeRange(0, str.characters.count))
        infoStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.DCThemeColorMain(), range: NSMakeRange(0, str.characters.count))
        return infoStr as NSAttributedString
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "There’s no buildings yet, add a new one\nclicking in the + button."
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