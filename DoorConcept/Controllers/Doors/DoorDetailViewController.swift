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

    var btnOpen:FUIButton!

    var progress:UIProgressView!
    var tblGrantedUsers:UITableView!

    var informationContainer:DoorInformation!
    var bigContainer:UIView!
    
    let hasTable:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Door super cool"
        self.view.backgroundColor = UIColor.whiteColor()
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    func addUIComponents(){
        progress                   = UIProgressView()
        progress.trackTintColor    = UIColor.lightGrayColor()
        progress.progressTintColor = UIColor.DCThemeColorMain()
        progress.progress          = 0.0
        progress.translatesAutoresizingMaskIntoConstraints =  false
        self.view.addSubview(progress)
        
        
        bigContainer = UIView()
        bigContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bigContainer)
        
        informationContainer = DoorInformation(frame: CGRectZero)
        informationContainer.translatesAutoresizingMaskIntoConstraints = false
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
        
        if hasTable{
            tblGrantedUsers.delegate        = self
            tblGrantedUsers.dataSource      = self
            tblGrantedUsers.separatorColor  = UIColor.DCThemeColorMain()
            tblGrantedUsers.translatesAutoresizingMaskIntoConstraints = false
            let nib = UINib(nibName: "GrantedUserTableViewCell", bundle: nil)
            tblGrantedUsers.registerNib(nib, forCellReuseIdentifier: "GrantedUserCell")
            self.view.addSubview(tblGrantedUsers)
        }
    }

    func addUIConstraints(){
        let views = ["progress":progress,"bigContainer":bigContainer,"informationContainer":informationContainer,"btnOpen":btnOpen,"tblGrantedUsers":tblGrantedUsers]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.progress, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .TopMargin, multiplier: 1, constant: 0))
        
        if hasTable{
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
    
    func openDoor(){
        progress.setProgress(1, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension DoorDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GrantedUserCell", forIndexPath: indexPath) as! GrantedUserTableViewCell
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
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 81
    }
    
    func grantUser(){
        print("Adding a new user")
    }
}
