//
//  TableViewController.swift
//  iPlanTo
//
//  Created by xc551c7 on 2021-07-12.
//  Copyright © 2021 xc551c7. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
   //кнопки добавления папки, проекта и дела с главного интерфейса
    @IBAction func pushAddFolder(_ sender: Any) {
        //addFolder(nameFolder: "New Folder")
        //self.tableView.reloadData() - так раньше добавлялись и создавались объекты на главном экране приложения
        
        let alertController = UIAlertController(title: "Новая папка", message: nil, preferredStyle:.alert) // создание элемента всплывающего окна приложения при нажатии кнопки папка
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите название для новой папки"
        } // метод для создания текстового поля
        
        let alertAction1 = UIAlertAction(title: "Выйти", style: .default) { (alert) in
            
        }
        let alertAction2 = UIAlertAction(title: "Создать", style: .cancel) { (alert) in
            let newFolder = alertController.textFields![0].text
            mainFolder.addFolder(nameFolder: newFolder!)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1) // добавление кнопки на экран к алертконтролеру
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pushAddProject(_ sender: Any) {
        //addProject(nameProject: "New Project")
       //self.tableView.reloadData()
        
        let alertController = UIAlertController(title: "Новый проект", message: nil, preferredStyle:.alert) // создание элемента всплывающего окна приложения при нажатии кнопки папка
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите название для нового проекта"
        } // метод для создания текстового поля
        
        let alertAction1 = UIAlertAction(title: "Выйти", style: .default) { (alert) in
            
        }
        let alertAction2 = UIAlertAction(title: "Создать", style: .cancel) { (alert) in
            let newProject = alertController.textFields![0].text
            mainProject.addProject(nameProject: newProject!)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1) // добавление кнопки на экран к алертконтролеру
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        //vvodim knopky v rezhim redactirovanya
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        //sozdanie vsplyv okna pri nazhatii +
        let alertController = UIAlertController(title: "Новое дело", message: nil, preferredStyle: .alert)
        // rabota s text polem
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите название для нового дела"
        }
        //knopka 1
        let alertAction1 = UIAlertAction(title: "Выйти", style: .default)
        { (alert) in
            
        }
        //knopka 2
        let alertAction2 = UIAlertAction(title: "Создать", style: .cancel)
        { (alert) in
            let newCase = alertController.textFields![0].text
            mainCase.addCase(nameCase: newCase!, isCompleted: false)
            self.tableView.reloadData()
        }
        alertController.addAction (alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //возвращает количество секций в tableview
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //метод возвращает количество строк в секции и соответствует количеству элементов созданных массивов
        if section == 0 {
            return mainFolder.planToFolder.count
        } else if section == 1 {
            return mainProject.planToProject.count
        } else {
            return mainCase.planToCase.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellf = tableView.dequeueReusableCell(withIdentifier: "CellF", for: indexPath)
            let currentFolder = mainFolder.planToFolder[indexPath.row]
            cellf.textLabel?.text = currentFolder["Name"] as? String
            if (currentFolder["isFrost"] as? Bool) == true {
                cellf.imageView?.image = UIImage(named: "folder_open.png")
                //cellf.accessoryType = .checkmark
            } else {
                cellf.imageView?.image = UIImage(named: "folder.png")
                //cellf.accessoryType = .none
            }
            return cellf
            
        } else if indexPath.section == 1 {
            let cellp = tableView.dequeueReusableCell(withIdentifier: "CellP", for: indexPath)
            let currentProject = mainProject.planToProject[indexPath.row]
            cellp.textLabel?.text = currentProject["Name"] as? String
            if (currentProject["isCompleted"] as? Bool) == true {
                cellp.imageView?.image = UIImage(named: "proj_ch.png")
            } else {
                cellp.imageView?.image = UIImage(named: "proj.png")
            }
            return cellp
            
        } else {
            let cellc = tableView.dequeueReusableCell(withIdentifier: "CellC", for: indexPath)
            //v pole title dlya idn cell prisvaivaem znachenya iz massiva
            let currentCase = mainCase.planToCase[indexPath.row]
            cellc.textLabel?.text = currentCase["Name"] as? String
            
            if (currentCase["isCompleted"] as? Bool) == true {
                
                cellc.imageView?.image = UIImage(named: "icheck.png")
            } else {
                cellc.imageView?.image = UIImage(named: "unicheck.png")
            }
            // Configure the cell...
            if tableView.isEditing {
                cellc.textLabel?.alpha = 0.4
                cellc.imageView?.alpha = 0.4
            } else {
                cellc.textLabel?.alpha = 1
                cellc.imageView?.alpha = 1        }
                return cellc
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.section == 0 {
                mainFolder.removeFolder(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if indexPath.section == 1 {
                mainProject.removeProject(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                mainCase.removeCase(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if mainFolder.changeStateFold(at: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "folder_open.png")
            } else {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "folder.png")
            }
            
        } else if indexPath.section == 1 {
            if mainProject.changeStateProj(at: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "proj_ch.png")
            } else {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "proj.png")
            }
            
        } else {
            if mainCase.changeState(at: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "icheck.png")
            } else {
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "unicheck.png")
            }
        }
        
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        mainCase.moveCase(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
