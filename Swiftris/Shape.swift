//
//  Shape.swift
//  Swiftris
//
//  Created by Rafaela Oliveira on 14/12/20.
//
import SpriteKit
let NumOrientations: UInt32 = 4
enum Orientation: Int, CustomStringConvertible{
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    var description: String{
        switch  self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation{
        return Orientation(rawValue:Int(arc4random_uniform(NumOrientations)))!
    }
    
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation{
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated >  Orientation.TwoSeventy.rawValue{
            rotated = Orientation.Zero.rawValue
        } else if rotated < 0{
            rotated = Orientation.TwoSeventy.rawValue
        }
        return Orientation(rawValue: rotated)!
    }
    
    
}

// The number of total shape varieties
let NumShapeTypes: UInt32 = 7


//Shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3


class Shape: Hashable, CustomStringConvertible{
    //the color of the shape
    let color: BlockColor
    
    //the blocks comprising the shape
    var blocks = Array<Block>()
    //the current orientation of the shape
    var orientation: Orientation
    //the column and row representing the shape's anchor point
    var column, row: Int
    
    //required Overrides
    
    //subclasses must override this property
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]{
        return [:]
    }
    
    // Subclasses must override this property
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    var bottomBlocks:Array<Block> {
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        return bottomBlocks
    }
    var hashValue:Int {
        // #5
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    // CustomStringConvertible
    var description:String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    init(column:Int, row:Int, color: BlockColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
    }
    
    // #6
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientation:Orientation.random())
    }
    
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPositions[orientation] else {
            return
        }
        // #8
        blocks = blockRowColumnTranslations.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        }
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}



