//
//  DataManager.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
import CoreData

class DataManager: ObservableObject {

    static let shared = DataManager()
    private var masterPassword = ""
    @Published var pwd = ""
    var newPwd: PwdEntity?
    var newMsg: MsgEntity?
    var newPic: PicEntity?
    
//    var validate = false
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    var reminder = false //是否加载过温馨提示
    @Published var validateWhenLaunch: Bool = true {
        didSet {
            let value = validateWhenLaunch ? 1 : 2
            UserDefaults.standard.set(value, forKey: "closeValidate")
            if value == 1 {
                enableFaceID = false
            }
        }
    }

    @Published var enableFaceID: Bool = false {
        didSet {
            let value = enableFaceID ? 1 : 2
            UserDefaults.standard.set(value, forKey: USE_BIOMETRIC)
            if value == 1 {
                validateWhenLaunch = false
            }
        }
    }
    
    private init() {
        masterPassword = UserDefaults.standard.string(forKey: "masterKey") ?? ""
        reminder = UserDefaults.standard.bool(forKey: "reminder")
        let closeValidate = UserDefaults.standard.integer(forKey: "closeValidate")
        validateWhenLaunch = (closeValidate == 2) ? false : true
        let faceIDValidate = UserDefaults.standard.integer(forKey: USE_BIOMETRIC)
        enableFaceID = (faceIDValidate == 1) ? true : false
    }
    
    func update(reminder: Bool) {
        self.reminder = reminder
        UserDefaults.standard.set(reminder, forKey: "reminder")
    }
    
    func password() -> String {
        return masterPassword
    }
    
    func defaultKey() -> String {
        return "a1a1a1a1a1a1a1a1a1a1"
    }
    
    func update(password: String?) {
        masterPassword = password?.encodeBase64() ?? ""
        pwd = password ?? ""
        UserDefaults.standard.set(masterPassword, forKey: "masterKey")
    }
    
    func noMasterPwd() -> Bool {
        return masterPassword.isEmpty
    }
    
    func passwordsMatch() -> Bool {
        return pwd == masterPassword.decodeBase64()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "jmzs")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var updatePwd: PwdEntity?
    var updateMsg: MsgEntity?
    var updatePic: PicEntity?

    func attachPwd(item: Pwd) -> PwdEntity {
        let updateObject = PwdEntity()
        updateObject.store = item
        return updateObject
    }
    
    func attachPic(item: Pic) -> PicEntity {
        let updateObject = PicEntity()
        updateObject.store = item
        return updateObject
    }
    
    func attachMsg(item: Msg) -> MsgEntity {
        let updateObject = MsgEntity()
        updateObject.store = item
        return updateObject
    }
    
    func detachPwd() {
        updatePwd?.store = nil
        updatePwd = nil
    }
    
    func detachMsg() {
        updateMsg?.store = nil
        updateMsg = nil
    }
    
    func detachPic() {
        updatePic?.store = nil
        updatePic = nil
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func discardNewPwd() {
        guard newPwd != nil else { return }
        newPwd = nil
    }
    
    func prepareNewPwd() {
        guard newPwd == nil else { return }
        newPwd = PwdEntity()
    }
    
    func discardNewMsg() {
        guard newMsg != nil else { return }
        newMsg = nil
    }
    
    func discardNewPic() {
        guard newPic != nil else { return }
        newPic = nil
    }
    
    func prepareNewPic() {
        guard newPic == nil else { return }
        newPic = PicEntity()
    }
    
    func prepareNewMsg(type: Int) {
        guard newMsg == nil else { return }
        newMsg = MsgEntity()
        newMsg?.type = 1 //文本
        if type == 2 { //1加密(发送) 2解密(接收) 默认发送
            newMsg?.owner = false
        }
    }
    
    /// Discard changes of the given context.
    /// - Parameter context: Must be the `createContext` or `updateContext`.
    func discardContext() {
        guard viewContext.hasChanges else { return }
        viewContext.rollback()
    }
    
    //创建
    func addPwd(_ store: PwdEntity) {
        let data = Pwd(context: viewContext)
        data.id = UUID()
        data.account = store.account
        data.createTime = store.createTime
        if store.pwd.isEmpty {
            data.pwd = ""
        } else {
            data.pwd = store.pwd.aesEncrypt(keyString: DataManager.shared.password()) ?? ""
        }
        data.remarks = store.remarks
        data.title = store.title
        data.type = store.type
        data.updateTime = store.updateTime
        data.website = store.website
    }
    
    func deletePwd(_ data: Pwd) {
        viewContext.delete(data)
        viewContext.quickSave()
    }
    
    func addPic(_ store: PicEntity) {
        let data = Pic(context: viewContext)
        data.id = UUID()
        data.createTime = store.createTime
        data.title = store.title
        data.updateTime = store.updateTime
        for pic in store.pics {
            let p = Thumb(context: viewContext)
            p.data = pic.data
            p.id = pic.id
            p.path = pic.path
            data.addToPics(p)
        }
    }
    
    func deletePic(_ data: Pic) {
        viewContext.delete(data)
        viewContext.quickSave()
    }
    
    //创建
    func addMessage(_ store: MsgEntity) {
        let data = Msg(context: viewContext)
        data.id = UUID()
        data.title = store.title;
        data.content = store.content
        data.createTime = store.createTime
        data.key = store.key
        data.mode = store.mode
        data.time = store.time
        data.type = Int32(store.type)
        data.owner = store.owner
    }
    
    func addPwdAndSave(_ store: PwdEntity) {
        addPwd(store)
        viewContext.quickSave()
    }
    
    func addPicAndSave(_ store: PicEntity) {
        addPic(store)
        viewContext.quickSave()
    }
    
    func addMessageAndSave(_ store: MsgEntity) {
        addMessage(store)
        viewContext.quickSave()
    }
    
    func updatePwd(_ store: PwdEntity){
        guard let data = store.store else { return }
        data.account = store.account
        data.createTime = store.createTime
        data.pwd = store.pwd
        data.remarks = store.remarks
        data.title = store.title
        data.type = store.type
        data.updateTime = store.updateTime
        data.website = store.website
        viewContext.quickSave()
    }
    
    func updateCurrentPwd(){
        guard let item = updatePwd else { return }
        updatePwd(item)
        detachPwd()
    }

    func clearData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        let deleteAll = NSBatchDeleteRequest(fetchRequest: request)
        let requestMsg = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
        let deleteAllMsg = NSBatchDeleteRequest(fetchRequest: requestMsg)
        let requestBigImage = NSFetchRequest<NSFetchRequestResult>(entityName: "BigImage")
        let deleteAllBigImage = NSBatchDeleteRequest(fetchRequest: requestBigImage)
        do {
            try viewContext.execute(deleteAll)
            try viewContext.execute(deleteAllMsg)
            try viewContext.execute(deleteAllBigImage)
            clearPassword()
        } catch { print(error) }
    }
    
    func clearPassword() {
        masterPassword = ""
        pwd = masterPassword
        UserDefaults.standard.set(masterPassword, forKey: "masterKey")
    }

    //创建
    func addBigImage(image: Data, id: UUID?) {
        guard let imageId = id else {
            return
        }
        let data = BigPic(context: viewContext)
        data.id = imageId
        data.data = image
        NSLog("添加图片id:\(imageId)")
    }
    
    //创建
    func addBigImageAndSave(image: Data, id: UUID) {
        let data = BigPic(context: viewContext)
        data.id = UUID()
        data.data = image
        viewContext.quickSave()
    }
    
    //删除
    func removeBigImages(imageIds:[UUID]) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BigPic")
        request.predicate = NSPredicate(format: "id in %@", imageIds)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeCount
        do {
            try viewContext.execute(deleteRequest)
            NSLog("批量删除ids:\(imageIds)")
        } catch {
            print(error)
        }
    }
    
    //删除
    func removeBigImage(imageId: UUID) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BigPic")
        request.predicate = NSPredicate(format: "id == %@", imageId as CVarArg)
        do {
            let result = try viewContext.fetch(request)
            if let image = result.first as? BigPic {
                viewContext.delete(image)
                NSLog("单个删除")
            } else {
                NSLog("单个删除:未查询到")
            }
        } catch {
            NSLog("单个删除失败:\(error)")
        }
    }
    
    //删除
    func removeBigImagesAndSave(imageIds:[UUID]) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BigPic")
        request.predicate = NSPredicate(format: "id in %@", imageIds)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeCount
        do {
            try viewContext.execute(deleteRequest)
            viewContext.reset()
            NSLog("批量删除成功")
        } catch {
            NSLog("批量删除失败:\(error)")
        }
    }
    
    func rollBack() {
        viewContext.rollback()
    }
}
