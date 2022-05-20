class cInstallmentPlan:
    def __init__ (self, cursor):
        self.cursor = cursor
        
    def getNumberOfPlans(self):
        self.cursor.execute(f"Select Count(*) From slopay.cInstalmentPlan")
        result = self.cursor.fetchall()
        return result[0]['Count(*)']
        
    def getPlanTenure(self, instPlanSerno: int):
        self.cursor.execute(f"Select instPlanTenure from slopay.cInstalmentPlan where instPlanSerno = {instPlanSerno}")
        result = self.cursor.fetchall()
        return result[0]['instPlanTenure']
        
    def getPlanInterestRate(self, instPlanSerno: int):
        self.cursor.execute(f"Select instPlanPercnt from slopay.cInstalmentPlan where instPlanSerno = {instPlanSerno}")
        result = self.cursor.fetchall()
        return result[0]['instPlanPercnt']