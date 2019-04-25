//
//  UsuarioDAO.swift
//  financieraoh
//
//  Created by Alexis Arroyo Diaz on 25/04/19.
//  Copyright © 2019 Alexis Arroyo Diaz. All rights reserved.
//

import Foundation


class UsuarioDAO {
    
    func add(_ usuario:Usuario){
        let objBD = UtilDataBase()
        objBD.ejecutarInsert("INSERT INTO ADM_USUARIO (NCODUSUARIO,SNOMBRE) VALUES((SELECT COUNT(*)+1 from ADM_USUARIO),'\(usuario.nombre)')")
    }
    
    
    func list()->NSMutableArray{
        let objBD = UtilDataBase()
        let arrayDatos:NSArray = objBD.ejecutarSelect("SELECT NCODUSUARIO,SNOMBRE FROM ADM_USUARIO") as NSArray
        let datos = NSMutableArray()
        for index in 0...Int(arrayDatos.count) {
            let usuario = Usuario()
            //let IdUsuario = arrayDatos[index][1] as! String
  
            //usuario.IdUsuario = arrayDatos[index]["NCODUSUARIO"] as! [String Any();]
            //usuario.nombre = arrayDatos[index]["SNOMBRE"] as! [String Any]
            
            let item =  arrayDatos[index] as! NSArray
            usuario.IdUsuario  = item.object(at: 0) as! String
                //arrayDatos[index]["NCODEQUIPOFUTBOL"] as! String
            
            datos.add(usuario)
        }
        return datos
    }
    
}
