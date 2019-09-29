//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by ChenJiCai on 2019/9/24.
//  Copyright © 2019 CJC. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "Sports": "🎃🤖🍏🍎🍐🍊🍋🍌🍉🍇",
        "Animals": "🙈🙉🙊🐵🐒🦍🐶🐕",
        "Faces": "😀😁😂🤣😃😄😅😆😉😊😋😎"
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
                
            }
        }
    }

}
