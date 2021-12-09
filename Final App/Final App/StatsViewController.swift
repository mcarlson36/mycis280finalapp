//
//  StatsViewController.swift
//  Final App
//
//  Created by Micah Carlson on 12/8/21.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var sessionsCompletedLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stats"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var sessions = 0
        var totalTime = 0
        let defaultsStats = UserDefaults.standard
        sessions = defaultsStats.integer(forKey: "sessions_completed")
        totalTime = defaultsStats.integer(forKey: "total_time_worked")
        sessionsCompletedLabel.text = String(sessions)
        totalTimeLabel.text = timeString(totalTime: TimeInterval(totalTime))
    }
    
    func timeString(totalTime:TimeInterval) -> String {
        let hours = Int(totalTime) / 3600
        let minutes = Int(totalTime) / 60 % 60
        let seconds = Int(totalTime) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    



}
