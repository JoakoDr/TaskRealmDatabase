//
//  MainViewController.swift
//  RealmTask
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var table : UITableView?
    internal var users: [User] = []
    internal var repository = LocalTaskRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        users = repository.getAll()
        title = "TASKS"
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc internal func addPressed()
    {
        
        let addView = AddViewController(user: nil)
        addView.delegate = self as! AddViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
    }
    internal func registerCell()
    {
        let indentifier = "UsersTableViewCell"
        let nib = UINib(nibName: indentifier, bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "usersCell")
    }

}
extension MainViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UsersTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as? UsersTableViewCell)!
        let task1 = users[indexPath.row]
        cell.nameLabel?.text = task1.name
        cell.imgLabel?.isHidden = !task1.isPaid
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task1 = users[indexPath.row]
        task1.isPaid = !task1.isPaid
        if repository.update(a: task1)
        {
            table?.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task1 = users[indexPath.row]
            if repository.delete (a: task1)
            {
                users.remove(at: indexPath.row)
                table?.beginUpdates()
                table?.deleteRows(at: [indexPath], with: .automatic)
                table?.endUpdates()
            }
            
        }
    }
    
}
