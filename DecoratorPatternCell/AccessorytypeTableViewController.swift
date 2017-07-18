//
//  AccessorytypeTableViewController.swift
//  DecoratorPatternCell
//
//  Created by LiTengFang on 2017/7/18.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class AccessorytypeTableViewController: UITableViewController {

    fileprivate var dataSouce: [CellModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        dataSouce =  [CellModel(title:"个人中心",imageName:"shareQRCode",response:{[unowned self] in
            
            print("push 页面")
        }),
                      CellModel(title:"设置",imageName:"shareQRCode",response:{[unowned self] in
                        
                        print("push 页面")
                      }),
                      CellModel(title:"退出",imageName:"shareQRCode",response:{[unowned self] in
                        
                        print("push 页面")
                      })
            
        ]
        
        tableView.rowHeight = 80
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSouce.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var aAndroidStyleCell: DecoratorCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! DecoratorCell?
        if aAndroidStyleCell == nil {
            
            
            let cell = SystemDefaultStyleCell(style: .default, reuseIdentifier: "cell")
            
            aAndroidStyleCell = DecoratorCell(reuseIdentifier: "reuseIdentifier",
                                              contextCell: cell,
                                              borderStyle: .blue)
            
        }
        
        
        // Configure the cell...
        let cell: SystemDefaultStyleCell = aAndroidStyleCell!.contextCell as! SystemDefaultStyleCell
        cell.titleLabel.text = dataSouce[indexPath.row].title
        if let imageName = dataSouce[indexPath.row].imageName {
            cell.aImageView.image = UIImage(named: imageName)
        }
        
        
        switch indexPath.row {
        case 0,2,4:
            aAndroidStyleCell?.accessoryType = .disclosureIndicator
        default:
            aAndroidStyleCell?.accessoryType = .none
        }
        
        
        return aAndroidStyleCell!
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSouce[indexPath.row].response()
    }

}
