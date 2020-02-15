//
//  ViewController.swift
//  HonestWeather
//
//  Created by Adam Siekierski on 09/02/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var WeatherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getWeather() -> Void {
        AF.request("api.openweathermap.org/data/2.5/weather?q=Poznan&appid=")
    }
}
