//
//  StatisticsDataSource.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 13.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import CoreData

class StatisticsDataSource: NSObject {
    
    // -------------------------------------------------------------------
    // MARK: Properties
    // -------------------------------------------------------------------

    var headlines: [StatisticsHeadline]
    var coreHeadlines: [NSManagedObject] = []

    static func generateStatisticsData() -> [StatisticsHeadline] {
        return []
    }
    
    // -------------------------------------------------------------------
    // MARK: - Initializers
    // -------------------------------------------------------------------

    override init() {
        headlines = StatisticsDataSource.generateStatisticsData()
        super.init()
        
        coreDataFetch()
        coreDataToStatisticsHeadline()
    }

    // -------------------------------------------------------------------
    // MARK: - Core Data Methods
    // -------------------------------------------------------------------
    
    func coreDataFetch() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
      
        let managedContext =
            appDelegate.persistentContainer.viewContext
      
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Headline")
      
        do {
            coreHeadlines = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    // -------------------------------------------------------------------

    func coreDataRemoveRow(at indexPath: IndexPath) {
              
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
      
        let managedContext =
            appDelegate.persistentContainer.viewContext
      
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Headline")
        
        do {
            coreHeadlines = try managedContext.fetch(fetchRequest)
            
            let rowToRemove = coreHeadlines[indexPath.row]
            managedContext.delete(rowToRemove)

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save after delete. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    // -------------------------------------------------------------------
    
    func saveToCoreData(firstPlayer: String,
              secondPlayer: String,
              firstDeck: String,
              secondDeck: String,
              result: String, date: String) {
      
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else { return }
      
        let managedContext =
            appDelegate.persistentContainer.viewContext
      
        let entity =
            NSEntityDescription.entity(forEntityName: "Headline",
                                       in: managedContext)!
      
        let headlineData = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
      
        headlineData.setValuesForKeys(["firstPlayer": firstPlayer,
                                       "secondPlayer": secondPlayer,
                                       "date": date,
                                       "result": result,
                                       "firstPlayerDeck": firstDeck,
                                       "secondPlayerDeck": secondDeck])
        print(headlineData)
        
        do {
            try managedContext.save()
            coreHeadlines.append(headlineData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
     // -------------------------------------------------------------------
     // TODO: Update rows in CORE data
    
     func updateRowInCoreData(firstPlayer: String,
               secondPlayer: String,
               firstDeck: String,
               secondDeck: String,
               gameResult: String, date: String) {
        

       
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else { return }
       
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Headline")
        
        print(gameResult)
        let predicate = NSPredicate(format: "result = %@ AND date = %@", argumentArray: [gameResult, date])
        fetchRequest.predicate = predicate

        do {
            let  rs = try managedContext.fetch(fetchRequest)

            for _ in rs as [NSManagedObject] {

                // update
                do {
                    let managedObject = rs[0]
                    managedObject.setValuesForKeys(["firstPlayer": firstPlayer,
                                                    "secondPlayer": secondPlayer,
                                                    "date": date,
                                                    "result": gameResult,
                                                    "firstPlayerDeck": firstDeck,
                                                    "secondPlayerDeck": secondDeck])

                    try managedContext.save()
                    print("Update successfull")

                } catch let error as NSError {
                    print("Could not Update. \(error), \(error.userInfo)")
                }
                //end update

            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
     }
    
    // -------------------------------------------------------------------

    func coreDataToStatisticsHeadline() {
        
        for row in coreHeadlines {
            let coreFirstPlayer = row.value(forKey: "firstPlayer") as? String ?? ""
            let coreSecondPlayer = row.value(forKey: "secondPlayer") as? String ?? ""

            let coreResult = row.value(forKey: "result") as? String ?? ""
            let coreDate = row.value(forKey: "date") as? String ?? ""
            
            let coreFirstDeck = row.value(forKey: "firstPlayerDeck") as? String ?? ""
            let coreSecondDeck = row.value(forKey: "secondPlayerDeck") as? String ?? ""

            let result = StatisticsHeadline(
                firstPlayer: coreFirstPlayer,
                secondPlayer: coreSecondPlayer,

                date: coreDate,
                result: coreResult,
                firstPlayerDeck: coreFirstDeck,
                secondPlayerDeck: coreSecondDeck
            )
            
            headlines.append(result)
        }
        
    }

    // -------------------------------------------------------------------
    // MARK: - Datasource Methods
    // -------------------------------------------------------------------

    func numberOfGames() -> Int {
        headlines.count
    }

    // -------------------------------------------------------------------

    func append(haedline: StatisticsHeadline, to tableView: UITableView) {
        headlines.append(haedline)
        tableView.insertRows(at: [IndexPath(row: headlines.count - 1, section: 0)], with: .automatic)
    }
    
    // -------------------------------------------------------------------
    // TODO: Update row in datasource
    
    func update(haedline: StatisticsHeadline, to tableView: UITableView, at indexPath: IndexPath) {
        headlines[indexPath.row] = haedline
    }
    
    // -------------------------------------------------------------------

    func delete(to tableView: UITableView, at indexPath: IndexPath) {
        coreDataFetch()
        print("Rows before deletion: \(coreHeadlines.count)")
        
        coreDataRemoveRow(at: indexPath)
        coreDataFetch()
        print("Rows after deletion: \(coreHeadlines.count)")
        
        headlines.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    // -------------------------------------------------------------------

    func game(at indexPath: IndexPath) -> StatisticsHeadline {
        headlines[indexPath.row]
    }

}

