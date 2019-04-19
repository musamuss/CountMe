//
//  AccountViewController.swift
//  CountMe
//
//  Created by Муса Дениев on 20/04/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    /*override func viewWillAppear(_ animated: Bool) {
       
        guard let name = AppUserAccount().name else {
            accountNameTableCell.textLabel?.text = NSLocalizedString("Account Name", comment: "")
            return
        }
        accountNameTableCell.textLabel?.text = name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        accountNameTableCell.isSelected = false
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 1 {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = false
            diplayDeleteAllReportsAlert()
        }
    }
    
    // MARK: - Actions
    
    private func diplayDeleteAllReportsAlert() {
        
        let alertController = UIAlertController(title: pasteConfiguration.Messages.deleteReportsTitle, message: AppConfiguration.Messages.deleteReportsMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let deleteAllAction = UIAlertAction(title: pasteConfiguration.Messages.deleteAllButton, style: UIAlertActionStyle.destructive) { (_: UIAlertAction) -> Void in
            self.accountNameTableCell.textLabel?.text = NSLocalizedString("Account Name", comment: "")
            DataService.deleteAll()
        }
        
        let cancelAction = UIAlertAction(title: pasteConfiguration.Messages.cancelButton, style: UIAlertActionStyle.default) { (_: UIAlertAction) -> Void in
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAllAction)
        present(alertController, animated: true, completion: nil)
        
    }*/
}
