import pymysql
import json
import apidbInsert
import cAccount
import cInstallment
import cInstallmentPlan
import cAmortization
import os


#establish connection
connection = pymysql.connect(host=os.environ['endpoint'],
                             user=os.environ['user_name'],
                             password=os.environ['password'],
                             database=os.environ['database_name'],
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)


def lambda_handler(event, context):
    cursor = connection.cursor()
    if(event['name'] == 'insertcUser'):
        insertClass = apidbInsert.InsertIntoDb(cursor)
        query = insertClass.insertIntoCUser(event['userId'], event['userName'], event['userEmail'], event['userMobileNo'], event['userAge'], event['userCast'])
        connection.commit()
        return {'status': 'Success'}
    
    if(event['name'] == 'createNewAccount'):
        cAccountClass = cAccount.cAccount(cursor)
        query = cAccountClass.createNewAccount(event['userId'], event['balance'], event['collectionSerno'], event['accStatus'])
        connection.commit()
        return {'status': 'Success'}
        
    if(event['name'] == 'getAccSerno'):
        cAccountClass = cAccount.cAccount(cursor)
        query = cAccountClass.getAccSerno(event['userId'])
        return query
        
    if(event['name'] == 'createInstallment'):
        cInstallmentClass = cInstallment.cInstallment(cursor)
        # instType: int, cAccSerno: int, instOrigAmount: float, instPrincipalAmount: float, 
        # , instTrxnSerno: int, outstandingAmt: float, instStatus: str, interestPercentage: float, 
        # instNoMonths: int
        query = cInstallmentClass.createInstallment(event['instType'], event['cAccSerno'], event['instOrigAmount'],
            event['instPrincipalAmount'], event['instTrxnSerno'], event['outstandingAmt'], event['instStatus'], 
            event['interestPercentage'], event['instNoMonths'])
        connection.commit()
        return {'status':'Success'}
        
    if(event['name'] == 'selectInstalmentPlan'):
        cInstallmentPlanClass = cInstallmentPlan.cInstallmentPlan(cursor)
        tenure = cInstallmentPlanClass.getPlanTenure(event['instPlanSerno'])
        interestRate = cInstallmentPlanClass.getPlanInterestRate(event['instPlanSerno'])
        return [tenure, interestRate]
        
    if(event['name'] == 'createAmortization'):
        cAmortizationClass = cAmortization.cAmortization(cursor)
        cAmortizationClass.createAmortization(event['durationInMonths'], event['accSerno'])
        connection.commit()
        return {'status': 'Success'}
    else:
        return {"status": "Failed"}