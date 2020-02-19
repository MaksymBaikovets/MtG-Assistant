//
//  CoreDataSource.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// -------------------------------------------------------------------
 // MARK: CoreData (NOT IMPLEMENTED) - EXAMPLE
 // -------------------------------------------------------------------

class HeadlinesCoreData: NSObject {
    
     func createData(){
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         //Now let’s create an entity and new user records.
         let userEntity = NSEntityDescription.entity(forEntityName: "Headline", in: managedContext)!
         
         //final, we need to add some data to our newly created record for each keys using
         //here adding 5 data with loop
         
         for i in 1...5 {
             
             let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
             user.setValue("Ankur\(i)", forKeyPath: "username")
             user.setValue("ankur\(i)@test.com", forKey: "email")
             user.setValue("ankur\(i)", forKey: "password")
         }

         //Now we have set all the values. The next step is to save them inside the Core Data
         
         do {
             try managedContext.save()
            
         } catch let error as NSError {
             print("Could not save. \(error), \(error.userInfo)")
         }
     }
 
     
     func retrieveData() {
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         //Prepare the request of type NSFetchRequest  for the entity
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Headline")
         
         fetchRequest.fetchLimit = 1
         fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
         fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
 
         do {
             let result = try managedContext.fetch(fetchRequest)
             for data in result as! [NSManagedObject] {
                 print(data.value(forKey: "username") as! String)
             }
         } catch {
             print("Failed")
         }
     }
     
     func updateData(){
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
         fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
         
         do {
             let test = try managedContext.fetch(fetchRequest)

             let objectUpdate = test[0] as! NSManagedObject
             objectUpdate.setValue("newName", forKey: "username")
             objectUpdate.setValue("newmail", forKey: "email")
             objectUpdate.setValue("newpassword", forKey: "password")
             do {
                 try managedContext.save()
             }
             catch {
                 print(error)
             }
         } catch {
             print(error)
         }
    
     }
     
     func deleteData(){
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Headline")
         fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
     
         do {
             let test = try managedContext.fetch(fetchRequest)
             
             let objectToDelete = test[0] as! NSManagedObject
             managedContext.delete(objectToDelete)
             
             do {
                 try managedContext.save()
             } catch {
                 print(error)
             }
             
         } catch {
             print(error)
         }
     }

}
