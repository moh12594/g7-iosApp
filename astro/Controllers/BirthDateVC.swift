//
//  BirthDateVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import Firebase

class BirthDateVC: UIViewController {

  @IBOutlet weak var dateTextField: UITextField!
  var datePicker = UIDatePicker()
  var toolBar = UIToolbar()
  @IBOutlet weak var textLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createDatePicker()

//    textLabel.text = "Hello Michael 🖖🏽 What's your birthday " as String
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DataService.instance.getUsername(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUsername) in
      self.textLabel.text = "Let's start with your birthday, \(returnedUsername) 🎁" as String
    }
  }
  
  @IBAction func beginEditingTextField(_ sender: Any) {
    dateTextField.inputView = datePicker
    dateTextField.inputAccessoryView = toolBar
  }
  
  func createDatePicker() {
    createToolBar()
    datePicker.datePickerMode = .date
    datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
  }
  
  @objc func datePickerValueChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    dateTextField.text = dateFormatter.string(from: datePicker.date)
  }
  
  func createToolBar() {
    toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    
    let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonPressed(sender:)))
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
    label.text = "Choose your Date"
    
    let labelButton = UIBarButtonItem(customView:label)
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    
    toolBar.setItems([todayButton,flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
  }
  
  @objc func todayButtonPressed(sender: UIBarButtonItem) {
    let dateFormatter = DateFormatter() // 1
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    dateTextField.text = dateFormatter.string(from: Date()) // 2
    
    dateTextField.resignFirstResponder()
  }
  
  @objc func doneButtonPressed(sender: UIBarButtonItem) {
    if (dateTextField.text != "") {
      AuthService.instance.setBirthDate(birthDate: dateTextField.text!)
      guard let btVC = storyboard?.instantiateViewController(withIdentifier: "birthTimeVC") else {return}
      present(btVC, animated: true, completion: nil)
    }
    dateTextField.resignFirstResponder()
  }
}
