//
//  ScoreTableViewController.swift
//  guessWhat_T12
//
//  Created by Harry Archer on 2019-04-13.
//  Copyright © 2019 T12. All rights reserved.
//
import UIKit
import SQLite3

class ScoreTableViewController: UITableViewController {
    
    
    
    var db:OpaquePointer?
    var scores = [Score]()
    
    func readValues(){
        scores.removeAll()
        let q = "SELECT * FROM Scores ORDER BY score DESC, id ASC"
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, q, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(stmt, 0))
            let username = String(cString: sqlite3_column_text(stmt, 1))
            let score = Int(sqlite3_column_int(stmt, 2))
            var c = Score(id: id, username: username, score: score)
            scores.append(c)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let file = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("database.db")
        
        if sqlite3_open(file.path, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            let create = "CREATE TABLE IF NOT EXISTS Scores (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, score INTEGER)"
            if sqlite3_exec(db, create, nil, nil, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db))
                print("error creating db: \(err)")
            }
        }
        
        //addSample();
        readValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        tableView.reloadData()
    }
    
    func addSample() {
        let insert = "INSERT INTO Scores(username, score) VALUES (?,?)"
        var stmt:OpaquePointer?
        
        for i in 1...10 {
            if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db))
                print("error preparing statement: \(err)")
                return
            }
            if sqlite3_bind_text(stmt, 1, "User\(i)", -1, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db))
                print("error binding username: \(err)")
                return
            }
            if sqlite3_bind_int(stmt, 2, Int32(i)) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db))
                print("error binding score: \(err)")
                return
            }
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(db))
                print("error executing insert: \(err)")
                return
            }
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = scores[indexPath.row].username
        cell.detailTextLabel?.text = String(scores[indexPath.row].score)
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            let dc = segue.destination as! ViewController
            dc.score = scores[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
