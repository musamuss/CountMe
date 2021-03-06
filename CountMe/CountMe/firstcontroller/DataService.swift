import RealmSwift

enum Weekday: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}

class DataService {
    
    static func media( for userName: String, completion: @escaping ( _ error: String?) -> Void) {
        InstagramProvider.request(.userMedia(userName)) { result in
            do {
                let response = try result.get()
                let value: [String: Any] = try response.mapNSArray()
                guard let items = value["data"] as? [[String: Any]], items.isEmpty == false else {
                completion(AppConfiguration.Messages.privateAccountMessage)
                return
                }
                AppUserAccount().name = userName
                importInstagramMedia(instagramMedia: items, completion: {
                    completion(nil)
                })
            } catch {
                completion(error.localizedDescription)
            }
        }
    }
    
    // Обновить медиа
    static func importInstagramMedia(instagramMedia: [[String: Any]], completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            guard let realm = try? Realm() else { return }
            realm.beginWrite()
            for media in instagramMedia {
                guard let instagramMedia = InstagramMedia1(JSON: media) else {
                    continue
                }
                realm.add(instagramMedia, update: true)
            }
            try? realm.commitWrite()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    // Вернуть топ коментированных фото
    static func mostLiked (with limit: Int ) -> [InstagramMedia1] {
     
        guard let realm = try? Realm() else { return [] }
        let medias = realm.objects(InstagramMedia1.self).sorted(byKeyPath: "commentsCount", ascending: false)
        if medias.count > limit {
            return Array(medias[0...limit])
        }
        return Array(medias)
    }
    
    // Возврат постов за несколько недель
    static func lastWeeksPosted (weeks: Int) -> [InstagramMedia1] {
        guard let realm = try? Realm() else { return [] }
        guard let fromDate = Calendar.current.date(byAdding: .day, value: -(7 * weeks), to: Date()) else { return [] }
        let predicate = NSPredicate(format: "createdTime > %@", fromDate as NSDate)
        let medias = realm.objects(InstagramMedia1.self).sorted(byKeyPath: "createdTime", ascending: false).filter(predicate)
        return Array(medias)
    }
    
    // Возврат лучших фото
    static func bestEngagement (with limit: Int) -> [InstagramMedia1] {
        guard let realm = try? Realm() else { return [] }
        let medias = realm.objects(InstagramMedia1.self).sorted(byKeyPath: "engagementCount", ascending: false)
        if medias.count > limit {
            return Array(medias[0...limit])
        }
        return Array(medias)
    }
    
    // возврат подряд постов
    static func instagramMediaIndex() -> (offset: String?, count: Int) {
        guard let realm = try? Realm() else { return (nil, 0) }
        let entries = realm.objects(InstagramMedia1.self).sorted(byKeyPath: "createdTime", ascending: true)
        if entries.isEmpty == false {
            guard let offset = entries[0]["id"] as? String else { return (nil, 0) }
            let count = entries.count
            return (offset, count)
        } else {
            return (nil, 0)
        }
    }
    
    // Weekday
    static func weekday() -> String {
        
        guard let realm = try? Realm() else { return "" }
        
        var predicateArray = [NSPredicate]()
        var groupbyArray = [[InstagramMedia1]]()
        var summedEngagementArray = [(Int, Int)]()

        for weekday in 1...7 {
            let predicate = NSPredicate(format: "weekday == %d", weekday)
            predicateArray.append(predicate)
        }
        for weekday in predicateArray.indices {
            let medias = Array(realm.objects(InstagramMedia1.self).filter(predicateArray[weekday]))
            groupbyArray.append(medias)
        }
        for weekday in groupbyArray.indices {
            let array = groupbyArray[weekday]
            summedEngagementArray.append(DataService.sumEngagement(for: array, day: weekday))
        }
        
        summedEngagementArray = summedEngagementArray.sorted(by: { $0.0 > $1.0 })

        switch summedEngagementArray[0].1 {
        case Weekday.sunday.rawValue:
            return NSLocalizedString("Воскресенье.", comment: "")
        case Weekday.monday.rawValue:
            return NSLocalizedString("Понедельник.", comment: "")
        case Weekday.tuesday.rawValue:
            return NSLocalizedString("Вторник.", comment: "")
        case Weekday.wednesday.rawValue:
            return NSLocalizedString("Среда.", comment: "")
        case Weekday.thursday.rawValue:
            return NSLocalizedString("Четверг.", comment: "")
        case Weekday.friday.rawValue:
            return NSLocalizedString("Пятница.", comment: "")
        case Weekday.saturday.rawValue:
            return NSLocalizedString("Суббота.", comment: "")
        default:
            return NSLocalizedString("День.", comment: "")
        }
    }
    
    static func sumEngagement(for array: [InstagramMedia1], day: Int) -> (Int, Int) {
        var engagmentSum = 0
        for media in array {
            engagmentSum += media.engagementCount
        }
        return (engagmentSum, day + 1)
    }
    
    static func deleteAll() {
        AppUserAccount().name = nil
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
        NotificationCenter.default.post(name: AppConfiguration.DefaultsNotifications.reload, object: nil)
    }
}
