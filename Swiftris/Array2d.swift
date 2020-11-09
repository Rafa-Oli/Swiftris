//
//  Array2d.swift
//  Swiftris
//
//  Created by Rafaela Oliveira on 09/11/20.
//

import Foundation
class Array2d<T>{
    let columns: Int
    let rows: Int
    

    var array: Array<T?>
    
    init(columns: Int, rows: Int){
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(repeating: nil,count:rows * columns)
    }
    subscript(column: Int, row: Int) -> T?{
        get{
            return array[(row * columns) + column]
        }
        set(newValue){
            array[(row * columns) + column] = newValue
        }
    }
    
    
}
