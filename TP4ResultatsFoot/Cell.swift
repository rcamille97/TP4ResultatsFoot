//
//  Cell.swift
//  TP4ResultatsFoot
//
//  Created by Camille on 24/10/2019.
//  Copyright © 2019 Camille Rubio. All rights reserved.
//

import UIKit

class Cell : UITableViewCell {


    let scoreLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()

    let domLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    let extLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        lbl.font = lbl.font.withSize(12)
        return lbl
    }()
    
    let domLogo : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let extLogo : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        domLabel.autoresizingMask = [.flexibleWidth]
        extLabel.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin]
        scoreLabel.autoresizingMask = [.flexibleHeight]
        dateLabel.autoresizingMask = [.flexibleWidth]
        domLogo.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        extLogo.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        domLogo.translatesAutoresizingMaskIntoConstraints = false
        extLogo.translatesAutoresizingMaskIntoConstraints = false
        extLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        domLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(extLabel)
        addSubview(scoreLabel)
        addSubview(domLabel)
        addSubview(dateLabel)
        addSubview(domLogo)
        addSubview(extLogo)

        let scoreWidth = CGFloat(60)
        let labels = [
            "score" : scoreLabel,
            "domLabel" : domLabel,
            "extLabel" : extLabel,
            "dateLabel" : dateLabel,
            "extLogo" : extLogo,
            "domLogo" : domLogo
        ]
        
        let metrics = ["padding": 10, "scoreWidth": scoreWidth]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[dateLabel]|", options: [], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[domLogo(==40)]-[domLabel(==100)]-[score(==scoreWidth)]-[extLabel(==domLabel)]-[extLogo(==domLogo)]-|", options: [.alignAllCenterY], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[score]-|", options: [], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[extLabel]-|", options: [], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dateLabel]-[domLabel]-|", options: [], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dateLabel]-[domLogo(==extLogo)]-|", options: [], metrics: metrics, views: labels))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[extLogo(==domLogo)]-|", options: [], metrics: metrics, views: labels))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
