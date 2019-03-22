//
//  ViewController.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import UIKit

enum AvailableViews {
    case manualView
    case automaticView
}

class ViewController: UIViewController {

    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTimeToGo: UILabel!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var manualContainerView: UIView!
    @IBOutlet weak var automaticContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIPreferences()
    }
    
    private func saveData() {
        let futureDate = getFutureDate(from: Date())
        let messageToBePresent = "Você deve bater o ponto as \(DateFormatterHelper.formatDate(futureDate))"
        
        lbTimeToGo.text = messageToBePresent
        sendDataToAppleWatch(data: Date(), preferKey: "startDateString")
        sendDataToAppleWatch(data: futureDate, preferKey: "exitDateString")
    }
    
    private func sendDataToAppleWatch(data: Any, preferKey: String) {
        WatchAppManager.sendData(key: preferKey, value: data)
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
//        btnCheckIn.isEnabled = false
    }
    
    private func switchViews(hidden availableView: AvailableViews) {
        availableView == .manualView ? (automaticContainerView.isHidden = true) : (automaticContainerView.isHidden = false)
        manualContainerView.isHidden =  !automaticContainerView.isHidden
    }
    
    @IBAction func actionCheckin(_ sender: Any) {
        saveData()
        animateDisabledButton()
    }
    
    @IBAction func switchSegmentedControll(_ sender: Any) {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            switchViews(hidden: .automaticView)
            break
        case 1:
            switchViews(hidden: .manualView)
            break
        default:
            break
        }
    }
}

extension ViewController {
    
    fileprivate func setUIPreferences() {
        // Nagivation Bar Configuration.
        title = "Add Track"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .blue
        
        // Outlets Configuration.
        segmentedControll.setTitle("Modo Automatico", forSegmentAt: 0)
        segmentedControll.setTitle("Modo Manual", forSegmentAt: 1)
//        segmentedControll.tintColor = navigationController?.navigationBar.backgroundColor
        btnCheckIn.layer.cornerRadius = (btnCheckIn.frame.height/2)
        btnCheckIn.setTitle("Bater Ponto", for: .normal)
        lbDescription.text = "Aqui você bate seu ponto e a gente te avisa do resto. Vamos lá."
        lbTimeToGo.text = ""
        lbTimeToGo.alpha = 0
    }
}
