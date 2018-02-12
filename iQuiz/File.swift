//
//  File.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/11/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class Quiz {
    var icon: UIImage
    var title: String
    var desc: String
    
    init(icon: UIImage, title: String, desc: String) {
        self.icon = icon
        self.title = title
        self.desc = desc
    }
}
