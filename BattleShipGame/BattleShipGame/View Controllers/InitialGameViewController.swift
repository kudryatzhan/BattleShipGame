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
    
    static let shared = InitialGameViewController()
    
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    var musicIsPlaying : Bool = true
    
    //ModelPopUp
    @IBOutlet var SettingsView: UIView!
    
    
    //OptionsOnModelPopUp
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var soundView: UIView!

    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        soundPlayer.pause()
    }
    
    //ShipimagesthatWillMoveOnTheMainPage
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    //contraints
    func ConstrainButtons(){
        //ButtomImage
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: bottomImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 1).isActive = true
        
        NSLayoutConstraint(item: bottomImage, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.90, constant: 1).isActive = true
        
        NSLayoutConstraint(item: bottomImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.35, constant: 1).isActive = true
        
        NSLayoutConstraint(item: bottomImage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.98, constant: 0).isActive = true

        
        //TwoButtons
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: buttonStackView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 1).isActive = true
//0.16
        NSLayoutConstraint(item: buttonStackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.10, constant: 1).isActive = true
        
        NSLayoutConstraint(item: buttonStackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.80, constant: 1).isActive = true
        
        NSLayoutConstraint(item: buttonStackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 1).isActive = true

        //topImage
        topImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: topImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 1).isActive = true
        
        NSLayoutConstraint(item: topImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.35, constant: 1).isActive = true
        
        NSLayoutConstraint(item: topImage, attribute: .bottom, relatedBy: .equal, toItem: buttonStackView, attribute: .top, multiplier: 0.95, constant: 1).isActive = true
        
        NSLayoutConstraint(item: topImage, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.90, constant: 1).isActive = true
        
        //BattleShipLogo
        
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: imageLogo, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 1).isActive = true
        
        NSLayoutConstraint(item: imageLogo, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.35, constant: 1).isActive = true
        
        NSLayoutConstraint(item: imageLogo, attribute: .bottom, relatedBy: .equal, toItem: buttonStackView, attribute: .top, multiplier: 0.95, constant: 1).isActive = true
        
        NSLayoutConstraint(item: imageLogo, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.90, constant: 1).isActive = true
        
        //SettingButton
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: settingsButton, attribute:.height , relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.05, constant: 1).isActive = true
        
//        NSLayoutConstraint(item: settingsButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.11, constant: 1).isActive = true
//
         NSLayoutConstraint(item: settingsButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.05, constant: 1).isActive = true
        
        NSLayoutConstraint(item: settingsButton, attribute: .leading, relatedBy: .equal, toItem: topImage , attribute: .leading, multiplier: 1, constant: 1).isActive = true
        
    }
    
    var effect:UIVisualEffect!
    
    
    //VIEW DID LOAD!!!
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.alpha = 0
        
        
        ConstrainButtons()
        
        //playAudio
       self.playMusic()
        
        nameView.layer.borderWidth = 1.5
        nameView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        nameView.layer.cornerRadius = 12
        
//        countryView.layer.borderWidth = 1.5
//        countryView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
//        countryView.layer.cornerRadius = 12
        
        soundView.layer.borderWidth = 1.5
        soundView.layer.borderColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        soundView.layer.cornerRadius = 12
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dismissImages()
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
//    @IBAction func twoPlayerButtonTapped(_ sender: Any) {
//        
//        dismissImages()
//    }
    
    @IBAction func settingsButton(_ sender: Any) {
        bringSetting()
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        removeSetting()
        
    }
    
   
    
    func playMusic() {

        guard let asset = NSDataAsset(name: "BattleSong.mp3")
            else { return }
        
        do{

            soundPlayer = try AVAudioPlayer(data: asset.data)

            if musicIsPlaying == true {
            //soundPlayer.prepareToPlay()
                soundPlayer.numberOfLoops = 1000
            soundPlayer.play()
            } else {
                soundPlayer.pause()
            }
                
            } catch let error as NSError {
                print(error.description)
            }
        }
    
            
        
    
    //dismissImages
    func dismissImages(){
        imageLogo.isHidden = true
        
        UIView.animate(withDuration: 17) {
            //self.topImage.frame.origin.x
            self.topImage.center.x -= 400
            
        }
        
        
        UIView.animate(withDuration: 17, animations: {
            self.bottomImage.center.x += 400
        }) { (sucess) in
            if sucess {
                self.imageLogo.isHidden = false
            }
        }
        
    }
 //PerezFile
}
