//
//  ViewController.swift
//  ValidatorPlayground
//
//  Created by Glauco Custódio on 1/12/16.
//  Copyright © 2016 Teste. All rights reserved.
//

import UIKit
import SwiftValidator

class ViewController: UIViewController, ValidationDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genderErrorLabel: UILabel!
    
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesErrorLabel: UILabel!
    
    @IBOutlet weak var counterStepper: UIStepper!
    @IBOutlet weak var counterStepperLabel: UILabel!
    @IBOutlet weak var counterStepperErrorLabel: UILabel!

    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.borderColor = UIColor.grayColor().CGColor
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            
            if let validationRule = validationRule as? TextFieldValidationRule {
                validationRule.textField!.layer.borderColor = UIColor.greenColor().CGColor
                validationRule.textField!.layer.borderWidth = 0.5
            }
            
            }, error:{ (validationError) -> Void in
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                
                validationError.textField?.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField?.layer.borderWidth = 1.0
                
                validationError.segmentedControl?.layer.borderColor = UIColor.greenColor().CGColor
                validationError.segmentedControl?.layer.borderWidth = 0.5
        })
        
        validator.registerField(nameTextField, errorLabel: nameErrorLabel, rules: [RequiredRule()])
   		validator.registerField(genderSegmentedControl, errorLabel: genderErrorLabel, rules: [SegmentedControlRequiredRule()])
   		validator.registerField(notesTextView, errorLabel: notesErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 10)])
   		validator.registerField(counterStepper, errorLabel: counterStepperErrorLabel, rules: [GreaterThanRule(value: 10)])
    }
    
    
    @IBAction func counterStepperChanged(sender: UIStepper) {
        counterStepperLabel.text = "\(sender.value)"
    }

    @IBAction func saveButtonTapped(sender: UIButton) {
        validator.validate(self)
    }
    
    func validationFailed(textFieldErrors: [UITextField: ValidationError], textViewErrors: [UITextView: ValidationError], segmentedControlErrors: [UISegmentedControl: ValidationError], stepperErrors: [UIStepper: ValidationError])
    {
        print("error")
    }
    
    func validationSuccessful()
    {
        print("success")
    }

}

