//
//  GameOverSceneViewController.swift
//  BattleShipGame
//
//  Created by Perez Willie Nwobu on 1/25/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class GameOverSceneViewController: UIViewController {

    
//    @IBAction func settingButton(_ sender: Any) {
//    }
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var looserLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var middleShipImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
