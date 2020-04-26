//
//  ViewController.swift
//  TingTing
//
//  Created by Vinh Pham on 12/14/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]){granted,error in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
    }
    
    @IBOutlet weak var waitTimeInput: UITextField!
    var sound : AVAudioPlayer?
    var checked = false
    
    func playSound(){
        let path = Bundle.main.path(forResource: "ting", ofType: "mp3")!
        let link = URL(fileURLWithPath: path)
        do{
            sound = try AVAudioPlayer(contentsOf: link)
            sound?.play()
        } catch {
            print("error")
        }
        
    }

    func sendNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.subtitle = "Hey wake up"
        content.body = "This is the text"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "notifcation.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func scheduleTaksed(at hour: Int, minute: Int, second: Int){
        
    }
    
    @IBAction func touchBegin(_ sender: UIButton) {
        
        guard let period = Double(waitTimeInput.text!) else {
               return
           }
        
        var checking = Timer()
        checked = !checked
        if checked{
            sender.setTitle("Stop", for: UIControl.State.normal)
            checking = Timer.scheduledTimer(withTimeInterval: period, repeats: true) {
                checking in self.playSound()
            }
            
        } else {
            sender.setTitle("Start", for: UIControl.State.normal)
            checking.invalidate()
        }
        
        sendNotification()
        
    }
}


