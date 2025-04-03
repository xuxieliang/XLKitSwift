////
////  YXSystemAuthorization.swift
////  YXKitSwift
////
////  Created by zxw on 2021/11/18.
////
//
///// 媒体资料库/Apple Music
//import MediaPlayer
//import Photos
//import UserNotifications
//import Contacts
///// Siri权限
//import Intents
///// 语音转文字权限
//import Speech
///// 日历、提醒事项
//import EventKit
///// Face、TouchID
//import LocalAuthentication
//import HealthKit
//import HomeKit
///// 运动与健身权限
//import CoreMotion
///// 防止获取无效 计步器
//private let cmPedometer = CMPedometer()
//
//public typealias AuthClouser = ((Bool)->())
//
///// 定义私有全局变量,解决在iOS 13 定位权限弹框自动消失的问题
//private let locationAuthManager = CLLocationManager()
//
//
///// 显示引导设置弹框
///// - Parameter message: 提示信息
//private func showBootAlert(_ message: String) {
//    let alertVC = UIAlertController(title: "温馨提示", message: message, preferredStyle: .alert)
//    let openAction = UIAlertAction(title: "去设置", style: .default, handler: { (action) in
//        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url as URL) {
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
//    })
//    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//    alertVC.addAction(openAction)
//    alertVC.addAction(cancelAction)
//    UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
//}
//
//
//public class YXSystemAuth {}
//public extension YXSystemAuth {
//    
//    /**
//     媒体资料库/Apple Music权限
//     
//     - parameters: action 权限结果闭包
//     */
//    @available(iOS 9.3, *)
//    class func authMediaPlayerService(_ isShowBootAlert: Bool = true, clouser :@escaping AuthClouser) {
//        let authStatus = MPMediaLibrary.authorizationStatus()
//        switch authStatus {
//        /// 未作出选择
//        case .notDetermined:
//            MPMediaLibrary.requestAuthorization { (status) in
//                if status == .authorized{
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//            if isShowBootAlert {
//                showBootAlert("当前媒体服务不可用")
//            }
//        /// 已授权
//        case .authorized:
//            clouser(true)
//        /// 扩展以后可能有的状态,做保护措施
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     相机权限
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authCamera(_ isShowBootAlert: Bool = true, clouser: @escaping AuthClouser) {
//        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
//        switch authStatus {
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { (result) in
//                if result {
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//            if isShowBootAlert {
//                showBootAlert("当前相机服务不可用")
//            }
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     相册权限
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authPhotoLib(_ isShowBootAlert: Bool = true, clouser: @escaping AuthClouser) {
//        let authStatus = PHPhotoLibrary.authorizationStatus()
//        switch authStatus {
//        case .notDetermined:
//            PHPhotoLibrary.requestAuthorization { (status) in
//                if status == .authorized{
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//            if isShowBootAlert {
//                showBootAlert("当前相册服务不可用")
//            }
//        case .authorized, .limited:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     麦克风权限
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authMicrophone(_ isShowBootAlert: Bool = true, clouser: @escaping AuthClouser) {
//        let authStatus = AVAudioSession.sharedInstance().recordPermission
//        switch authStatus {
//        case .undetermined:
//            AVAudioSession.sharedInstance().requestRecordPermission { (result) in
//                if result {
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied:
//            clouser(false)
//            if isShowBootAlert {
//                showBootAlert("当前麦克风服务不可用")
//            }
//        case .granted:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     定位权限
//     
//     - parameters: action 权限结果闭包(有无权限,是否第一次请求权限)
//     */
//    class func authLocation(_ isShowBootAlert: Bool = true, clouser: @escaping ((Bool, Bool)->())) {
//        let authStatus = CLLocationManager.authorizationStatus()
//        switch authStatus {
//        case .notDetermined:
//            //由于IOS8中定位的授权机制改变 需要进行手动授权
//            locationAuthManager.requestAlwaysAuthorization()
//            locationAuthManager.requestWhenInUseAuthorization()
//            let status = CLLocationManager.authorizationStatus()
//            if  status == .authorizedAlways || status == .authorizedWhenInUse {
//                DispatchQueue.main.async {
//                    clouser(true && CLLocationManager.locationServicesEnabled(), true)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    clouser(false, true)
//                }
//            }
//        case .denied, .restricted:
//            clouser(false, false)
//            if isShowBootAlert {
//                showBootAlert("当前定位服务不可用")
//            }
//        case .authorizedAlways, .authorizedWhenInUse:
//            clouser(true && CLLocationManager.locationServicesEnabled(), false)
//        @unknown default:
//            clouser(false, false)
//        }
//    }
//    
//    /**
//     推送权限
//     
//     - parameters: action 权限结果闭包
//     */
//    @available(iOS 10.0, *)
//    class func authNotification(clouser: @escaping AuthClouser) {
//        UNUserNotificationCenter.current().getNotificationSettings() { (setttings) in
//            switch setttings.authorizationStatus {
//            case .notDetermined:
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (result, error) in
//                    if result {
//                        DispatchQueue.main.async {
//                            clouser(true)
//                        }
//                    } else {
//                        DispatchQueue.main.async {
//                            clouser(false)
//                        }
//                    }
//                }
//            case .denied:
//                clouser(false)
//            case .authorized, .provisional, .ephemeral:
//                clouser(true)
//            @unknown default:
//                clouser(false)
//            }
//        }
//    }
//    
//    /**
//     运动与健身
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authCMPedometer(clouser: @escaping AuthClouser) {
//        cmPedometer.queryPedometerData(from: Date(), to: Date()) { (pedometerData, error) in
//            if pedometerData?.numberOfSteps != nil{
//                DispatchQueue.main.async {
//                    clouser(true)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    clouser(false)
//                }
//            }
//        }
//    }
//    
//    /**
//     通讯录权限
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authContacts(_ isShowBootAlert: Bool = true, clouser: @escaping AuthClouser) {
//        let authStatus = CNContactStore.authorizationStatus(for: .contacts)
//        switch authStatus {
//        case .notDetermined:
//            CNContactStore().requestAccess(for: .contacts) { (result, error) in
//                if result {
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//            if isShowBootAlert {
//                showBootAlert("当前通讯录服务不可用")
//            }
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     Siri 权限
//     
//     - parameters: action 权限结果闭包
//     */
//    @available(iOS 10.0, *)
//    class func authSiri(clouser: @escaping AuthClouser) {
//        let authStatus = INPreferences.siriAuthorizationStatus()
//        switch authStatus {
//        case .notDetermined:
//            INPreferences.requestSiriAuthorization { (status) in
//                if status == .authorized{
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     语音转文字权限
//     
//     - parameters: action 权限结果闭包
//     */
//    @available(iOS 10.0, *)
//    class func authSpeechRecognition(clouser: @escaping AuthClouser) {
//        let authStatus = SFSpeechRecognizer.authorizationStatus()
//        switch authStatus {
//        case .notDetermined:
//            SFSpeechRecognizer.requestAuthorization { (status) in
//                if status == .authorized{
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     提醒事项
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authRreminder(clouser: @escaping AuthClouser) {
//        let authStatus = EKEventStore.authorizationStatus(for: .reminder)
//        switch authStatus {
//        case .notDetermined:
//            EKEventStore().requestAccess(to: .reminder) { (result, error) in
//                if result {
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     日历
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authEvent(clouser: @escaping AuthClouser) {
//        let authStatus = EKEventStore.authorizationStatus(for: .event)
//        switch authStatus {
//        case .notDetermined:
//            EKEventStore().requestAccess(to: .event) { (result, error) in
//                if result {
//                    DispatchQueue.main.async {
//                        clouser(true)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        clouser(false)
//                    }
//                }
//            }
//        case .denied, .restricted:
//            clouser(false)
//        case .authorized:
//            clouser(true)
//        @unknown default:
//            clouser(false)
//        }
//    }
//    
//    /**
//     FaceID或者TouchID 认证
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authFaceOrTouchID(clouser: @escaping ((Bool, Error)->())) {
//        let context = LAContext()
//        var error: NSError?
//        let result = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
//        if result {
//            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "认证") { (success, authError) in
//                if success{
//                    print("成功")
//                } else {
//                    print("失败")
//                }
//            }
//        } else {
//            /**
//             #define kLAErrorAuthenticationFailed                       -1
//             #define kLAErrorUserCancel                                 -2
//             #define kLAErrorUserFallback                               -3
//             #define kLAErrorSystemCancel                               -4
//             #define kLAErrorPasscodeNotSet                             -5
//             #define kLAErrorTouchIDNotAvailable                        -6
//             #define kLAErrorTouchIDNotEnrolled                         -7
//             #define kLAErrorTouchIDLockout                             -8
//             #define kLAErrorAppCancel                                  -9
//             #define kLAErrorInvalidContext                            -10
//             #define kLAErrorNotInteractive                          -1004
//             
//             #define kLAErrorBiometryNotAvailable              kLAErrorTouchIDNotAvailable
//             #define kLAErrorBiometryNotEnrolled               kLAErrorTouchIDNotEnrolled
//             
//             */
//            print("不可以使用")
//        }
//    }
//    
//    /**
//     健康  (写:体能训练、iOS13 听力图 读: 健身记录、体能训练、iOS13 听力图)
//     
//     - parameters: action 权限结果闭包
//     */
//    @available(iOS 9.3, *)
//    class func authHealth(clouser: @escaping AuthClouser) {
//        if HKHealthStore.isHealthDataAvailable() {
//            let authStatus = HKHealthStore().authorizationStatus(for: .workoutType())
//            switch authStatus {
//            case .notDetermined:
//                if #available(iOS 13.0, *) {
//                    HKHealthStore().requestAuthorization(toShare: [.audiogramSampleType(), .workoutType()], read: [.activitySummaryType(), .workoutType(), .audiogramSampleType()]) { (result, error) in
//                        if result {
//                            DispatchQueue.main.async {
//                                clouser(true)
//                            }
//                        } else {
//                            DispatchQueue.main.async {
//                                clouser(false)
//                            }
//                        }
//                    }
//                } else {
//                    HKHealthStore().requestAuthorization(toShare: [.workoutType()], read: [.activitySummaryType(), .workoutType()]) { (result, error) in
//                        if result {
//                            DispatchQueue.main.async {
//                                clouser(true)
//                            }
//                        } else {
//                            DispatchQueue.main.async {
//                                clouser(false)
//                            }
//                        }
//                    }
//                }
//            case .sharingDenied:
//                clouser(false)
//            case .sharingAuthorized:
//                clouser(true)
//            @unknown default:
//                clouser(false)
//            }
//        } else {
//            clouser(false)
//        }
//    }
//    
//    /**
//     家庭、住宅数据
//     
//     - parameters: action 权限结果闭包
//     */
//    class func authHomeKit(clouser: @escaping AuthClouser) {
//        if #available(iOS 13.0, *) {
//            switch HMHomeManager().authorizationStatus {
//            case .authorized:
//                clouser(true)
//            case .determined:
//                clouser(false)
//            case .restricted:
//                clouser(false)
//            default:
//                clouser(false)
//            }
//        } else {
//            if (HMHomeManager().primaryHome != nil) {
//                clouser(true)
//            } else {
//                clouser(false)
//            }
//        }
//    }
//    
//    /**
//     系统设置
//     
//     - parameters: urlString 可以为系统,也可以为微信:weixin://、QQ:mqq://
//     - parameters: action 结果闭包
//     */
//    @available(iOS 10.0, *)
//    class func authSystemSetting(urlString :String?, clouser: @escaping AuthClouser) {
//        var url: URL
//        if (urlString != nil) && urlString?.count ?? 0 > 0 {
//            url = URL(string: urlString!)!
//        } else {
//            url = URL(string: UIApplication.openSettingsURLString)!
//        }
//        
//        if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:]) { (result) in
//                if result {
//                    clouser(true)
//                } else {
//                    clouser(false)
//                }
//            }
//        } else {
//            clouser(false)
//        }
//    }
//}
