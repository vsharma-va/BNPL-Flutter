class cSms:
    def __init__(self, cursor):
        self.cursor = cursor
        
    def storeSms(self, accSerno, sender, body, datetimestamp):
        lsSender = sender.replace('\\', '').replace('[', '').replace(']', '').split(',')
        # lsBody = body.replace('\\', '').replace('[', '').replace(']', '').split(',')
        lsBody = [x for x in range(len(lsSender))]
        datetimestamp = [x for x in range(len(lsSender))]
        for i in range(len(lsSender)):
            self.cursor.execute(f'INSERT INTO slopay.cSms VALUES({int(accSerno)}, "{lsSender[i]}", "{lsBody[i]}", "{datetimestamp[i]}")')
