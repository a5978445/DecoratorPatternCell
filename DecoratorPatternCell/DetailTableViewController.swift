//
//  DetailTableViewController.swift
//  DecoratorPatternCell
//
//  Created by LiTengFang on 2017/7/18.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

struct CellModel {
    var title: String?
    var imageName: String?
    var response: () -> Void
    
}


class DetailTableViewController: UITableViewController {
    
    
    enum Style {
        case `default`
        case blue
        case whiteAndShodow
        case custom
        case loadXib
        case loadNormalView
        
        var rowHeight: CGFloat {
            switch self {
            case .default:
                return 44
            case .blue:
                return 80
            case .whiteAndShodow:
                return 70
            case .custom:
                return 80
            case .loadXib:
                return 110
            case .loadNormalView:
                return 60
                
            }
        }
        
        
        var separatorStyle: UITableViewCellSeparatorStyle {
            switch self {
            case .default, .loadNormalView:
                return .singleLine
            default:
                return .none
            }
        }
        
        
        
        var borderStyle: DecoratorCell.BorderCellStyle {
            switch self {
            case .default:
                return .default
            case .blue:
                return .blue
            case .whiteAndShodow:
                return .whiteAndShodow
            case .custom:
                return .custom(DecoratorCell.BorderCellStyleModel(backGroundColor: UIColor.red, cornerRadius: 5, inset: UIEdgeInsetsMake(5, 5, 5, 5), shodow: nil))
            case .loadXib:
                return .blue
            case .loadNormalView:
                return .default
                
            }
        }
    }
    
    let cellStyle: Style
    
    func  getDecoratorCell(cell: UITableViewCell) -> DecoratorCell {
        
        
        return DecoratorCell(reuseIdentifier: "reuseIdentifier",
                             contextCell: cell,
                             borderStyle: cellStyle.borderStyle)
    }
    
    
    fileprivate var dataSouce: [CellModel]!
    
    
    init(style: UITableViewStyle, cellStyle: Style) {
        self.cellStyle = cellStyle
        super.init(style: style)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        tableView.rowHeight = cellStyle.rowHeight
        tableView.separatorStyle = cellStyle.separatorStyle
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSouce.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func contentCell() -> UITableViewCell {
            switch cellStyle {
            case .loadXib:
                
                tableView.register(UINib(nibName: "ConsumptionCell", bundle: nil), forCellReuseIdentifier: "cell")
                return tableView.dequeueReusableCell(withIdentifier: "cell")!
            default:
                return SystemDefaultStyleCell(style: .default, reuseIdentifier: "cell")
            }
        }
        
        var aAndroidStyleCell: DecoratorCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! DecoratorCell?
        if aAndroidStyleCell == nil {
            
            switch cellStyle {
            case .loadNormalView:
          
                aAndroidStyleCell = DecoratorCell(reuseIdentifier: "reuseIdentifier", contextView: NormalView(frame: CGRect.zero))
            default:
                let cell = contentCell()
                
                aAndroidStyleCell = getDecoratorCell(cell: cell)
            }
            
        }
        
        
        switch cellStyle {
        case .loadXib: break
        case .loadNormalView: break
            
        default:
            let cell: SystemDefaultStyleCell = aAndroidStyleCell!.contextCell as! SystemDefaultStyleCell
            // Configure the cell...
            cell.titleLabel.text = dataSouce[indexPath.row].title
            if let imageName = dataSouce[indexPath.row].imageName {
                cell.aImageView.image = UIImage(named: imageName)
            }
        }
        
        
        
        
        return aAndroidStyleCell!
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSouce[indexPath.row].response()
    }
    
    
    
    
    
}
