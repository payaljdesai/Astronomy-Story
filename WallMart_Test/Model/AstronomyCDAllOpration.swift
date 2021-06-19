//
//  AstronomyCDAllOpration.swift
//  WallMart_Test
//
//  Created  on 19/06/21.
//

import Foundation
import CoreData
import UIKit

class AstronomyCDAllOpration
{
    func InsertData(data : [String :String]) -> Any{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new PicOfDayData records.
        let picDataEntity = NSEntityDescription.entity(forEntityName: "PicOfDayData", in: managedContext)!
        
        
            
            let entity = NSManagedObject(entity: picDataEntity, insertInto: managedContext)
        entity.setValue(data["date"], forKeyPath: "date")
        entity.setValue(data["title"], forKeyPath: "title")
        entity.setValue(data["explanation"], forKeyPath: "explanation")
        entity.setValue(data["url"], forKeyPath: "imageUrl")
        entity.setValue(Date.getCurrentDateAndTime(), forKeyPath: "lastSeenDateAndTime")
        

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            return entity
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return false
    }
    
    func getTimestamp()-> String {
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
      return timestamp
    }
    func retrieveData() -> Any {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PicOfDayData")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "date = %@", Date.getCurrentDate())
//
        do {
            let result = try managedContext.fetch(fetchRequest)
            if(result.count>0)
            {
              return result.last
            }
            
            
        } catch {
            
            print("Failed")
        }
        return false
    }
    func retrieveOldData() -> Any {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PicOfDayData")
        
        fetchRequest.fetchLimit = 1
//
        do {
            let result = try managedContext.fetch(fetchRequest)
            if(result.count>0)
            {
              return result.last
            }
            
            
        } catch {
            
            print("Failed")
        }
        return false
    }
    
    func updateData(dateandtime :String ){
    
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "PicOfDayData")
        fetchRequest.predicate = NSPredicate(format: "date = %@", Date.getCurrentDate())
        do
        {
            let test = try managedContext.fetch(fetchRequest)
   
            if(test.count>0)
            {
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(dateandtime, forKeyPath: "lastSeenDateAndTime")

            }
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        catch
        {
            print(error)
        }
   
    }
    
     func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PicOfDayData")
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if(test.count>0)
            {
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            }
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    
}
