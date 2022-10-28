import ScadeKit
import SQLite
import Foundation
  
class MainPageAdapter: SCDLatticePageAdapter {
  
 var lab : String = ""
  
  var tempData = [
    ["Vedant", "6vedant@gmail.com"], ["Sam", "sam@gmail.com"], ["Manisha", "mansiha@gmail.com"],
    ["Alice", "alice@gmail.com"],
  ]


	
	// page adapter initialization
	override func load(_ path: String) {		
		super.load(path)
		
		self.read_btn.onClick{ _ in 
			print("Reading DB")
		}
		
		
		do {
			let db = try Connection(NSHomeDirectory() + "/data.db")
	
			let users = Table("users")
			let id = Expression<Int64>("id")
			let name = Expression<String?>("name")
			let email = Expression<String>("email")
			
			// ignore potentical exception
			_  = try? db.run(users.create { t in
			    t.column(id, primaryKey: true)
			    t.column(name)
			    t.column(email, unique: true)
			})
			// CREATE TABLE "users" (
			//     "id" INTEGER PRIMARY KEY NOT NULL,
			//     "name" TEXT,
			//     "email" TEXT NOT NULL UNIQUE
			// )
			var i = 0
			
			self.write_btn.onClick { _ in
				
				print("Insert option triggered")
				i += 1
				if i > 2 {
					i = i % 3
				}
				
				do {
					let insert = users.insert(name <- self.tempData[i][0], email <- self.tempData[i][1])
					
					let rowid = try db.run(insert)
				} catch {
					print("Error at insert operation")
				}
			}
			
			
			self.read_btn.onClick { _ in 
				print("reading db")
				do {
					var resultStr = ""
					
					for user in try db.prepare(users) {
						self.lab = "id: \(user[id]), name: \(user[name]), email: \(user[email])"
						resultStr = "\(resultStr) \n \(self.lab) \n"
					}
					self.label.text = resultStr
				} catch {
					print("Error at read operation")
				}
			}
			
			
			self.update_btn.onClick { _ in 
				print("Update operation triggered")
				
				do {
					let rowItem = users.filter(1 == rowid)
						
						try db.run(rowItem.update(email <- email.replace("gmail", with: "yahoo")))
				} catch {
					print("error in update operation")
				}
				
				
			}
			
			
			self.del_btn.onClick { _ in 
				print("Del operation triggered")
				
				do {
					let rowItem = users.filter(1 == rowid) 
					try db.run(rowItem.delete())	
					
				} catch {
					print("Error in delete operation")
				}
				
			}
			
									// SELECT * FROM "users"
			
			let alice = users.filter(id == rowid)
			
			try db.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
			// UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
			// WHERE ("id" = 1)
			
			try db.run(alice.delete())
			// DELETE FROM "users" WHERE ("id" = 1)
			
			try db.scalar(users.count) // 0
			// SELECT count(*) FROM "users"
			
			}
		catch {
			print("ERROR: \(error)")
		}
		
	}


}
