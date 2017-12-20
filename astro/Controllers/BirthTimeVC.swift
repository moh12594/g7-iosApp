//
//  BirthTimeVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class BirthTimeVC: UIViewController {

  @IBOutlet weak var birthTimeField: TextFielDate!
  var datePicker = UIDatePicker()
  var toolBar = UIToolbar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createDatePicker()
    // Do any additional setup after loading the view.
  }

  @IBAction func birthTimeFieldIsEditing(_ sender: Any) {
    birthTimeField.inputView = datePicker
    birthTimeField.inputAccessoryView = toolBar
  }
  
  
  func createDatePicker() {
    createToolBar()
    datePicker.datePickerMode = .time
    datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
  }
  
  @objc func datePickerValueChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    
    birthTimeField.text = dateFormatter.string(from: datePicker.date)
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
    dateFormatter.dateFormat = "h:mm a"
    
    birthTimeField.text = dateFormatter.string(from: Date()) // 2
    
    birthTimeField.resignFirstResponder()
  }
  
  @objc func doneButtonPressed(sender: UIBarButtonItem) {
    if (birthTimeField.text != "") {
      AuthService.instance.setBirthTime(birthTime: birthTimeField.text!)
      guard let bpVC = storyboard?.instantiateViewController(withIdentifier: "birthPlaceVC") else {return}
      present(bpVC, animated: true, completion: nil)
    }
    birthTimeField.resignFirstResponder()
  }
}
