//
//  ViewController.swift
//  MatrixSpiralPrint
//
//  Created by Avinash Yachamaneni on 8/14/19.
//  Copyright © 2019 Avinash Yachamaneni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = Array(repeating: Array(repeating: 0, count: 5), count: 5)
        var count:Int = 50
        
        var a:Int = 10
        var b:Int = 5
        print(abs(a-b))
        print(abs(b-a))

        for i in 0...4 {
            for j in 0...4 {
                arr[i][j] = count
                count = count + 5
            }
        }
        for i in 0...4 {
            for j in 0...4 {
                print(arr[i][j])
            }
        }
    }

}
