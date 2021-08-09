//
//  NetRequest.swift
//  WLSwiftDemo
//
//  Created by zhouweilong on 2021/8/8.
//

import UIKit
import Alamofire


typealias SuccessBlock = ([String:Any]) -> Void
typealias FailureBlock = (AnyObject) -> Void
typealias ProgressBlock = (Float) -> Void

class NetRequest: NSObject {
    
    static let shareInstance = NetRequest()
    private override init(){}

}

extension NetRequest {
    //MARK: - GET请求
       class func GET(url:String,param:[String:Any]?,success: @escaping SuccessBlock) {
           if param != nil {
               print("\n param:")
               print(param! as [String:Any])
           }
           print("url===:" + url)
           let urlPath:URL = URL(string: url)!
           let headers:HTTPHeaders = ["Content-Type":"application/json;charset=utf-8"]
           let request = AF.request(urlPath,method: .get,parameters: param,encoding: JSONEncoding.default, headers: headers)
           request.responseJSON { (response) in
               DispatchQueue.global().async(execute: {
                   print(response.result)
                   switch response.result {
                   case let .success(result):
                       do {
                           let resultDict:[String:Any] = result as! [String:Any]
                           DispatchQueue.main.async(execute: {
                               /** 返回码处理 */
                               let resp_code: Int = (resultDict["resp_code"] as! Int)
                               switch resp_code {
                               case 0:
                                   success(resultDict)
                               case 1: break
                                   // SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
                               default: break
                                   // SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
                               }
                           })
                       }
                   case let .failure(error):
                       // SVProgressHUD.dismiss()
                       print(error)
                   }

               })
           }
       }
       //MARK: - POST请求  字典参数 ["id":"1","value":""]
       class func POST(url:String,param:[String:Any]?,success: @escaping SuccessBlock) {
           if param != nil {
               print("\n param:")
               print(param! as [String:Any])
           }
           print("url===:" + url)
           let urlPath:URL = URL(string: url)!
           let headers:HTTPHeaders = ["Content-Type":"application/json;charset=UTF-8"]
           let request = AF.request(urlPath,method: .post,parameters: param,encoding: JSONEncoding.default, headers: headers)
           request.responseJSON { (response) in
               DispatchQueue.global().async(execute: {
                   print(response.result)
                   switch response.result {
                   case let .success(result):
                       do {
                           let resultDict:[String:Any] = result as! [String:Any]
                           DispatchQueue.main.async(execute: {
//                               /** 返回码处理 */
//                               let resp_code: Int = (resultDict["resp_code"] as! Int)
//                               switch resp_code {
//                               case 0:
//                                   success(resultDict)
//                               case 1: break
//
//                               default: break
                                  
//                               }
                           })
                       }
                   case let .failure(error):
                       print(error)
                   }

               })

           }
       }
       //MARK: - POST请求 数组参数（由于有数组参数的需求 ）[["id":"1","value":""],["id":"2","value":""]]
       class func POST2(url:String,param:Array<[String:String]>,success: @escaping SuccessBlock) {
           print("url===:" + url)
           let urlPath:URL = URL(string: url)!
           print("\n param:")
//        print(param as [String:Any])
           let data = try? JSONSerialization.data(withJSONObject: param, options: [])
           var urlRequest = URLRequest(url: urlPath)
           urlRequest.httpMethod = "POST"
           urlRequest.httpBody = data
           urlRequest.allHTTPHeaderFields = ["application/json":"Accept","application/json;charset=UTF-8":"Content-Type"]

           let request = AF.request(urlRequest)
           request.responseJSON { (response) in
               DispatchQueue.global().async(execute: {
                   print(response.result)
                   switch response.result {
                   case let .success(result):
                       do {
                           let resultDict:[String:Any] = result as! [String:Any]
                           DispatchQueue.main.async(execute: {
                               /** 返回码 (Int 类型code 会报崩) */
                               let code = resultDict["resp_code"]
                               var resp_code = 0
                               if code is String {
                                   resp_code = Int(code as! String)!
                               } else if code is Int {
                                   resp_code = code as! Int
                               }
                               switch resp_code {
                               case 0:
                                   success(resultDict)
                               case 1: break
                                   // SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
                               default: break
                                   //SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
                               }
                           })
                       }
                   case let .failure(error):
                       print(error)
                   }

               })

           }
       }
    /*
       //MARK: - 多图上传 UIImage 数组 [UIImage]
       class func IMGS(url:String,param:[String:Any],images:[UIImage],success: @escaping SuccessBlock) {
           let request = AF.upload(multipartFormData: { (mutilPartData) in
                  for image in images {
                      // 图片压缩 在下篇博客 https://editor.csdn.net/md/?articleId=106528518
                      let imgData = UIImage.imageCompress(image: image)
                      mutilPartData.append(imgData, withName: "files", fileName: String(String.getCurrentTimeStamp()) + ".jpg", mimeType: "image/jpg/png/jpeg")
                  }
                  //有参数
                  if param != nil {
                      for key in params.keys {
                          let value = params[key] as! String
                          let vData:Data = value.data(using: .utf8)!
                          mutilPartData.append(vData, withName: key)
                      }
                  }
           }, to: url, usingThreshold: UInt64.init(), method: .post, headers: [], interceptor: nil, fileManager: FileManager())
           request.uploadProgress { (progress) in
   //            SVProgressHUD.showInfo(withStatus: "正在上传图片")
           }
           request.responseJSON { (response) in
               print(response)
               DispatchQueue.global().async(execute: {
                   switch response.result {
                   case let .success(result):
                       do {
                           let resultDict:[String:Any] = result as! [String:Any]
                           DispatchQueue.main.async(execute: {
                               // type 1:部分上传成功,2:全部图片上传失败,0:全部上传成功
                               let resp_code: Int = (resultDict["resp_code"] as! Int)
                               switch resp_code {
                               case 0:
                                   success(resultDict)
                               case 1:
                                print("resultDict[resp_code] == 1")
                               default:
                                print("resultDict[resp_code] == default")
                               }
                           })
                       }
                   case let .failure(error):
                       print(error)
                   }
               })
           }
       }
       //MARK: - 多图上传 沙盒图片路径字符串"xxx.jpg;xxx.jpg"
       // 数组 替换imageString  (我这里处理的是SQLite存储的图片数据，所以封的字串)
       class func IMGPath(url:String,param:[String:Any],imageString:String,success: @escaping SuccessBlock) {
           let request = AF.upload(multipartFormData: { (mutilPartData) in
               let list:[String] = imageString.components(separatedBy: ";")
               for i in 0..<list.count {
                   if list[i].count > 0 {
                       mutilPartData.append(URL(fileURLWithPath: list[i]), withName: "files", fileName: String(String.getCurrentTimeStamp()) + "_" + String(i) + ".jpg", mimeType: "image/jpg/png/jpeg")
                   }
              }
               // 有参数
               if param != nil {
                   for key in param.keys {
                       let value = param[key] as! String
                       let vData:Data = value.data(using: .utf8)!
                       mutilPartData.append(vData, withName: key)
                   }
               }
           }, to: url, usingThreshold: UInt64.init(), method: .post, headers: [], interceptor: nil, fileManager: FileManager())
           request.uploadProgress { (progress) in
               print(progress)
           }
           request.responseJSON { (response) in
               print(response)
               DispatchQueue.global().async(execute: {
                   switch response.result {
                   case let .success(result):
                       do {
                           let resultDict:[String:Any] = result as! [String:Any]
                           DispatchQueue.main.async(execute: {
                               // type 1:部分上传成功,2:全部图片上传失败,0:全部上传成功
                               let resp_code: Int = (resultDict["resp_code"] as! Int)
                               switch resp_code {
                               case 0:
                                   success(resultDict)
                               case 1:
                                  print("resultDict[resp_code] == 1")
                               default:
                                print("resultDict[resp_code] == default")
                               }
                           })
                       }
                   case let .failure(error):
                       print(error)
                   }
               })
           }
       }*/
}
