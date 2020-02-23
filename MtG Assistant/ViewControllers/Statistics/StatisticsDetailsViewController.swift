//
//  ViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsDetailsViewController: UIViewController {
    
    var statisticsDataSource = StatisticsDataSource()
    var data: StatisticsHeadline?
    
    @IBOutlet weak var competitorsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var firstDeckLabel: UILabel!
    @IBOutlet weak var secondDeckLabel: UILabel!
    
    @IBAction func shareStatistic(_ sender: UIBarButtonItem) {
        guard let data = data else { return }

        // text to share
        guard let mtgUrl = NSURL(string: "https://magic.wizards.com") else { return }
        
        let text =
        """
        Check out results of \(data.competitors) playing MtG at \(data.date):
        
        Decks used: "\(data.firstPlayerDeck)" and "\(data.secondPlayerDeck)" accordingly.
        Result was: \(data.result) !
        
        Join us playing Magic The Gathering today: \(mtgUrl)
        """

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
