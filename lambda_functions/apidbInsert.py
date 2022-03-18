class InsertIntoDb:
    def __init__(self, cursor):
        self.cursor = cursor
        
    def insertIntoCUser(self, userId: str, userName: str, userEmail: str, userMobileNo: str, userAge: int, userCast: str):
#         INSERT INTO table_name (column1, column2, column3, ...)
# VALUES (value1, value2, value3, ...); 
        self.cursor.execute(f'INSERT INTO slopay.cUser VALUES("{userId}", "{userName}", "{userEmail}", {int(userMobileNo)}, {int(userAge)}, "{userCast}")')
        rows = self.cursor.fetchall()
        return rows