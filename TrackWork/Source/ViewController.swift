//
//  ViewController.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTimeToGo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIPreferences()
    }
    
    private func saveData() {
        let futureDate = getFutureDate(from: Date())
        let formatterData = DateFormatterHelper.formatDate(futureDate)
        let messageToBePresent = "Você deve bater o ponto as \(formatterData)"
        
        lbTimeToGo.text = messageToBePresent
    }
    
    private func getFutureDate(from date: Date) -> Date {
        let addHour = 9 // Horas no futuro.
        let timeintervalForHour = TimeInterval(addHour.hours)
        return date.addingTimeInterval(TimeInterval(timeintervalForHour))
    }
    
    private func animateDisabledButton() {
        UIView.animate(withDuration: 0.2) {
            self.btnCheckIn.alpha = 0.7
            self.lbTimeToGo.alpha = 1
        }
        btnCheckIn.isEnabled = false
    }
    
    @IBAction func actionCheckin(_ sender: Any) {
        saveData()
        animateDisabledButton()
    }
}

extension ViewController {
    
    fileprivate func setUIPreferences() {
        self.title = "Add Track"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .blue
        
        btnCheckIn.layer.cornerRadius = (btnCheckIn.frame.height/2)
        btnCheckIn.setTitle("Bater Ponto", for: .normal)
        lbDescription.text = "Aqui você bate seu ponto e a gente te avisa do resto. Vamos lá."
        lbTimeToGo.text = ""
        lbTimeToGo.alpha = 0
    }
}
