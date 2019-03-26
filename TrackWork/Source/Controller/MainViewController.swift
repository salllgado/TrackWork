//
//  ViewController.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import UIKit

internal enum AvailableViews {
    case manualView
    case automaticView
}

class MainViewController: UIViewController {

    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var btnManualCheckIn: UIButton!
    @IBOutlet weak var btnAutomaticView: UIButton!
    @IBOutlet weak var btnManualView: UIButton!
    
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTimeToGo: UILabel!
    @IBOutlet weak var lbTimeToGoManual: UILabel!
    
    @IBOutlet weak var manualContainerView: UIView!
    @IBOutlet weak var automaticContainerView: UIView!
    @IBOutlet weak var containerButtonAutomatic: UIView!
    @IBOutlet weak var containerButtonManual: UIView!
    @IBOutlet weak var containerButtons: UIView!
    
    @IBOutlet weak var lcManualViewHeight: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIPreferences()
        switchViews(hidden: .automaticView)
    }
    
    private func saveDate(date: Date = Date()) {
        var checkIn = Checkpoint()
        checkIn.checkIn(date: date)
        
        let messageToBePresent = "Você deve bater o ponto as \(checkIn.futureTimeFormatted)"
        
        lbTimeToGo.text = messageToBePresent
        lbTimeToGoManual.text = messageToBePresent
        sendDataToAppleWatch(data: checkIn.actualTime!, preferKey: Constants.Date.start.rawValue)
        sendDataToAppleWatch(data: checkIn.futureTime!, preferKey: Constants.Date.exit.rawValue)
    }
    
    private func sendDataToAppleWatch(data: Any, preferKey: String) {
        WatchAppManager.sendData(key: preferKey, value: data)
    }
    
    private func animateDisabledButton() {
        UIView.animate(withDuration: 0.2) {
            self.btnCheckIn.alpha = 0.7
            self.lbTimeToGo.alpha = 1
            self.btnCheckIn.isEnabled = false
        }
    }
    
    private func switchViews(hidden availableView: AvailableViews) {
        availableView == .manualView ? (automaticContainerView.isHidden = true) : (automaticContainerView.isHidden = false)
        manualContainerView.isHidden = !automaticContainerView.isHidden
        
        // automatic view configuration
        automaticContainerView.isHidden == false ? (containerButtonAutomatic.backgroundColor = btnCheckIn.backgroundColor) : (containerButtonAutomatic.backgroundColor = .white)
        automaticContainerView.isHidden == false ? btnAutomaticView.setTitleColor(.white, for: .normal) : btnAutomaticView.setTitleColor(btnCheckIn.backgroundColor, for: .normal)
        
        // manual view configuration
        manualContainerView.isHidden == false ? (containerButtonManual.backgroundColor = btnCheckIn.backgroundColor) : (containerButtonManual.backgroundColor = .white)
        manualContainerView.isHidden == false ? btnManualView.setTitleColor(.white, for: .normal) : btnManualView.setTitleColor(btnCheckIn.backgroundColor, for: .normal)
    }
    
    // MARK: Actions
    @IBAction func actionCheckin(_ sender: Any) {
        saveDate()
        animateDisabledButton()
    }
    
    @IBAction func actionCheckInManual(_ sender: Any) {
        saveDate(date: datePicker.date)
    }
    
    @IBAction func actionSwitchAutomatic(_ sender: Any) {
        switchViews(hidden: .automaticView)
    }
    
    @IBAction func actionSwitchManual(_ sender: Any) {
        switchViews(hidden: .manualView)
    }
}

extension MainViewController {
    
    fileprivate func setUIPreferences() {
        // Nagivation Bar Configuration.
        title = "Add Track"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .blue
        
        // Outlets Configuration.
        containerButtonAutomatic.round(with: .left, radius: 14.0)
        containerButtonManual.round(with: .right, radius: 14.0)
        btnCheckIn.layer.cornerRadius = (btnCheckIn.frame.height/2)
        
        lbTimeToGo.alpha = 0
        
        // Setting labels
        btnAutomaticView.setTitle("Automatico", for: .normal)
        btnManualView.setTitle("Manual", for: .normal)
        btnCheckIn.setTitle("Bater Ponto", for: .normal)
        btnManualCheckIn.setTitle("Bater Ponto", for: .normal)
        lbDescription.text = "Aqui você bate seu ponto e a gente te avisa do resto. Vamos lá."
        lbTimeToGo.text = ""
        lbTimeToGoManual.text = ""
    }
}
