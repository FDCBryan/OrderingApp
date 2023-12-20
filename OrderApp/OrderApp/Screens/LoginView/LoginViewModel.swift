import SwiftUI

class LoginViewModel: ObservableObject {
    @AppStorage("Islogin") var Islogin:Bool?
    @AppStorage("isAdmin") var isAdmin: Bool?
    @AppStorage("UserID") var UserID: Int?
    @Published var user = User()
    @Published var response : Data?
    @Published var isLoginSuccessful = false
    @Published var alertItem: AlertItem?
    func attemptLogin() {
        NetworkManager.share.loginUser(username: user.username, password: user.password) { result in
            DispatchQueue.main.async { [self] in
            switch result {
            case .success(let loggedInUser):
                if loggedInUser.success {
                    self.isLoginSuccessful = true
                    UserID = loggedInUser.user?.id
                    Islogin = true
                    isAdmin = true
                }else{
                    print("Login FAILED, \(loggedInUser.message!)!")
                    self.alertItem = AlertContext.userSaveFail
                }
                
                
            case .failure(_):
                // The login failed, handle the error
                self.isLoginSuccessful = false
                self.alertItem = AlertContext.invalidURL
            }
        }
        }
    }
}
