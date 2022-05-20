from datetime import datetime

class cCustGeoLocation:
    def __init__(self, cursor):
        self.cursor = cursor
        
    def insertIntoTable(self, accSerno: int, name: str, street: str, isoCountryCode: str, locality: str, subThroughFare: str, throughfare: str, subLocality: str, postalCode: str, admistrativeArea: str, subAdministrativeArea: str):
        from datetime import datetime

        todaysDate = datetime.now()
        dateTime = todaysDate.strftime("%Y-%m-%d %H:%M:%S")
        
        dateTimeList = dateTime.split(' ')
        timeList = dateTimeList[1].split(':')
                    
                    
        timeList[0] = str(int(timeList[0]) + 5)
        if(int(timeList[0]) > 24):
            timeList[0] = str(int(timeList[0]) - 24)
        timeList[1] = str(int(timeList[1]) + 30)
        if(int(timeList[1]) > 59):
            timeList[0] = str(int(timeList[0]) + 1)
            if(int(timeList[0]) > 24):
                timeList[0] = str(int(timeList[0]) - 24)
            timeList[1] = str(int(timeList[1]) - 60)
            if(len(timeList[1]) != 2):
                timeList[1] = '0' + timeList[1]
            
        time = ':'.join(timeList)
        
        dateTime = dateTimeList[0] + ' ' + time
        
        self.cursor.execute(f'INSERT INTO slopay.cCustGeoLocation VALUES({int(accSerno)}, "{name}", "{street}", "{isoCountryCode}", "{locality}", "{subThroughFare}", "{throughfare}", "{subLocality}", "{postalCode}", "{admistrativeArea}", "{subAdministrativeArea}", "{dateTime}")')