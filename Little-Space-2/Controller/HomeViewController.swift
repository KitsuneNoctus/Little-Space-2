//
//  HomeViewController.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/8/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HomeViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view
    }
    @IBAction func play(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
