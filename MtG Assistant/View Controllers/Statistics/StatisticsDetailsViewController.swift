//
//  StatisticsDetailsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsDetailsViewController: UIViewController {
    
    var statisticsDataSource = StatisticsDataSource()
    var data: StatisticsHeadline?
    var indexPathOfCell: IndexPath?
    var destinationTable: UITableView?
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var competitorsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var firstDeckLabel: UILabel!
    @IBOutlet weak var secondDeckLabel: UILabel!
    
    // -------------------------------------------------------------------
    // MARK: Share Statistics
    // -------------------------------------------------------------------
    
    @IBAction func shareStatistic(_ sender: UIBarButtonItem) {
        guard let data = data else { return }
        guard let mtgUrl = NSURL(string: "https://magic.wizards.com") else { return }
        
        let text =
        """
        Check out results of \(data.firstPlayer) and \(data.secondPlayer) playing MtG at \(data.date):
        
        Decks used: "\(data.firstPlayerDeck)" and "\(data.secondPlayerDeck)" accordingly.
        Result was: \(data.result) !
        
        Join us playing Magic The Gathering today: \(mtgUrl)
        """

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(
            activityItems: textToShare,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]

        self.present(activityViewController, animated: true, completion: nil)
    }

    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------

    private func commonInit() {
        guard let data = data else { return }
        competitorsLabel.text = data.firstPlayer + " / " + data.secondPlayer
        resultLabel.text = data.result
        gameDateLabel.text = data.date
        
        firstDeckLabel.text = data.firstPlayerDeck
        secondDeckLabel.text = data.secondPlayerDeck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // -------------------------------------------------------------------
    // MARK: - Segues Methods
    // -------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? UINavigationController else { return }
        guard let targetController = destinationVC.topViewController
            as? EditStatisticsViewController else { return }
        
        targetController.data = data
    }

}

extension StatisticsDetailsViewController {
    @IBAction func cancelUpdatingStatistics(_: UIStoryboardSegue) { }

    @IBAction func saveUpdatedStatistics(_ segue: UIStoryboardSegue) {
        guard
            let editStatisticsDetailsViewController = segue.source as? EditStatisticsViewController,
            let data = editStatisticsDetailsViewController.data
        else { return }
        
        guard let destinationTable = destinationTable else { return }
        self.destinationTable = destinationTable
        
        guard let indexPathOfCell = indexPathOfCell else { return }
        self.indexPathOfCell = indexPathOfCell
        
        statisticsDataSource.update(haedline: data, to: destinationTable, at: indexPathOfCell)
        
        self.data = data
        commonInit()
    }
    
}
