//
//  ViewController.swift
//  PhoneBookManager
//
//  Created by Nicholas L Caceres on 11/30/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // simple use of coredata
    
    @IBOutlet weak var tableView: UITableView!
    var ContactList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        do {
            ContactList = try managedContext!.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        let contact = ContactList[indexPath.row]
        
        cell?.textLabel?.text = contact.value(forKey: "name") as! String?
        cell?.detailTextLabel?.text = contact.value(forKey: "number") as! String?
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let deletedContact = ContactList.remove(at: indexPath.row)
            
            do {
                managedContext.delete(deletedContact)
                try managedContext.save()
            } catch {
                print("Error Saving")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            let addContactVC = navigationController.viewControllers.first as? AddContactViewController
            addContactVC?.addContactCH = { newContactName, newContactNumber in
                if let NewContactName = newContactName {
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let managedContext = appDelegate.persistentContainer.viewContext
                    
                    let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)
                    
                    let contact = NSManagedObject(entity: entity!, insertInto: managedContext)
                    
                    contact.setValue(NewContactName, forKey: "name")
                    contact.setValue(newContactNumber, forKey: "number")
                    
                    do {
                        try managedContext.save()
                        self.ContactList.append(contact)
                        self.tableView.reloadData()
                        
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }
    
}

