//
//  LocalUserRepository.swift
//  RealmTask
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class LocalTaskRepository: NSObject {
    
    func getAll() -> [User] {
        var tasks : [User] = []
        do {
            let entities = try Realm().objects(UserEntity.self).sorted(byKeyPath: "name", ascending: true)
            for entity in entities {
                let model = entity.taskModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("Error en el getAll Tasks:", error.description)
        }
        return tasks
    }
    func get(identifier: String) -> User? {
        
        do{
            let realm = try Realm()
            if let entity = realm.objects(UserEntity.self).filter("id == %@",identifier).first{
                let model = entity.taskModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    func create(a: User) -> Bool {
        do {
            let realm = try Realm()
            let entities = UserEntity(user: a)
            try realm.write {
                realm.add(entities,update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    func update(a: User) -> Bool {
        
        return create(a: a)
    }
    
    func delete(a: User) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entitiyDelete = realm.objects(UserEntity.self).filter("id == %@", a.id)
                realm.delete(entitiyDelete)
            }
        }
        catch{
            return false
        }
        return true
    }
    
}
