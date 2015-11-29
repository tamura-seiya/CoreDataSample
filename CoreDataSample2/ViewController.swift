//
//  ViewController.swift
//  CoreDataSample2
//
//  Created by tamura seiya on 2015/10/29.
//  Copyright (c) 2015年 Seiya Tamura. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CoreDataのTodo Entityに接続し、情報を取得する
        //データの読み込みなので、read()関数を定義する
        
        read()
    }

    func read(){
    //Delegateを読み込む
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Entityの操作を制御するmanagedObjectContextをAppdelegateから作成する
         let managedObjectContext = appDelegate.managedObjectContext
        
            //Entityを設定
            let entityDiscription = NSEntityDescription.entityForName("ToDo", inManagedObjectContext: managedObjectContext)
            
            let fetchRequest = NSFetchRequest(entityName: "ToDo")
            fetchRequest.entity = entityDiscription
            
            
            
            do{
                let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                for managedObject in fetchResults!{
                    let todo = managedObject as! ToDo
                    print("title: \(todo.title), saveDate:\(todo.sameDate),Dict:\(todo.dictionary)")
                    
                }
                
                
            }catch{
                print("could not catch")
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSaveBtn(sender: AnyObject) {
        //delegateからデータを呼び込むための、定義(get the discription entity name)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Entityの操作を制御するmanagedObjectContextをAppdelegateから作成する
         let managedObjectContext = appDelegate.managedObjectContext
            
            //新しくデータを追加するためのEntityを作成します
            let managedObject: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("ToDo", inManagedObjectContext: managedObjectContext)
            
            
            
            //Todo EntityからObjectを生成し、 Attributesに接続して値を代入
            let todo = managedObject as! ToDo
            todo.title = "hogehoge"
            todo.sameDate = NSDate() //現在の日時を返す（追加したらそこに日時を返してくれる）
            
            //save データの保存
            //CoreDataは少し特殊で上記でAtrributesにデータを追加するだけでは、すぐに保存処理はできません
            //applicationWillTerminal内のSaveController()が発動した後に保存処理が実行されます
            //よくCoreDataを使用していて起こるのは、これを忘れていてデータの読み込み処理は正常に動作しているのに
            //保存がなぜかされない。
            
            //データの保存の処理
            appDelegate.saveContext()
                
        
    }
    
    @IBAction func tapDicBtn(sender: AnyObject) {
        //delegateからデータを呼び込むための、定義(get the discription entity name)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Entityの操作を制御するmanagedObjectContextをAppdelegateから作成する
         let managedObjectContext = appDelegate.managedObjectContext
            
            //新しくデータを追加するためのEntityを作成します
            let managedObject: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("ToDo", inManagedObjectContext: managedObjectContext)
            
            
            
            //Todo EntityからObjectを生成し、 Attributesに接続して値を代入
            let todo = managedObject as! ToDo
            let thedictionary = ["name":"hachinobu", "age": 28]
            let arrayData : NSData = NSKeyedArchiver.archivedDataWithRootObject(thedictionary)
            print("thedictionaru = \(thedictionary)")
            todo.dictionary = arrayData
            todo.sameDate = NSDate() //現在の日時を返す（追加したらそこに日時を返してくれる）
            
            
//            NSDictionary *priority = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"hoge", nil];
//            article.priority = priority;
//            [context save:nil];
            
            //save データの保存
            //CoreDataは少し特殊で上記でAtrributesにデータを追加するだけでは、すぐに保存処理はできません
            //applicationWillTerminal内のSaveController()が発動した後に保存処理が実行されます
            //よくCoreDataを使用していて起こるのは、これを忘れていてデータの読み込み処理は正常に動作しているのに
            //保存がなぜかされない。
            //データの保存の処理
            appDelegate.saveContext()
            
        
    }




    @IBAction func tapDeleteBtn(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Entityの操作を制御するmanagedObjectContextをAppdelegateから作成する
           let managedObjectContext = appDelegate.managedObjectContext
            
            //Entityを設定する設定
            let entityDiscription = NSEntityDescription.entityForName("ToDo", inManagedObjectContext: managedObjectContext)
            
            let fetchRequest = NSFetchRequest(entityName: "ToDo")
            fetchRequest.entity = entityDiscription
            
            //データを一件取得する
            let predicate = NSPredicate(format: "%K = %@", "title","hogehoge")
            fetchRequest.predicate = predicate
        
            
            
            do{
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                for managedObject in fetchResults!{
                    let todo = managedObject as! ToDo
                    print("削除するデータ => title: \(todo.title), saveDate:\(todo.sameDate)")
                    
                    //削除処理の本体
                    managedObjectContext.deleteObject(managedObject)
                    
                    //削除したことも保存しておかないと反映されないので注意
                    appDelegate.saveContext()
                }

                
            }catch{
                print("could not catch")
            }
            }
            
            //フェッチリクエストの実行
//            if var  results = managedObjectContext.executeFetchRequest(fetchRequest, error: error){
//            println(results.count)
//                
//                for managedObject in results{
//                    let todo = managedObject as! ToDo
//                    println("削除するデータ => title: \(todo.title), saveDate:\(todo.sameDate)")
//                    
//                    //削除処理の本体
//                    managedObjectContext.deleteObject(managedObject as! NSManagedObject)
//                    
//                    //削除したことも保存しておかないと反映されないので注意
//                    appDelegate.saveContext()
//                }
//            }
        
    
    }


