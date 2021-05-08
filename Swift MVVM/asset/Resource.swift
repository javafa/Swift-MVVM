//
//  Resource.swift
//  MathflatTeacher
//
//  Created by DONHO KO on 2020/10/22.
//

import Foundation
import UIKit

struct Dimension {
    
    struct Launcher {
        
    }
    
    struct Main {
        
        struct Header {
            static let height:CGFloat = 64
            
            struct Tab {
                
                struct Item {
                    static let width:CGFloat = 100
                }
            }
        }
        
        struct Body {
            
            struct Padding {
                static let top:CGFloat = 20
                static let bottom:CGFloat = 20
                static let left:CGFloat = 20
                static let right:CGFloat = 20
            }
        }
        
        struct Footer {
            
            struct Tab {
                
                struct Item {
                    static let width:CGFloat = 100
                }
            }
        }
    }
    
    struct Content {
        
        struct Header {

        }
        
        struct Body {
            
        }
        
        struct Footer {
            
        }
    }
    
    struct List {
        
        struct Item {
            static let height:CGFloat = 30
        }
    }
}

