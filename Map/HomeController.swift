//
//  HomeController.swift
//  Map
//
//  Created by John Lima on 13/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    // MARK: - Properties
    @IBOutlet fileprivate weak var tableView: UITableView?
    
    fileprivate var tableData = MapType.getData()
    fileprivate let cellName = "cell"
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        updateUI()
    }
    
    // MARK: - Actions
    fileprivate func getData() {
        guard tableData.count == 0 else { return }
        tableData = MapType.getData()
    }
    
    fileprivate func updateUI() {
        let footer = UIView(frame: .zero)
        tableView?.tableFooterView = footer
        tableView?.backgroundColor = .white
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row].name
        cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.6843193173, blue: 0.340331614, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: tableData[indexPath.row].identifier ?? "", sender: indexPath)
    }
}

extension HomeController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case Segue.userLocation:
            guard let indexPath = sender as? IndexPath else { break }
            let controller = segue.destination as? UserLocationViewController
            controller?.mapType = tableData[indexPath.row]
        case Segue.customPin:
            guard let indexPath = sender as? IndexPath else { break }
            let controller = segue.destination as? CustomPinViewController
            controller?.mapType = tableData[indexPath.row]
        default:
            break
        }
    }
}

