//
//  ViewController.swift
//  DecoratorPatternCell
//
//  Created by LiTengFang on 2017/7/18.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    fileprivate var dataSouce: [CellModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataSouce =  [CellModel(title: "默认风格", imageName: nil, response:{[unowned self] in
            
            self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .default), animated: true)
            print("push 页面")
        }),
                      CellModel(title: "蓝底风格", imageName: nil, response: {[unowned self] in
                        
                        self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .blue), animated: true)
                      }),
                      CellModel(title: "白边阴影风格", imageName: nil ,response: {[unowned self] in
                        
                       self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .whiteAndShodow), animated: true)
                      }),
                      CellModel(title: "自定义风格", imageName: nil ,response: {[unowned self] in
                        
                        self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .custom), animated: true)
                      }),
                      CellModel(title: "加载xibCell", imageName: nil ,response: {[unowned self] in
                        
                        self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .loadXib), animated: true)
                      }),
                      CellModel(title: "加载普通View", imageName: nil ,response: {[unowned self] in
                        
                        self.navigationController?.pushViewController(DetailTableViewController(style: .plain, cellStyle: .loadNormalView), animated: true)
                      }),
                      
                      CellModel(title: "添加辅助View", imageName: nil ,response: {[unowned self] in
                        
                        print("push 页面")
                      }),
            
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? =  tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataSouce[indexPath.row].title
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSouce[indexPath.row].response()
        
    }

}

