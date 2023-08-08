//
//  ReminderListViewController+Actions.swift
//  UIKitTutorial
//
//  Created by naoki-wakata on 2023/08/08.
//

import UIKit

extension ReminderListViewController {
    // @objc： Objective-Cのコードを利用可能にする
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
