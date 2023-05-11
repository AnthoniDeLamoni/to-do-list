//
//  EntryViewController.swift
//  to do list
//
//  Created by Alif on 10/05/23.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    // Fungsi jika user menekan tombol add atau + ;
    @objc func didTapSaveButton() {
        if let texts = textField.text, !texts.isEmpty {
            let date = datePicker.date
            
            // Script buat nginput data ke database
            realm.beginWrite()
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = texts
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("Something added")
        }
    }

}
