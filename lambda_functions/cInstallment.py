from datetime import datetime

class cInstallment:
    def __init__(self, cursor):
        self.cursor = cursor 
        
    def createInstallment(self, instType: int, cAccSerno: int, instOrigAmount: float, instPrincipalAmount: float, 
        instTrxnSerno: int, outstandingAmt: float, instStatus: str, interestPercentage: float, 
        instNoMonths: int):
            
        instInterestAmt = float(instPrincipalAmount) * float(interestPercentage)
        instTotalAmt = float(instInterestAmt) * int(instNoMonths) + float(instPrincipalAmount)
        
        todaysDate = datetime.now()
        date = todaysDate.strftime("%Y-%m-%d")
        
        self.cursor.execute(f'INSERT INTO slopay.cInstalment (instType, cAccSerno, instOrigAmount, instPrincipalAmt, instTotalAmt, instInterestAmt, instTrxnSerno, outstandingAmt, instStatus, instNoSeq, instCurrSeq, instInsepDate) VALUES({int(instType)}, {int(cAccSerno)}, {float(instOrigAmount)}, {float(instPrincipalAmount)}, {float(instTotalAmt)}, {float(instInterestAmt)}, {int(instTrxnSerno)}, {float(outstandingAmt)}, "{instStatus}", {int(instNoMonths)}, 1, "{date}")')    
        
        rows = self.cursor.fetchall()
        return rows
    
    def genericSelectQuery(self, what: str, accSerno: int):
        self.cursor.execute(f'SELECT {what} FROM cInstalment WHERE cAccSerno = {accSerno}')
        rows = self.cursor.fetchall()
        return rows[0][f'{what}']