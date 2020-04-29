//
//  TapticGenerator.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/28/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

//class TapticGenerator {
//
//}
import UIKit

class TapticViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var i = 0
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)

        btn.widthAnchor.constraint(equalToConstant: 128).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        btn.setTitle("Feel Taptic", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = Styles.buttonRadius
        btn.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        // setup picker
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Heavy", "Medium", "Light", "Selection Changed", "Success", "Warning", "Error"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // columns of picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // rows of picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return pickerData.count
    }

    // component is the column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return pickerData[row]
    }

    @objc func tapped() {
        switch (pickerData[picker.selectedRow(inComponent: 0)]) {
        case "Heavy":
            TapticGenerator.impact(.heavy)
        case "Medium":
            TapticGenerator.impact(.medium)
        case "Light":
            TapticGenerator.impact(.light)
        case "Success":
            TapticGenerator.notification(.success)
        case "Warning":
            TapticGenerator.notification(.warning)
        case "Error":
            TapticGenerator.notification(.error)
        case "Selection Changed":
            TapticGenerator.selectionChanged()
        default:
            TapticGenerator.selectionChanged()
        }
    }
}
