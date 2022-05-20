import cInstallment

class cAmortization:
    def __init__(self, cursor):
        self.cursor = cursor
        
    def createAmortization(self, durationInMonths: int, accSerno: int):
        installment = cInstallment.cInstallment(self.cursor)
        instSerno = installment.genericSelectQuery('instSerno', int(accSerno))
        instTotalAmt = installment.genericSelectQuery('instTotalAmt', int(accSerno))
        instIntallmentPerMonth = float(instTotalAmt) / int(durationInMonths)
        
        for i in range(int(durationInMonths)):
            if i == 0:
                self.cursor.execute(f'INSERT INTO slopay.cAmortization (accSerno, instSerno, trxnSerno, instAmrtStatus, instSeq, instAmt, trxnStatus) VALUES({accSerno}, {instSerno}, -1, 0, {i+1}, {instIntallmentPerMonth}, "")')
            else:
                self.cursor.execute(f'INSERT INTO slopay.cAmortization (accSerno, instSerno, trxnSerno, instAmrtStatus, instSeq, instAmt, trxnStatus) VALUES({accSerno}, {instSerno}, -1, -1, {i+1}, {instIntallmentPerMonth}, "")')
        rows = self.cursor.fetchall()
        return rows