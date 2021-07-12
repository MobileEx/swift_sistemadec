//
//  ConfirmacionLista.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 3/18/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//

import UIKit
import MessageUI


class ConfirmacionLista: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var myDict = [String:String]()
    var myArray = [[String:String]]()
     var sections = [Section()]
    var esLocal = Bool()
    var arr = [String]()
    var nomvia = String()
   var userD = UserDefaults.standard
    var resRef = [String]()
    var local = String()
    var set = Int()
    var f = String()
    var saveExtended = Bool()
    var saveInfo = [String:[String]]()
    var pathr = 0
    var paths = 0
    
    
    var DicArray = [String:[String]]()
    

    
    
    func getdata() {
       
        do {
            let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
         
            
            for result in searchResultRef as [Referencia] {
             
               
             
                
                let letters = CharacterSet.letters
                let digits = CharacterSet.decimalDigits

                var letterCount = 0
                var digitCount = 0

                let phrase = "\(String(describing: result.suplidor))"
                for uni in phrase.unicodeScalars {

                    if letters.contains(uni) {
                        letterCount += 1
                    } else if digits.contains(uni) {
                        digitCount += 1
                    }
                }
//                print("DIGITS: \(letterCount) Numbers: \(digitCount)")
                
                if digitCount > 1 {

                    esLocal = true  // si es local
                   
                } else {
                    esLocal = false // si es factoria
                   }

                
                if esLocal == true {
                    if result.observacion != "" {
        

                    arr.append("\(result.suplidor!)")
                        
                    
                    }
                    
                    
                    
                }


                esLocal = Bool()
           }
            
        } catch {
            print ("Error")
        }
     
        
      arr = Array(Set(arr))  // remove duplicate from array
  
          arr = arr.sorted { $0 < $1 }
        
        
        print("\(arr)")
        do {
            let searchResultRef1 = try DatabaseController.getContext().fetch(fetchRequestRef)
            
            
            
            
            
            for i in arr {
            
            for result1 in searchResultRef1 as [Referencia] {
                
                if i == result1.suplidor {
                    
                    if result1.observacion != "" {
                        local = "\(i)     Calle: \(result1.calle!)"
                        resRef.append("\(result1.referencia!)")
                    
                        
                      
                        
                    }
                    
                }
            }
                
                let a = Section(local: local,
                    itemno: resRef,
                    expanded: false)
                saveInfo[local] = resRef
                sections.append(a)
            
              
                local = ""
                resRef = []
                
            }
            
          
            
            } catch {
            print("error")
            }
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    ////
    override func viewDidLoad() {
        super.viewDidLoad()
///////////
        
        
        
//        (format: "firstName == %@", firstName)
        getdata()

//        if let tempIPATH1 =  userD.object(forKey: "cindexpathrow") {
//            pathr = userD.object(forKey: "cindexpathrow") as! Int
//        }
//        if let tempIPATH2 =  userD.object(forKey: "cindexpathsec") {
//            paths = userD.object(forKey: "cindexpathsec") as! Int
//        }
//        
//        
//        //
//        let pathToLastRow = IndexPath.init(row: pathr, section: paths)
//        print("\(pathToLastRow)")
//        
//        tableView.scrollToRow(at: pathToLastRow, at: .middle, animated: true)
//      
        
        ///////////
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func EnviarPresionado(_ sender: UIButton) {
        sender.flash()
//        print("\(saveInfo)")
        let fileName = "confirmacion.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "LISTA DE CONFIRMACION,\n"
        
        for (key,values) in saveInfo {
            
            let local = key
            let newLine = "\(local)\n"
            csvText.append(newLine)
            
//            var ref = String()
            
            for i in values {
             let newLine = "\(i)\n"
                csvText.append(newLine)
            }
            print ("LOCAL:\(key)  y REFERECIAS \(values) ")
            
        }
        
        
        
        
        
        
        
//        let newLine = "\("d")\n"
//
//        csvText.append(newLine)
        
        
        
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            //                print("File CREATED")
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["cajunsniper@hotmail.com"]) // CORREO A SER ENVIADO
                mail.setSubject("Lista de Confirmacion") // SUBJECT PEDIDO
                mail.setMessageBody("<p>Estas son las tiendas con su referencia que devemos confirmar</p>", isHTML: true)

                present(mail, animated: true)
                mail.addAttachmentData(NSData(contentsOf: path!)! as Data, mimeType: "text/csv", fileName: "confirmacion`.csv")

            } else {
                // show failure alert
            }
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = UIColor.clear
////        self.tableView.backgroundColor = UIColor.lightGray
//    }
//
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        tranSecPed = recuperarPed
//        secpedido2 = recuperarPed
        
        controller.dismiss(animated: true)
        //       self.performSegue(withIdentifier: "listaPedido2Pedido", sender: nil)
//        regreso = true
//        viewDidLoad()
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.backgroundColor = UIColor.yellow
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemno.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].local, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].itemno[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].itemno.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
          
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        set = 2
        tableView.deselectRow(at: indexPath, animated: true)

//        f = "\(sections[indexPath.section].itemno[indexPath.row])"
//  print("DIDSELECT \(f)")
        userD.set(indexPath.row, forKey: "cindexpathrow")
        userD.set(indexPath.section, forKey: "cindexpathsec")
//        userD.set(indexPath, forKey: "fullindexpath")
        userD.synchronize()
        
         performSegue(withIdentifier: "confirmar2Registrar", sender: sections[indexPath.section].itemno[indexPath.row])

    }

    @IBAction func atrasPress(_ sender: UIButton) {
        set = 0
        dismiss(animated: true, completion: nil)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if set == 2 {
           
      
                let guest = segue.destination as! RegistrarReferencia
                guest.secReferencia = sender as! String
                guest.existe = true
                guest.fromPedido = false
                guest.fromDetPedCrear = false
                guest.fromMenuaCustome = false
                guest.noSequence = false
                guest.fromConfirmar = true
           
        
        } else {
            
        }

        
      }
  
    
    
    
    
    
    
    
    
    
    
}
