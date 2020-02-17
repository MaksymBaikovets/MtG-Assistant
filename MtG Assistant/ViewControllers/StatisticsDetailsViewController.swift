//
//  ViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsDetailsViewController: UIViewController {
//    @IBOutlet var detailsStatisticsTitle: UINavigationBar!
    
    @IBOutlet weak var competitorsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var firstDeckLabel: UILabel!
    @IBOutlet weak var secondDeckLabel: UILabel!
    
    var statisticsDataSource = StatisticsDataSource()
    var data: StatisticsHeadline?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        commonInit()
    }

    private func commonInit() {
        guard let data = data else { return }
        competitorsLabel.text = data.competitors
        resultLabel.text = data.result
        gameDateLabel.text = data.date
        
        firstDeckLabel.text = data.firstPlayerDeck
        secondDeckLabel.text = data.secondPlayerDeck

    }
    
    /*
     // MARK: Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
