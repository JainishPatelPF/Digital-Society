import Foundation

func createStructure() {
    
    let flm = FileManager()
    if !flm.fileExists(atPath: getUserPath()) {
        let arr : [[String:Any]] = []
        let disc : [String:Any] = ["userRecord":arr]
        let finalDisc = NSDictionary(dictionary: disc)
        finalDisc.write(toFile: getUserPath(), atomically: true)
    }
}
func getLoginData() -> [[String:Any]] {
    
    var arr : [[String:Any]] = []
    let flm = FileManager()
    if flm.fileExists(atPath: getUserPath()) {
        
        var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
        arr = disc["userRecord"] as! [[String:Any]]
    }
    return arr
}
func logout() -> Bool {
    
    var status : Bool = false
    var arr : [[String:Any]] = []
    let flm = FileManager()
    if flm.fileExists(atPath: getUserPath()) {
        
        var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
        arr = disc["userRecord"] as! [[String:Any]]
        if arr.count == 1{
            arr.removeAll()
            disc["userRecord"] = arr
            let finalDisc = NSDictionary(dictionary: disc)
            finalDisc.write(toFile: getUserPath(), atomically: true)
            status = true
        }
    }
    return status
}
func storeLoginData(arrDisc : [[String:Any]]) {
    
    let flm = FileManager()
    if flm.fileExists(atPath: getUserPath()) {
        
        var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
        var arr = disc["userRecord"] as! [[String:Any]]
        arr = arrDisc
        disc["userRecord"] = arr
        let finalDisc = NSDictionary(dictionary: disc)
        finalDisc.write(toFile: getUserPath(), atomically: true)
    }
}
func getUserPath() -> String {
    
    let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let path = arr[0]
    let finalPath = path.appending("/userLogin.plist")
    print(finalPath)
    return finalPath
}
