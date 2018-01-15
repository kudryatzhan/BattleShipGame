//
//  NewGameViewController.swift
//  BattleShipGame
//
//  Created by Perez Willie Nwobu on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit
import AVFoundation

class InitialGameViewController: UIViewController {
    
    
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    var musicIsPlaying : Bool = true
    
    //ModelPopUp
    @IBOutlet var SettingsView: UIView!
    
    
    //OptionsOnModelPopUp
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var Disability: UIView!
    
    @IBAction func soundSwitch(_ sender: UISwitch) {
        if (sender.isOn == true)
       {
        soundPlayer.play()
        }else {
           soundPlayer.pause()
       }
    }
    
    
    
    
    
    
    
    
    
    //Blur Effect
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    //ShipimagesthatWillMoveOnTheMainPage
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    var effect:UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.alpha = 0
        self.dismissImages()
       
    
        //playAudio
       self.playMusic()
        
        nameView.layer.borderWidth = 1.5
        nameView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        nameView.layer.cornerRadius = 12
        
        countryView.layer.borderWidth = 1.5
        countryView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        countryView.layer.cornerRadius = 12
        
        soundView.layer.borderWidth = 1.5
        soundView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        soundView.layer.cornerRadius = 12
        
        Disability.layer.borderWidth = 1.5
        Disability.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        Disability.layer.cornerRadius = 12
        
    }
    
    func bringSetting(){
        self.view.addSubview(SettingsView)
        SettingsView.center = view.center
        SettingsView.layer.cornerRadius = 15
        SettingsView.alpha = 0
        visualEffectView.alpha = 1
        
        
        UIView.animate(withDuration: 0.4) {
            self.SettingsView.alpha = 1
            
        }
        
    }
    
    
    func removeSetting(){
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
        }) { (sucess:Bool) in
            self.SettingsView.removeFromSuperview()
        }
    }
    
    @IBAction func soloButtontapped(_ sender: Any) {
    }
    @IBAction func twoPlayerButtonTapped(_ sender: Any) {
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        bringSetting()
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        removeSetting()
        
    }
    
    
    
    
    func playMusic(){
        
        do{
            
            //FIXME: - FIX THE DESTINATION OF THE FILE
            guard let audioPath = Bundle.main.path(forResource: "BattleSong", ofType: "mp3") else {return}
            try soundPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath) as URL)
            
        }
        catch{
            //report an error
        }
        if musicIsPlaying == true{
            
        soundPlayer.numberOfLoops = 1000
            soundPlayer.play()
        }
    }
    
    //dismissImages
    func dismissImages(){
        imageLogo.isHidden = true
        UIView.animate(withDuration: 17) {
            self.topImage.frame.origin.x -= 400
        }
        
        UIView.animate(withDuration: 17, animations: {
            self.bottomImage.frame.origin.x += 400
        }) { (sucess) in
            if sucess {
                self.imageLogo.isHidden = false
            }
        }
        
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
