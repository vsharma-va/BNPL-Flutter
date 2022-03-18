class cInstallmentPlan:
    def __init__ (self, cursor):
        self.cursor = cursor
        
    def getPlanTenure(self, instPlanSerno: int):
        self.cursor.execute(f"Select instPlanTenure from cInstalmentPlan where instPlanSerno = {instPlanSerno}")
        result = self.cursor.fetchall()
        return result[0]['instPlanTenure']
        
    def getPlanInterestRate(self, instPlanSerno: int):
        self.cursor.execute(f"Select instPlanPercnt from cInstalmentPlan where instPlanSerno = {instPlanSerno}")
        result = self.cursor.fetchall()
        return result[0]['instPlanPercnt']