#include <iostream>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;



int main(void)
{

    Environment* env = nullptr;
    Connection* conn = nullptr;

    string login = "dbs211_223zbb31";
    string password = "46448057";
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(login, password, constr);

        // QUESTION 1

        // Initializes statment to nullptr
        Statement* stmt = nullptr;

        // call method createStatement() to create an statement object
        stmt = conn->createStatement("SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension FROM dbs211_employees e JOIN dbs211_offices o ON o.officecode = e.officecode WHERE o.city = 'San Francisco' ORDER BY e.employeenumber");
        stmt->executeQuery(); //esecutes the query

        // Initializes the result set to nullptr
        ResultSet* rs = nullptr;
        // store the result set
        rs = stmt->executeQuery();

        //If not result set
        if (!rs->next()) {
            // returns the result set is empty
            cout << "ResultSet is empty." << endl;
        }
        else {
            // if the result set in not empty
            int width = 14;
            cout << "Question 1" << endl;
            do {

                int employeenum = rs->getInt(1);
                string firstname = rs->getString(2);
                string lastname = rs->getString(3);
                string phone = rs->getString(4);
                string extension = rs->getString(5);

                cout.width(width);
                cout << left << employeenum;
                cout.width(width + 5);
                cout << left << firstname;
                cout.width(width + 5);
                cout << left << lastname;
                cout.width(width + 5);
                cout << left << phone;

                cout << left << extension;
                cout << endl;

            } while (rs->next()); //if there is more rows, iterate
        }
        conn->terminateStatement(stmt); //ends the connection

        cout << endl;

        // Start of question 2//
        // QUESTION 2


        Statement* stmt2 = nullptr;
        // call method createStatement() to create an statement object
        stmt2 = conn->createStatement("SELECT t1.reportsto, t2.firstname, t2.lastname , t2.phone, t2.extension FROM(SELECT DISTINCT reportsto FROM dbs211_employees) t1 JOIN(SELECT employeenumber, firstname, lastname, o.phone, e.extension FROM dbs211_employees e JOIN dbs211_offices o ON o.officecode = e.officecode) t2 ON t1.reportsto = t2.employeenumber ORDER BY t1.reportsto");
        stmt2->executeQuery();

        // define a reference to an object resultset
        ResultSet* rs2 = nullptr;
        // store the result set
        rs2 = stmt2->executeQuery();

        if (!rs2->next()) {
            // if the result set is empty
            cout << "ResultSet is empty." << endl;
        }
        else {
            // if the result set in not empty
            int width = 14;

            cout << "Question 2" << endl;
            do {

                int employeenum2 = rs2->getInt(1);
                string firstname2 = rs2->getString(2);
                string lastname2 = rs2->getString(3);
                string phone2 = rs2->getString(4);
                string extension2 = rs2->getString(5);

                cout.width(width);
                cout << left << employeenum2;
                cout.width(width + 5);
                cout << left << firstname2;
                cout.width(width + 5);
                cout << left << lastname2;
                cout.width(width + 5);
                cout << left << phone2;
                cout << left << extension2;
                cout << endl;

            } while (rs2->next()); //if there is more rows, iterate
        }
        // terminate connection for Question 2
        conn->terminateStatement(stmt2);

        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
    return 0;
}