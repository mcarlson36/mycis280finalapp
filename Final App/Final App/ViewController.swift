//
//  ViewController.swift
//  Final App
//
//  Created by Micah Carlson on 12/2/21.
//

import UIKit
import AVFoundation
import AudioToolbox

var maxWorkTime = 1500
var maxBreakTime = 300
var theme = "Traffic Light"
var timerChanged = false
var sessionsCompleted = 0
var totalTimeWorked = 0

let defaults = UserDefaults.standard

class ViewController: UIViewController {
    
    @IBOutlet weak var pomodoroLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var workBreakIndicator: UILabel!
    
    var timer = Timer()
    var time = maxWorkTime
    var isTimerStarted = false
    var resumeTapped = false
    var isWorking = true
    
    @IBAction func startBtnTapped(_ sender: Any) {
        if isTimerStarted == false {
            startTimer()
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            startTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func restartBtnTapped(_ sender: AnyObject? ) {
        timer.invalidate()
        time = maxWorkTime
        isWorking = true
        pomodoroLabel.text = timeString(time: TimeInterval(time))
        workBreakIndicator.text = "Get to Work"
        isTimerStarted = false
        pauseButton.isEnabled = false
        self.startButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        self.view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
       updateTheme()
        if (timerChanged == true) {
            self.restartBtnTapped(nil)
            timerChanged = false
        }
    }
    
    func startTimer(){
        isTimerStarted = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        pauseButton.isEnabled = true
    }
    
    @objc func updateTimer(){
        if time < 1 {
            if isWorking == true {
                isWorking = false
                time = maxBreakTime
                AudioServicesPlaySystemSound(SystemSoundID(1304))
                workBreakIndicator.text = "Take a break"
                updateTheme()
            } else {
                isWorking = true
                time = maxWorkTime
                AudioServicesPlaySystemSound(SystemSoundID(1304))
                workBreakIndicator.text = "Get to Work"
                updateTheme()
                sessionsCompleted += 1
                defaults.set(sessionsCompleted, forKey: "sessions_completed")
            }
        } else {
            time -= 1
            if (isWorking) {
                totalTimeWorked += 1
            }
            defaults.set(totalTimeWorked, forKey: "total_time_worked")
            pomodoroLabel.text = timeString(time: TimeInterval(time))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func updateTheme(){
        if (theme == "Traffic Light" && isWorking == true) {
            self.view.backgroundColor = UIColor.green
            pomodoroLabel.textColor = UIColor.black
            workBreakIndicator.textColor = UIColor.black
        } else if (theme == "Black/White" && isWorking == true) {
            self.view.backgroundColor = UIColor.black
            pomodoroLabel.textColor = UIColor.white
            workBreakIndicator.textColor = UIColor.white
        } else if (theme == "Traffic Light" && isWorking == false) {
            self.view.backgroundColor = UIColor.red
            pomodoroLabel.textColor = UIColor.black
            workBreakIndicator.textColor = UIColor.black
        } else if (theme == "Black/White" && isWorking == false) {
            self.view.backgroundColor = UIColor.white
            pomodoroLabel.textColor = UIColor.black
            workBreakIndicator.textColor = UIColor.black
        }
    }


}

