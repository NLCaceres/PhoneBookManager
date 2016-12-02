//
//  AddContactViewController.swift
//  PhoneBookManager
//
//  Created by Nicholas L Caceres on 11/30/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit

typealias addContactCompletionHandler = (String?, String?) -> ()

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    var addContactCH : addContactCompletionHandler?

    
    @IBOutlet weak var newContactNameTextField: UITextField!
    @IBOutlet weak var newContactNumberTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        if let addContactHandler = addContactCH {
            addContactHandler(nil, nil)
        }
        
        newContactNameTextField.text = nil
        newContactNumberTextField.text = nil
        self .dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let addContactHandler = addContactCH {
            addContactHandler(newContactNameTextField.text, newContactNumberTextField.text)
        }
        newContactNameTextField.text = nil
        newContactNumberTextField.text = nil
        
        self .dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let addContactHandler = addContactCH {
            addContactHandler(newContactNameTextField.text, newContactNumberTextField.text)
        }
        
        newContactNameTextField.text = nil
        newContactNumberTextField.text = nil
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((newContactNameTextField.text?.isEmpty)! || (newContactNumberTextField.text?.isEmpty)!) {
            saveButton.isEnabled = false
        }
        else {
            saveButton.isEnabled = true
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
