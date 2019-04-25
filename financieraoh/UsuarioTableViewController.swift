//
//  UsuarioTableViewController.swift
//  financieraoh
//
//  Created by Alexis Arroyo Diaz on 25/04/19.
//  Copyright © 2019 Alexis Arroyo Diaz. All rights reserved.
//

import Foundation


class UsuarioTableViewController : UITableViewController {

    var usuarios : NSMutableArray!
    
    override func viewDidLoad(){
        
        //Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UsuarioTableViewController.cargarData), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        
        
        
        //Custom TableViewCell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        cargarData()
    }
    
    func cargarData(){
        
        let objDAO = UsuarioDAO()
        usuarios = objDAO.list()
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        var usuarioCurrent = Usuario()
        usuarioCurrent = usuarios[indexPath.row] as! Usuario
        
        let nombreCompleto : String = "\(usuarioCurrent.nombre) \(usuarioCurrent.apellidos)"
        cell?.textLabel?.text = nombreCompleto
        
        return cell!
    }
    
}
