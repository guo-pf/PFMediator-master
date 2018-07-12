# PFMediator-master

swift版的路由跳转页面，协议传值。
使用方法如下：需要自定义匹配对应的Actions 和 MediatorApi
    class HomePageViewController: UIViewController,PFMessageProtocol {
       func getMessage(_ result: PFMessageProtocol.T?) {
            guard result != nil else{
                return
            }
             if result is UIColor {
                self.view.backgroundColor = (result as! UIColor)
            }
        }

      @IBAction func pushActionClicked(_ sender: Any) {
              let userInfo = UserModel(userName: "第一个人", userAge: 21, userSex: 0)
              let apiProvider = MediatorProvider<HomePageApi>()
              apiProvider.registered(targer: HomePageApi.homepage_Message(userInfo))
          }
    }
