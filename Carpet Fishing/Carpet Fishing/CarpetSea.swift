//
//  CarpetSea.swift
//  Carpet Fishing
//
//  Created by Drew Bies on 10/17/20.
//

import Foundation

class CarpetSea: CustomStringConvertible{
    var N: Int
    let S: Int = 60
    var grid = [[Cell]]()
    var availableFish = ["🐟" : 1, "🐠" : 3, "🐡" : 5, "🦞": 7, "🦑": 10, "🦀" : 12, "🐋" : 15]
    var lineRow: Int = 0
    var lineCol: Int = 0
    var description: String {
        var str = ""
        for x in 0..<N{
            let col = grid[x]
            for y in 0..<N{
                str.append("\(x),\(y): \(col[y]) ")
            }
            str.append("\n")
        }
        return str
    }
    
    // makes a carpetSea object with a N by N grid
    init(){
        N = 2
        for x in 0..<N{
            grid.append([])
            for y in 0..<N{
                grid[x].append(Cell(row: x, col: y, fish: ""))
            }
        }
        randomlyPlaceFish()
    }
    
    // randomly places a fish onto one of the cells
    func randomlyPlaceFish(){
        let row = Int.random(in: 0..<N)
        let col = Int.random(in: 0..<N)
        let fish = availableFish.randomElement()?.key
        grid[row][col].fish = fish
    }
    
    // drops the fishing line on the cell with row and col
    func dropFishingLine(row: Int, col: Int){
        grid[row][col].containsLine = true
        lineRow = row
        lineCol = col
    }
    
    // returns the fish from the cell the line is on
    // if there is no fish, nil is returned
    func checkFishCaught() -> String?{
        let lineCell = grid[lineRow][lineCol]
        if(lineCell.containsFish){
            return lineCell.fish
        } else{
            return nil
        }
    }
    
    // remove the fish from the grid
    func resetGrid(){
        for x in 0..<N{
            for y in 0..<N{
                let cell = grid[x][y]
                cell.fish = ""
                cell.containsLine = false
            }
        }
    }
}
