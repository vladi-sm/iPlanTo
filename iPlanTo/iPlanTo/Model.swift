//
//  Model.swift
//  iPlanTo
//
//  Created by xc551c7 on 2021-07-12.
//  Copyright © 2021 xc551c7. All rights reserved.
//logika i rabota prilozhenya razlychnya

import Foundation

//класс задача
class Case {
var planToCase : [[String: Any]] { //тип перем массив словарей
    set {
        UserDefaults.standard.set(newValue, forKey: "PlanToDataKey")
        UserDefaults.standard.synchronize()
        
    }
    get {
         if let array = UserDefaults.standard.array(forKey: "PlanToDataKey") as? [[String:Any]] {
               return array
           } else {
               return []
           }
    }
}
    
func addCase(nameCase: String, isCompleted: Bool = false) {
    planToCase.append(["Name": nameCase, "isCompleted": isCompleted])
   
}

func removeCase(at index: Int) {
    planToCase.remove(at: index)
   
}

func moveCase(fromIndex: Int, toIndex: Int){
    let from = planToCase[fromIndex]
    planToCase.remove(at: fromIndex)
    planToCase.insert(from, at: toIndex)
}

func changeState(at cases: Int) -> Bool {
    planToCase[cases]["isCompleted"] = !(planToCase[cases]["isCompleted"] as! Bool)
    
    return planToCase[cases]["isCompleted"] as! Bool
}
}
let mainCase = Case()

//класс проект

class Project {
var planToProject: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "PlanPrKey")
        UserDefaults.standard.synchronize()
        
    }
    get {
         if let array = UserDefaults.standard.array(forKey: "PlanPrKey") as? [[String:Any]] {
               return array
           } else {
               return []
           }
    }
}

func addProject(nameProject: String, isCompleted: Bool = false) {
    planToProject.append(["Name": nameProject, "isCompleted": false])
    
}

func removeProject(at index: Int) {
    planToProject.remove(at: index)
    }

func changeStateProj(at proj: Int) -> Bool{
    planToProject[proj]["isCompleted"] = !(planToProject[proj]["isCompleted"] as! Bool)
    return planToProject[proj]["isCompleted"] as! Bool
}
}

let mainProject = Project()

// папки

class Folder {
    
    
var planToFolder: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "PlanFKey")
        UserDefaults.standard.synchronize()
        
    }
    get {
         if let array = UserDefaults.standard.array(forKey: "PlanFKey") as? [[String:Any]] {
               return array
           } else {
               return []
           }
    }
}
    func addFolder(nameFolder: String, isFrost: Bool = false) {
        planToFolder.append(["Name": nameFolder, "isFrost": false])
}

func removeFolder(at index: Int) {
    planToFolder.remove(at: index)
}

func changeStateFold(at fold: Int) -> Bool {
    planToFolder[fold]["isFrost"] = !(planToFolder[fold]["isFrost"] as! Bool)
    return planToFolder[fold]["isFrost"] as! Bool
}
}
let mainFolder = Folder()
