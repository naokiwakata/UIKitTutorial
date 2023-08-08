//
//  ReminderView.swift
//  UIKitTutorial
//
//  Created by naoki-wakata on 2023/08/08.
//

import UIKit

class ReminderViewController: UICollectionViewController{
    var reminder: Reminder

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder){
        fatalError()
    }
}
