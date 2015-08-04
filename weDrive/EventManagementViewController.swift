//
//  EventManagementViewController.swift
//  weDrive
//
//  Created by Michelle Lau on 21/07/2015.
//  Copyright (c) 2015 michelle. All rights reserved.
//

import UIKit
import CoreData

class EventManagementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {

    @IBOutlet weak var eventListTableView: UITableView!
    
    var eventlist : [Event] = []
    var selectedEvent : Event? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventListTableView.dataSource = self
        self.eventListTableView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Event")
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            self.eventlist = results! as [Event]
        }
    }
    
//    func createEvent(){
//        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
//        
//        var event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: context) as Event
//        
//        event.name = "Picnic On Sunday!"
//        event.from = "anu"
//        event.people = "ahsjdh"
//        event.previewimage = UIImageJPEGRepresentation(UIImage(named:"Tidbinbilla.jpg"), 1)
//        
//        context.save(nil)
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var event = self.eventlist[indexPath.row]
        cell.textLabel!.text = event.name
        cell.imageView!.image = UIImage(data: event.previewimage)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedEvent = self.eventlist[indexPath.row]
        self.performSegueWithIdentifier("eventDetialSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "eventDetialSegue" {
            var detailViewController = segue.destinationViewController as EventDetailViewController
            detailViewController.event = self.selectedEvent
        } 
    }

}

