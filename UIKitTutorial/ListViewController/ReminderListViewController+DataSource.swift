//
//  ReminderListViewController+DataSource.swift
//  UIKitTutorial
//
//  Created by naoki-wakata on 2023/08/07.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>

    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }

    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]

        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }

    // withId は 名前付き引数的な感じ
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }

    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }

    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }

    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction
    {
        let name = NSLocalizedString(
            "Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] _ in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }

    private func doneButtonConfiguration(for reminder: Reminder)
        -> UICellAccessory.CustomViewConfiguration
    {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}
