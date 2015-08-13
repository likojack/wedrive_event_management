//
//  CreateEventViewController.swift
//  weDrive
//
//  Created by Michelle Lau on 21/07/2015.
//  Copyright (c) 2015 michelle. All rights reserved.
//

import UIKit
import CoreData

class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    var people : [String] = []
    
    var name : String = ""
    var note : String = ""
    var from : String = ""
    var to : String = ""
    var selectedDate : String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var coverTapRecognizer = UITapGestureRecognizer(target: self, action: "coverTapped")
        self.coverImage.addGestureRecognizer(coverTapRecognizer)
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.nameTextField.text = self.name
        self.fromTextField.text = self.from
        self.toTextField.text = self.to
        self.noteTextField.text = self.note

    }
    
    func coverTapped() {
       launchCamera()
    }
    
    func launchCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            var photoViewController = UIImagePickerController()
            photoViewController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            photoViewController.delegate = self
            self.presentViewController(photoViewController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.coverImage.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: context) as! Event
        event.name = self.nameTextField.text
        event.people = self.people
        event.from = self.fromTextField.text
        event.to = self.toTextField.text
        event.note = self.noteTextField.text
        event.previewimage = UIImageJPEGRepresentation(self.coverImage.image,1)
        event.time = selectedDate
        context.save(nil)
        self.performSegueWithIdentifier("backToManageSegue", sender: self)
    }
    
    @IBAction func contactTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("contactListSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "contactListSegue" {
            var contactListViewController = segue.destinationViewController as! ContactListViewController
            contactListViewController.name = self.nameTextField.text
            contactListViewController.from = self.fromTextField.text
            contactListViewController.to = self.toTextField.text
            contactListViewController.note = self.noteTextField.text
            
        }
    }
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBAction func dataPickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(DatePicker.date)
        self.selectedDate = strDate
        
    }
}
