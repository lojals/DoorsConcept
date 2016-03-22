//
//  DoorDetailViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/19/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class DoorDetailViewController: UIViewController {
    var doorInteractor:DoorsInteractor      = DoorsInteractor()
    var historyInteractor:HistoryInteractor = HistoryInteractor()
    var btnOpen:FUIButton!

    var progress:UIProgressView!
    var tblGrantedUsers:UITableView!

    var informationContainer:DoorInformation!
    var bigContainer:UIView!
    
    var isOwner:Bool = false
    var door:Door!
    var permissions:[Permision] = [Permision]()
    
    /**
     Check if current user is owner of the door, then add the UIComponents and Contraints
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if door.building?.owner == UserService.sharedInstance.currentUser{
            isOwner = true
        }else{
            isOwner = false
        }
        
        self.title = door.doorName!
        self.view.backgroundColor = UIColor.whiteColor()
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadPermissions()
    }
    
    /**
     Load the current door permissions, to show if current user is owner
     */
    private func loadPermissions(){
        doorInteractor.getPermissionsByDoor(door) { (data, error) -> Void in
            if error == nil {
                self.permissions = data as! [Permision]
                self.tblGrantedUsers.reloadData()
            }else{
                print(error!)
            }
        }
    }
    
    private func addUIComponents(){
        progress                   = UIProgressView()
        progress.trackTintColor    = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1)
        progress.progressTintColor = UIColor.DCThemeColorMain()
        progress.progress          = 0.0
        progress.translatesAutoresizingMaskIntoConstraints =  false
        self.view.addSubview(progress)
        
        bigContainer = UIView()
        bigContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bigContainer)
        
        informationContainer = DoorInformation(frame: CGRectZero, door: self.door)
        informationContainer.translatesAutoresizingMaskIntoConstraints = false
        informationContainer.setTransacStatus(.Ready)
        bigContainer.addSubview(informationContainer)
        
        btnOpen = FUIButton()
        btnOpen.setTitle("Open", forState: .Normal)
        btnOpen.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnOpen.setImage(UIImage(named: "btn_open_icon"), forState: .Normal)
        btnOpen.setImage(UIImage(named: "btn_open_icon"), forState: .Highlighted)
        btnOpen.buttonColor  = UIColor.DCThemeColorMain()
        btnOpen.shadowColor  = UIColor.DCThemeColorDarkMain()
        btnOpen.shadowHeight = 7.0
        btnOpen.translatesAutoresizingMaskIntoConstraints = false
        btnOpen.addTarget(self, action: Selector("openDoor"), forControlEvents: .TouchUpInside)
        self.view.addSubview(btnOpen)
        
        tblGrantedUsers = UITableView()
        
        if isOwner{
            tblGrantedUsers.delegate        = self
            tblGrantedUsers.dataSource      = self
            tblGrantedUsers.separatorColor  = UIColor.DCThemeColorMain()
            tblGrantedUsers.translatesAutoresizingMaskIntoConstraints = false
            let nib = UINib(nibName: "GrantedUserTableViewCell", bundle: nil)
            tblGrantedUsers.registerNib(nib, forCellReuseIdentifier: "GrantedUserCell")
            self.view.addSubview(tblGrantedUsers)
        }
    }

    /**
     Add UIConstraint and handle different constraints if user is owner or not.
     */
    private func addUIConstraints(){
        let views = ["progress":progress,"bigContainer":bigContainer,"informationContainer":informationContainer,"btnOpen":btnOpen,"tblGrantedUsers":tblGrantedUsers]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.progress, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .TopMargin, multiplier: 1, constant: 0))
        
        if isOwner{
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[progress(7)][bigContainer(141)][btnOpen(72)][tblGrantedUsers]|", options:  NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tblGrantedUsers]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        }else{
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[progress(7)][bigContainer][btnOpen(72)]|", options:  NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        }

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[progress]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[btnOpen]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bigContainer]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.bigContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[informationContainer(304)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.bigContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[informationContainer(141)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.bigContainer.addConstraint(NSLayoutConstraint(item: self.informationContainer, attribute: .CenterX, relatedBy: .Equal, toItem: self.bigContainer, attribute: .CenterX, multiplier: 1, constant: 0))
        self.bigContainer.addConstraint(NSLayoutConstraint(item: self.informationContainer, attribute: .CenterY, relatedBy: .Equal, toItem: self.bigContainer, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
    
    /**
     Send to the fake server the intension to open the current door
     */
    func openDoor(){
        btnOpen.enabled = false
        let doorServer  = DoorServerSimulator(responseDelegate: self)
        doorServer.openDoor(door, user: UserService.sharedInstance.currentUser!)
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.progress.progress = 1
            self.progress.layoutIfNeeded()
        })
    }
    
    /**
     Set different states to the UI
     
     - parameter status: Valid DoorTransacStatus
     */
    func setTransacStatus(status:DoorTransacStatus){
        switch(status){
            case .Authorized: informationContainer.setTransacStatus(.Authorized)
                              historyInteractor.saveHistory(self.door, user: UserService.sharedInstance.currentUser!, state: "authorized")
            case .Denied:     informationContainer.setTransacStatus(.Denied)
                              progress.progressTintColor = UIColor.alizarinColor()
                              historyInteractor.saveHistory(self.door, user: UserService.sharedInstance.currentUser!, state: "denied")
            case .Ready:      informationContainer.setTransacStatus(.Ready)
                              progress.progressTintColor = UIColor.DCThemeColorMain()
        }
    }
}

// MARK: - DoorServerSimulatorResponse
extension DoorDetailViewController:DoorServerSimulatorResponse{
    
    /**
     Response from the fake server, it contains the transaction status.
     
     - parameter opened: door Opened (?)
     */
    func doorServerOpenedDoor(opened: Bool) {
        if opened{
            self.setTransacStatus(.Authorized)
        }else{
            self.setTransacStatus(.Denied)
        }
    }
    
    /**
     After closed response is received, ready state is loaded in the UI.
     */
    func doorJustClosed() {
        btnOpen.enabled = true
        self.setTransacStatus(.Ready)
        self.progress.progress = 0
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension DoorDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GrantedUserCell", forIndexPath: indexPath) as! GrantedUserTableViewCell
        cell.configureCellWithUser(permissions[indexPath.row].user!)
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header             = UIView()
        header.backgroundColor = UIColor.whiteColor()
        
        let title              = UILabel()
        title.font             = UIFont.boldSystemFontOfSize(20)
        title.text             = "Granted Users"
        title.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(title)
        
        let addBtn       = UIButton(type: .ContactAdd)
        addBtn.tintColor = UIColor.DCThemeColorMain()
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.addTarget(self, action: Selector("grantUser"), forControlEvents: .TouchUpInside)
        header.addSubview(addBtn)
        
        header.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[title]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["title":title]))
        header.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[addBtn]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addBtn":addBtn]))
        header.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[title][addBtn]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["title":title,"addBtn":addBtn]))
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 81
    }
    
    /**
     Display an UIAlertController asking the username for permission.
     */
    func grantUser(){
        let alertVC : UIAlertController = UIAlertController(title: "Give some permission!", message: "Type the username you want to give access to this door!", preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Username ex: Test.1"
        }
        alertVC.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {  (alert: UIAlertAction!) in
            if let textField = alertVC.textFields?.first{
                self.doorInteractor.givePermission(textField.text!, door: self.door, completion: { (error) -> Void in
                    if error == nil {
                        self.loadPermissions()
                    }else{
                        print(error!)
                    }
                })
            }}))
        alertVC.addAction(UIAlertAction(title: "Cancel", style:.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
}
