//
//  CheckoutViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 20/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class CheckoutViewModel {
    var observableCardNumber = BehaviorRelay<String>(value: "")
    var observableExpDate = BehaviorRelay<String>(value: "")
    var observableCVV = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
}

// MARK: Validation.
extension CheckoutViewModel {
    
    //Remove spaces and check for the length
    func validate(cardText: String?) -> Bool {
        guard let cardText = cardText else {
          return false
        }
        let noWhitespace = cardText.removingSpaces
        
        //advanceIfNecessary(noSpacesCardNumber: noWhitespace)
        return noWhitespace.count == 12
    }
    
    //Checks if valid month and year
    func validate(expirationDateText expiration: String?) -> Bool {
      guard let expiration = expiration else {
        return false
      }
      let strippedSlashExpiration = expiration.removingSlash
      
      formatExpirationDate(using: strippedSlashExpiration)
      //advanceIfNecessary(expirationNoSpacesOrSlash:  strippedSlashExpiration)
      
      return strippedSlashExpiration.isExpirationDateValid
    }
    
    //Check if all characters are numbers and length of the string
    func validate(cvvText cvv: String?) -> Bool {
      guard let cvv = cvv else {
        return false
      }
      guard cvv.areAllCharactersNumbers else {
        return false
      }
      return cvv.count == 3
    }
    
    func formatExpirationDate(using expirationNoSpacesOrSlash: String) {
        //observableExpDate.value = expirationNoSpacesOrSlash.addingSlash
    }
}
