//
//  AddViewController.swift
//  RealmTask
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    
    func addViewController(_vc: AddViewController, didEditTask user: User)
}

class AddViewController: UIViewController {
    
    weak var delegate: AddViewControllerDelegate!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var user: User!
    
    convenience init(user: User?)
    {
        self.init()
        if user == nil{
            self.user = User()
            self.user.id = UUID().uuidString
            self.user.name = ""
        }
        else
        {
            self.user = user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    @IBAction func closeButtonPressed()
    {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveButtonPressed()
    {
        
        self.user.name = textField.text
        delegate.addViewController(_vc: self, didEditTask: user)
        
    }

}
