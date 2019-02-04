//
//  MyView.swift
//  TestProject
//
//  Created by Анастасия Соколан on 25.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

class MyView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet var view: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("MyView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let button = UIButton(type: UIButtonType.roundedRect)
        button.backgroundColor = UIColor.blue
        
        //let rect = CGRect(x: 33.5, y: 22.5, width: 5, height: 5)
        let p = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        let rect = CGRect(origin: CGPoint(), size: CGSize(width: 15, height: 15))
        button.frame = rect
        button.center = p
        view.addSubview(button)
        
        if let im = UIImage(named: "icon8")
        {
            let uiIm = UIImageView(image: im)
            uiIm.tintColor = UIColor.green
            //uiIm.backgroundColor = UIColor.green
            view.addSubview(uiIm)
        } else
        { print ("Unsuccess!") }
        /*
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 64),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        */
    }
}
