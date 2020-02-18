//
//  WeatherDescriptions.swift
//  HonestWeather
//
//  Created by Adam Siekierski on 16/02/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import SwiftyJSON

class WeatherDescriptions {
  static func shortDescription(weather: JSON) -> String {
    var description = ""
    switch weather["main"]["feels_like"] {
      case let x where x < 0:
        description = "Tak nakurwia że dupę odmraża"
        break
      case let x where x <= 5:
        description = "Piździ w chuj"
        break
      case let x where x <= 10:
        description = "Chłodno, generalnie nie polecam"
        break
      case let x where x <= 15:
        description = "Chyba ktoś ogrzewanie zapomniał włączyć"
        break
      default:
        description = "Ni w dupe ni w oko"
        break
    }
    return description
  }
}
