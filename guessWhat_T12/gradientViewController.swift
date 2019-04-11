//
//  gradientViewController.swift
//  guessWhat_T12
//
//  Created by Harry Archer on 2019-04-11.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class gradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: .blue, colorTwo: .white)
        
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
