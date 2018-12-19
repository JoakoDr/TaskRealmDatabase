//
//  UserEntity.swift
//  RealmTask
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation
import RealmSwift

class UserEntity: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var isPaid = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init (user: User)
    {
        self.init()
        self.id = user.id
        self.name = user.name
        self.isPaid = user.isPaid
    }
    func taskModel() -> User{
        let model = User()
        model.id = self.id
        model.name = self.name
        model.isPaid = self.isPaid
        return model
    }
}
