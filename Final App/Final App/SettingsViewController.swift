//
//  SettingsViewController.swift
//  Final App
//
//  Created by Micah Carlson on 12/3/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var workTimeTextField: UITextField!
    @IBOutlet weak var breakTimeLength: UITextField!
    @IBOutlet weak var themeTextField: UITextField!
    
    let workTimes = [300, 600, 900, 1200, 1500, 1800, 2100, 2400, 2700]
    let breakTimes = [60, 120, 300, 600, 900]
    let themes = ["Traffic Light", "Black/White"]
    
    var workPickerView = UIPickerView()
    var breakPickerView = UIPickerView()
    var themePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"

        workTimeTextField.inputView = workPickerView
        breakTimeLength.inputView = breakPickerView
        themeTextField.inputView = themePickerView
        
        workTimeTextField.placeholder = ViewController().timeString(time: TimeInterval(maxWorkTime))
        breakTimeLength.placeholder = ViewController().timeString(time: TimeInterval(maxBreakTime))
        themeTextField .placeholder = theme
        
        workPickerView.delegate = self
        workPickerView.dataSource = self
        breakPickerView.delegate = self
        breakPickerView.dataSource = self
        themePickerView.delegate = self
        themePickerView.dataSource = self
        
        workPickerView.tag = 1
        breakPickerView.tag = 2
        themePickerView.tag = 3
    }
    
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return workTimes.count
        case 2:
            return breakTimes.count
        case 3:
            return themes.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            let minutes = Int(workTimes[row]) / 60 % 60
            let seconds = Int(workTimes[row]) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        case 2:
            let minutes = Int(breakTimes[row]) / 60 % 60
            let seconds = Int(breakTimes[row]) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        case 3:
            return themes[row]
        default:
            return "Error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            let minutes = Int(workTimes[row]) / 60 % 60
            let seconds = Int(workTimes[row]) % 60
            workTimeTextField.text = String(format:"%02i:%02i", minutes, seconds)
            maxWorkTime = workTimes[row]
            timerChanged = true
            workTimeTextField.resignFirstResponder()
        case 2:
            let minutes = Int(breakTimes[row]) / 60 % 60
            let seconds = Int(breakTimes[row]) % 60
            breakTimeLength.text = String(format:"%02i:%02i", minutes, seconds)
            maxBreakTime = breakTimes[row]
            timerChanged = true
            breakTimeLength.resignFirstResponder()
        case 3:
            themeTextField.text = themes[row]
            theme = themes[row]
            themeTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
}

