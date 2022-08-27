

class Solution {
    
    /// ip addressee
     var ipAddresses: [String] = []
    
    /**
     Restore ip addresses
     - Parameter s: string
     - Returns: string arrey of valid ip addresses
     */
    func restoreIpAddresses(_ s: String) -> [String] {
        
        // check if string is valid
       if s.count < 4 || s.count > 12 {
            return []
        }
        
        // IP generator
        self.ipGenerator(s: s, ipParts: [], dotsLeft: 3) // ex: ipGenerator("101023", [], 3)
        
        // Return
        return ipAddresses
    }
     
    /**
     IP generator
     - Parameter s: string
     - Parameter ipParts: string array contains ip address parts
     - Parameter dotsLeft: number of dots left
     */
   func ipGenerator(s: String, ipParts: [String], dotsLeft: Int) {
        
        // string is empty
        guard !s.isEmpty else {return}
        
        // dots
        let dots = dotsLeft
       
        // ip parts
        var ipParts = ipParts
        
        // no dots left
        if dots < 0 {
            return
        }
        
        // Ready to create complete ipAddress
        if dots == 0 && ipParts.count == 3 { // ex: ["10", "1","2"]  , s = "3"  -> 10.1.2.3
            
            // final part is valid ex: 3 is valid
            if self.isValid(s) {
                
                // append the final part
                ipParts.append(s)
                
                // join arry to one string separated by dots, then append ipAddress to ipAddresses array
                self.ipAddresses.append(ipParts.joined(separator: "."))
            }
            return
        }
        
        let end = min(3, s.count)
        
        for i in 1...end {
            
            // Divide string into two parts
            
            // get first part
            let index = s.index(s.startIndex, offsetBy: i)
            let firstPart = String(s.prefix(upTo: index))  // "1"
            
            // Second part
            let index2 = s.index(s.endIndex, offsetBy: -(s.count - i))
            let secondPart = String(s.suffix(from: index2)) // "01023"
            
            // check if first part is valid
            if !self.isValid(firstPart) {
                break
            }
            
            // append first part to array
            ipParts.append(firstPart)
            
            // call ipGenerator
            self.ipGenerator(s: secondPart, ipParts: ipParts, dotsLeft: dots - 1)
            
            // remove last item
            ipParts.removeLast()
        }
        
    }
    
    /**
     is vaild ip part
     - Parameter str: string represent ip address part
     - Returns: Bool
     */
    func isValid(_ str: String) -> Bool{
        
        // length check
        if str.count == 0 || str.count > 3 {
            return false
        }
        
        //check if has zero leading
        if(str.count > 1 && str.first == "0") {
            return false;
        }
            
        // check value in range 0 - 255
        if(Int(str)! > 255){
            return false;
        }
     
        return true;
    }
}


// 101023 :

// 1 : 01023   , 10 : 1023  , 101 : 023



