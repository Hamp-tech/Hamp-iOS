//
//  RatingViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class RatingViewController: HampViewController {

    //MARK: IB Properties
    @IBOutlet weak var startStackView: UIStackView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.7)
    }
    
    //MARK: Actions
    @IBAction func starWasSelected(_ sender: UIButton) {
        print(sender.tag)
        startStackView.arrangedSubviews.forEach{ ($0 as! UIButton).isSelected = false }
        for i in 0..<sender.tag {
            (startStackView.arrangedSubviews[i] as! UIButton).isSelected = true
        }
    }
    
    @IBAction func ratingWasPressed(_ sender: HorizontalCircleGradientButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
