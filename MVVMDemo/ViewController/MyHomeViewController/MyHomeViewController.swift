//
//  MyHomeViewController.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import UIKit

class MyHomeViewController: UIViewController {
    
    /// 建立tableView
    private lazy var myTableView: UITableView = {
        let myTableView = UITableView()
        return myTableView
    }()
    
    /// 取得ViewModel
    private lazy var homeViewModel: HomeViewMode = {
       let homeViewModel = HomeViewMode()
        return homeViewModel
    }()

    // MARK: - 生命週期
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setComboTravel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNetworkData()
    }
    
    // MARK: - set
    
    /// 設定tableView
    private func setupTableView() {
        myTableView.dataSource = self
        
        myTableView.register(HomeViewControllerCell.self, forCellReuseIdentifier: "\(HomeViewControllerCell.self)")
        settingTableViewConsraint()
    }
    
    /// 設定國外套裝
    func setComboTravel() {
        let builder = TravelBuilder()
        let packing = builder.makeInbound()
        let coust = packing.getTravelPackingsCost()
        packing.showAllTravelPackings()
        print("套裝總價: \(coust)")
    }
    
    // MARK: - other func
    
    /// 打api取得資料
    func getNetworkData() {
        
        // alamofire打api方式
//        homeViewModel.getTravelData {
//            DispatchQueue.main.async {
//                self.myTableView.reloadData()
//            }
//        }
        
        
        // 原生打api方式
        homeViewModel.getNetworkData { result in
            
            switch result {
                
            case .success(_):
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            case .failure(_):
                // TODO: 處理error
                print("處理error")
            }
        }
    }
    
    // MARK: - constraint
    
    /// 設定TableView 位置
    private func settingTableViewConsraint() {
        view.addSubview(myTableView)
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 10).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension MyHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeViewModel.travelDateCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "\(HomeViewControllerCell.self)", for: indexPath) as? HomeViewControllerCell,
              let item = homeViewModel.getData(indexPath: indexPath),
              let name = item.name else {
            print("get myTableView fail")
            return UITableViewCell()
        }
        
        // 取得indexPath的資料
        cell.myConvert(text: name)
        
        return cell
    }
}
