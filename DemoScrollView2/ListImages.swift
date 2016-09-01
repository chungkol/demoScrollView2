//
//  ListImages.swift
//  DemoScrollView2
//
//  Created by Chung on 9/1/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit

class ListImages: UIViewController {
    
    @IBAction func onTouch(sender: UIButton) {
        switch (sender.tag) {
        case 101: pushView(0)
        case 102: pushView(1)
        case 103: pushView(2)
        default: break
            
        }
    }
    
    func pushView(index: Int)
    {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
}
