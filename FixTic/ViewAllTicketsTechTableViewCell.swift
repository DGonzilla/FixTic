//
//  ViewAllTicketsTechTableViewCell.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/11/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit


protocol TableTechViewNew2 {
    func onClickCell2(index: Int)
}





class ViewAllTicketsTechTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var ticketStatusLabel: UILabel!
    
    
    var cellDelegate: TableTechViewNew2?
    var index: IndexPath?
    
    
    
    
    @IBAction func ticketMoreInfoArrowButton2(_ sender: UIButton) {
        print("More Info Button Pressed :))))")
    
        cellDelegate?.onClickCell2(index: (index?.row)!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
