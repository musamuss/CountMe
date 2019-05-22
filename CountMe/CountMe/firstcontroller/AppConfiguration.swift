import Foundation

class AppConfiguration {
    
    // MARK: - AppConfiguration.TableViewSection
    
    struct TableViewSections {
        static let zero = NSLocalizedString("Лучшие фото за последнее время", comment: "")
        static let one = NSLocalizedString("Top 25 коментированных", comment: "")
        static let two = NSLocalizedString("Последние опубликованные", comment: "")
    }
    
    // MARK: - AppConfiguration.TableViewCellIdentifiers
    
    struct TableViewCellIdentifiers {
        static let cell = "cellID"
    }
    
    struct DefaultsNotifications {
        static let reload = Notification.Name(rawValue: "reload")
    }
    
    // MARK: - AppConfiguration.Messages
    
    struct Messages {
        static let okButton = NSLocalizedString("OK", comment: "")
        static let doneButton = NSLocalizedString("Done", comment: "")
        static let cancelButton = NSLocalizedString("Cancel", comment: "")
        static let deleteAllButton = NSLocalizedString("Delete All", comment: "")
        static let somethingWrongMessage = NSLocalizedString("Something went wrong", comment: "")
        static let privateAccountMessage = NSLocalizedString("This account is private", comment: "")
        static let reportsCompletedTitle = NSLocalizedString("Report Completed", comment: "")
        static let reportsCompletedMessage = NSLocalizedString("Please go back to the start screen", comment: "")
        
        //стделать тригер на экшон reportsCompletedMessage для перехода на старт скрин
        static let deleteReportsTitle = NSLocalizedString("Delete Report", comment: "")
        static let deleteReportsMessage = NSLocalizedString("Remove account and delete the report", comment: "")
    }
    
}
