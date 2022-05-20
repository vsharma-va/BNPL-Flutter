class cAccount:
    def __init__(self, cursor):
        self.cursor = cursor

    def createNewAccount(self, userId: str, balance: float, collectionSerno: str, accStatus: str):
        self.cursor.execute(f'INSERT INTO slopay.cAccounts (userID, balance, collectionSerno, accStatus) VALUES("{userId}", {float(balance)}, {int(collectionSerno)}, "{accStatus}")')
        rows = self.cursor.fetchall
        return rows
        
    def getAccSerno(self, userId: str):
        self.cursor.execute(f'select accSerno from slopay.cAccounts where userID = "{userId}"')
        rows = self.cursor.fetchall()
        if len(rows) == 0:
            return rows
        else:
            return rows[0]['accSerno']